from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import Camera,CameraStream,Face,FaceImg
from apps.users.serializers import CameraSerializer,CameraStreamSerializer,StreamSerializer,CameraRealtimeSerializer
from rest_framework import serializers
from apps.users.utility import TokenVerify
from apps.users.models import CameraStream as CameraStreamModel
from apps.users.models import CameraRealtime as CameraRealtimeModel
from django.conf import settings
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync
import os,json
import cv2
import datetime
import paramiko
import configparser

class CameraView(APIView):

    @TokenVerify
    def post(self,request,*args,**kwargs):
        print("now camera new post!!!!!!!!!!!!!!!!!!!!")
        serializer = CameraSerializer(data=request.data)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    @TokenVerify
    def put(self,request,*args,**kwargs):
        camera = Camera.objects.get(pk = request.data['id'])
        serializer = CameraSerializer(camera, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    def delete(self,request,*args,**kwargs):
        ids = request.data
        for id in ids:
            camerarcv= Camera.objects.get(id=id).delete()
        return JsonResponse(data={}, code='999999', msg='成功')


    @TokenVerify
    def get(self,request,*args,**kwargs):
        print("now camera new get!!!!!!!!!!!!!!!!!!!!")
        cameraid = request.GET.get('id')
        cameraname = request.GET.get('cameraname')
        print("now camera new get!!!!!!!!!!!!!!!!!!!!")
        print(cameraid)
        print(type(cameraid))
        if cameraid != None and cameraid != '':
            ####获取单个camera的信息修改时调用###
            print(cameraid)
            cameras = Camera.objects.get(pk=cameraid)
            serializer = CameraSerializer(cameras)
            return JsonResponse(data=serializer.data, code='999999', msg='success')

        if cameraname !=None and cameraname !='':
            ###查询###
            cameras = Camera.objects.filter(cameraname__contains=cameraname)
            serializer = CameraSerializer(cameras,many=True)
            return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999',
                                msg='success')
        ###获取所有camera信息###
        cameras = Camera.objects.all()
        serializer = CameraSerializer(cameras, many=True)
        return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999',
                            msg='success')



class CameraStream(APIView):
    # @TokenVerify
    def post(self,request,*args,**kwargs):
        print("now camerastream new post!!!!!!!!!!!!!!!!!!!!")
        print(request.data)
        # cameraid = request.data['cameraId']
        # camera = Camera.objects.get(pk=int(cameraid))
        streamurl_value = request.data['streamUrl']
        start_time = request.data['startTime']
        start_time=datetime.datetime.strptime(start_time, "%Y-%m-%d %H:%M:%S")
        cap = cv2.VideoCapture(streamurl_value)
        if cap.isOpened():  # 当成功打开视频时cap.isOpened()返回True,否则返回False
            rate = cap.get(5)  # 帧速率
            frame_number = cap.get(7)  # 视频文件的帧数
            seconds = frame_number / rate
            rate = ("%.1f" % rate)
            seconds = ("%.1f" % seconds)
            streamfps_value = str(rate)
            streamtime_value = str(seconds)
            print("1111111111111111111111111111111111111111")
            # request.data['cameraId'] = camera
            request.data['streamTime'] = streamtime_value
            request.data['streamFps'] = streamfps_value
            request.data['startTime'] = start_time
            print(request.data)
            # cameraStreamModel = CameraStreamModel(cameraId=camera,streamUrl=streamurl_value,streamTime=streamtime_value,streamFps=streamfps_value,streamStatus=request.data['streamStatus'],startTime=request.data['startTime'])
            # cameraStreamModel.save()
            # return JsonResponse(data={}, code='999999', msg='success')
            serializers = CameraStreamSerializer(data = request.data)
            #cameraStreamModel = CameraStreamModel(streamurl=streamurl_value,cameraid =camera,streamfps = streamfps_value,streamtime = streamtime_value,streamstatus='0',starttime = start_time)
            #print(cameraStreamModel)
            if serializers.is_valid():
                serializers.save()
                return JsonResponse(data={}, code='999999',msg='success')
            return JsonResponse(data=serializers.errors, code="999999", msg="失败")
        return JsonResponse(data={}, code="-1", msg="failed")

    def get(self,request,*args,**kwargs):
        print("now camerastream get !!!!!!!!!!!!!!!!!!!!!!!!!")
        cameraid = request.GET.get('cameraId')
        # camera = Camera.objects.get(pk = cameraid)
        camerastreams = CameraStreamModel.objects.all()
        camerastreams = camerastreams.filter(cameraId_id=int(cameraid))
        print(camerastreams)
        serializers = CameraStreamSerializer(camerastreams,many=True)
        return JsonResponse(data=serializers.data, code='999999', msg='success')

