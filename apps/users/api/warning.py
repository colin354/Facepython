from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import WarningType,WarningEvent,Face
from apps.users.serializers import WarningTypeSerializer,WarningEventSerializer
from rest_framework import serializers
from apps.users.utility import TokenVerify
from django.conf import settings
import os,json
import datetime,time
import configparser

class WarningTypeView(APIView):

    @TokenVerify
    def post(self,request,*args,**kwargs):
        print("now warning type new post!!!!!!!!!!!!!!!!!!!!")
        print(request.data)
        serializer = WarningTypeSerializer(data=request.data)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        print("now warning type error post!!!!!!!!!!!!!!!!!!!!")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    @TokenVerify
    def put(self,request,*args,**kwargs):
        warningtype = WarningType.objects.get(pk = request.data['id'])
        serializer = WarningTypeSerializer(warningtype, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    def delete(self,request,*args,**kwargs):
        ids = request.data
        for id in ids:
            warningtype= WarningType.objects.get(id=id).delete()
        return JsonResponse(data={}, code='999999', msg='成功')


    @TokenVerify
    def get(self,request,*args,**kwargs):
        ###获取所有预警事件类型信息###
        warningtypeid = request.GET.get('id')
        if warningtypeid != None and warningtypeid != '': 
            warningtype = WarningType.objects.get(pk=warningtypeid)
            serializer = WarningTypeSerializer(warningtype)
            print(serializer.data)
            return JsonResponse(data=serializer.data,code='999999', msg='success')

        warningtype = WarningType.objects.all()
        serializer = WarningTypeSerializer(warningtype, many=True)
        return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999',
                            msg='success')

class WarningEventView(APIView):
    # @TokenVerify
    def post(self,request,*args,**kwargs):
        print("now warning event new post!!!!!!!!!!!!!!!!!!!!")
        print(request.data)
        request.data['warning_id'] = 'YJ编号' + str(int(round(time.time()*1000)))
        #if(request.data.__contains__('warning_target_people')):
        #    request.data['warning_target_people'] = '.'.join([str(x) for x in request.data['warning_target_people']])
        #if(request.data.__contains__('warning_target_car')):
        #    request.data['warning_target_car'] = '.'.join([str(x) for x in request.data['warning_target_car']])
        #if(request.data.__contains__('warning_target_camera')):
        #    request.data['warning_target_camera'] = '.'.join([str(x) for x in request.data['warning_target_camera']])
             
        serializer = WarningEventSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data={}, code="-1", msg="操作失败")

    @TokenVerify
    def delete(self,request,*args,**kwargs):
        ids = request.data
        for id in ids:
            warningevent= WarningEvent.objects.get(id=id).delete()
        return JsonResponse(data={}, code='999999', msg='成功')

    @TokenVerify
    def put(self,request,*args,**kwargs):
        print('----------------put------------------')
        print(request.data)
        if(request.data['warning_target_people'] == ""):
            print('here1')
            print(request.data['warning_target_people'])
            #request.data['warning_target_people'] = '.'.join([str(x) for x in request.data['warning_target_people']])
            request.data['warning_target_people'] = None
            print(request.data['warning_target_people'])
        if(request.data['warning_target_car'] == ""):
            print('here2')
            request.data['warning_target_car'] = None
            #request.data['warning_target_car'] = '.'.join([str(x) for x in request.data['warning_target_car']])
        if(request.data['warning_target_camera'] == ""):
            print('here3')
            request.data['warning_target_camera'] = None
            #request.data['warning_target_camera'] = '.'.join([str(x) for x in request.data['warning_target_camera']])
        warningevent = WarningEvent.objects.get(pk = request.data['id'])
        serializer = WarningEventSerializer(warningevent, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    @TokenVerify
    def get(self,request,*args,**kwargs):
        warningeventid = request.GET.get('id')
        if warningeventid != None and warningeventid != '': 
            warningevent = WarningEvent.objects.get(pk=warningeventid)
            serializer = WarningEventSerializer(warningevent)
            print(serializer.data)
            if(serializer.data['warning_target_people'] != None):
                person_ids = serializer.data['warning_target_people'].split('.')
                for i in person_ids:
                    face = Face.objects.get(pk=int(i))
                print(face.username)
            #serializer.data['warning_type'] = warningtype_serializer.data
            return JsonResponse(data=serializer.data,code='999999', msg='success')
        
        #如果默认参数里没有带id一类的，则返回全部数据，将来需要考分页及limit的限制
        print("now warning event get !!!!!!!!!!!!!!!!!!!!!!!!!")
        warningevent = WarningEvent.objects.all()
        serializer = WarningEventSerializer(warningevent, many=True)
        result_list = serializer.data
        for i in range(len(serializer.data)):
            print(serializer.data[i]['warning_target_people'])
            warningtype = WarningType.objects.get(pk=int(serializer.data[i]['warning_type_id']))
            serializer.data[i]['warning_type']  = warningtype.warning_type
            serializer.data[i]['warning_level'] = warningtype.warning_level
            if(serializer.data[i]['warning_target_people'] != None):
                person_id = serializer.data[i]['warning_target_people'].split('.')
                serializer.data[i]['warning_target_people_name'] = []
                for x in person_id:
                    serializer.data[i]['warning_target_people_name'].append(Face.objects.get(pk=int(x)).username+'/')
            else:
                serializer.data[i]['warning_target_people_name'] = '无设置'

            if(serializer.data[i]['warning_target_car'] != None):
                serializer.data[i]['warning_target_car_name'] = '设置'
            else:
                serializer.data[i]['warning_target_car_name'] = '无设置'

            if(serializer.data[i]['warning_target_camera'] != None):
                camera_num = 0
                camera_ids = serializer.data[i]['warning_target_camera'].split('.')
                for camera_id in camera_ids:
                    if int(camera_id) < 10000:
                        camera_num = camera_num + 1
                serializer.data[i]['warning_target_camera_num'] = camera_num
            else:
                serializer.data[i]['warning_target_camera_num'] = 0
                
        #print(result_list['warning_type_id'])
        return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999',
                            msg='success')

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
            if int(buf['faceid']) < 1000:
                buf['faceurl'] = FaceImg.objects.filter(userid_id=int(buf['faceid'])).values('imgurl')[0]['imgurl']
            else:
                buf['faceurl'] = ''
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

warning_type = WarningTypeView.as_view()
warning_event = WarningEventView.as_view()
camera_ws = CameraWS.as_view()
camera_record = CameraRecord.as_view()
camera_record_for_cs = CameraRecordForCS.as_view()