class CameraRecord(APIView):
    def post(self,request,*args,**kwargs):
        print('colin: new')
        print(request.data)
        print(request.data['cameraId'])
        cameraId = request.data['cameraId']
        camera = Camera.objects.get(pk = cameraId)
        serializer = CameraSerializer(camera)
        print(serializer.data)
        print(serializer.data['c_token'])
        filepath = settings.CAMERA_RECORD_BASE_URL + serializer.data['c_token']
        file_list = getfilelist(filepath)
        print((file_list[0]))
        stream_data = {}
        for i in range(0, len(file_list)):
            #print(file_list[i])
            stream_data['streamname'] =  str(i) + '-' + file_list[i].split(serializer.data['c_token'])[1]
            stream_data['streamlocation'] = serializer.data['cameraName'] + serializer.data['cameraLocation']
            stream_data['streamurl'] = settings.RECORD_ROOT_URL + file_list[i].split('record/')[1]
            stream_data['streamlat'] = serializer.data['cameraLat']
            stream_data['streamlon'] = serializer.data['cameraLon']
            stream_data['flag'] = '0'
            stream_data['streamstatus'] = '0'
            cap = cv2.VideoCapture(file_list[i])
            if cap.isOpened():  # 当成功打开视频时cap.isOpened()返回True,否则返回False
                rate = cap.get(5)  # 帧速率
                frame_number = cap.get(7)  # 视频文件的帧数
                seconds = frame_number / rate
                rate = ("%.1f" % rate)
                seconds = ("%.1f" % seconds)
                streamfps_value = str(rate)
                streamtime_value = str(seconds)
            stream_data['streamfps'] = streamfps_value
            stream_data['streamtime'] = streamtime_value
            stream_serializer = StreamSerializer(data=stream_data)
            if stream_serializer.is_valid():
                stream = stream_serializer.save()
            print(stream_serializer.data)

        return JsonResponse(data=serializer.data, code="999999", msg="成功")
    def get(self,request,*args,**kwargs):
        print('colin: new')
        print(request.data)
        return JsonResponse(data={}, code="999999", msg="成功")

class CameraRecordForCS(APIView):
    def post(self,request,*args,**kwargs):
        print('colin: new')
        print(request.data)
        print(request.data['cameraId'])
        cameraId = request.data['cameraId']
        camera = Camera.objects.get(pk = cameraId)
        serializer = CameraSerializer(camera)
        print(serializer.data)
        print(serializer.data['c_token'])
        filepath = settings.CAMERA_RECORD_BASE_URL + serializer.data['c_token']
        file_list = getfilelist(filepath)
        print((file_list[0]))
        stream_data = {}
        stream_data['cameraId'] = cameraId
        for i in range(0, len(file_list)):
            print('------0-000-----')
            stream_data['startTime'] = file_list[i].split(serializer.data['c_token'])[1]
            stream_data['label'] = serializer.data['cameraName'] + serializer.data['cameraLocation']
            stream_data['streamUrl'] = settings.RECORD_ROOT_URL + file_list[i].split('record/')[1]
            stream_data['flag'] = '0'
            stream_data['streamStatus'] = '0'
            cap = cv2.VideoCapture(file_list[i])
            if cap.isOpened():  # 当成功打开视频时cap.isOpened()返回True,否则返回False
                rate = cap.get(5)  # 帧速率
                frame_number = cap.get(7)  # 视频文件的帧数
                seconds = frame_number / rate
                rate = ("%.1f" % rate)
                seconds = ("%.1f" % seconds)
                streamfps_value = str(rate)
                streamtime_value = str(seconds)
            stream_data['streamFps'] = streamfps_value
            stream_data['streamTime'] = streamtime_value
            serializers = CameraStreamSerializer(data = stream_data)
            if serializers.is_valid():
                stream = serializers.save()
            print('dddddataeddd')
            print(serializers.data)
        return JsonResponse(data=serializers.data, code="999999", msg="成功")
    def get(self,request,*args,**kwargs):
        print('colin: new')
        print(request.data)
        return JsonResponse(data={}, code="999999", msg="成功")

class CameraWS(APIView):
    def post(self,request,*args,**kwargs):
        print(request.data)
        print("1111111111111111111111")
        buf = request.data.copy()
        #buf['cameraid'] = str(Camera.objects.filter(c_ip= buf['cameraip']).values('id')[0]['id'])
        buf['imgurl'] = settings.FACE_IMG_CHECK_ROOT_URL+buf['imgurl']
        print("1111111111111111111111")
        print(buf)
        serializer = CameraRealtimeSerializer(data=buf)
        if serializer.is_valid():
            serializer.save()
        channel_layer = get_channel_layer()
        #c_token = 'token112'
        c_token = Camera.objects.get(pk = int(buf['cameraid'])).c_token
        conf_file = settings.CONF_FILE
        config = configparser.ConfigParser()
        print('--------11111----123432------')
        print(c_token)
        config.read(conf_file,encoding="utf-8")
        print('--------11111----------')
        print(config['camera_detect_token']['c_token'])
        if c_token == config['camera_detect_token']['c_token']:
            buf['faceurl'] = FaceImg.objects.filter(userid_id=int(buf['faceid'])).values('imgurl')[0]['imgurl']
            buf['count'] = len(CameraRealtimeModel.objects.filter(cameraid=str(buf['cameraid'])).values('faceid').distinct())
            result_all = json.dumps(buf)
            async_to_sync(channel_layer.group_send)(c_token, {"type": "user.message", 'text': result_all})
            #async_to_sync(channel_layer.send)(c_token, {"type": "user.message", 'text': result_all})
            print('--------2222222----------')
        print('memememmeeeeeeee')
        return JsonResponse(data={}, code="999999", msg="成功")

class CameraReal(APIView):
    def post(self,request,*args,**kwargs):
        print('hello exec detect--------------')
        print(request.data)
        print(request.data['c_id'])
        print(request.data['c_token'])
        conf_file = settings.CONF_FILE
        config = configparser.ConfigParser()
        config.read(conf_file,encoding="utf-8")
        cameraId = request.data['c_id']
        cameraToken = request.data['c_token']
        print(cameraToken)
        #camera = Camera.objects.get(pk = cameraId)
        #serializer = CameraSerializer(camera)
        #config["camera_detect_token"] = serializer.data['c_token']
        config["camera_detect_token"] = request.data
        config.write(open(conf_file,mode='w'))
        return JsonResponse(data={'e':''}, code="999999", msg="成功")

def rtsp_result(c_token,hostname,port,username,password,private,tail):
    channel_layer = get_channel_layer()
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    if password:
        ssh.connect(hostname=hostname, port=port, username=username,password=password)
    else:
        pkey = paramiko.RSAKey.from_private_key_file(private)
        ssh.connect(hostname=hostname, port=port, username=username, pkey=pkey)
    cmd = "sh " + tail
    print(cmd)
    stdin, stdout, stderr = ssh.exec_command(cmd)
    print('99990000999999')
    for line in iter(stdout.readline, ""):
        result = {"status": 0, 'data': line}
        print(result)
        result_all = json.dumps(result)
        print("hello nihao aaaaa")
        async_to_sync(channel_layer.group_send)(c_token, {"type": "user.message", 'text': result_all})

    result_all = 'mmmdddd!fu'
    async_to_sync(channel_layer.group_send)(c_token, {"type": "user.message", 'text': result_all})

#遍历文件及子文件的所有文件
def getfilelist(filepath):
    filelist = os.listdir(filepath)
    files = []
    for i in range(len(filelist)):
        child = os.path.join('%s/%s' % (filepath, filelist[i]))
        if os.path.isdir(child):
            files.extend(getfilelist(child))
        else:
            if '.mp4' in child:
                files.append(child)
    return files

cameras = CameraView.as_view()
camera_real = CameraReal.as_view()
camera_ws = CameraWS.as_view()
camera_stream = CameraStream.as_view()
camera_record = CameraRecord.as_view()
camera_record_for_cs = CameraRecordForCS.as_view()
