from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import Camera,CameraStream
from apps.users.serializers import CameraSerializer,CameraStreamSerializer,StreamSerializer
from rest_framework import serializers
from apps.users.utility import TokenVerify
from apps.users.models import CameraStream as CameraStreamModel
from django.conf import settings
import os
import cv2
import datetime

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
        # print(cameraid)
        # print(type(cameraid))
        # print(camera.id)
        # print("111111111111")
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
camera_stream = CameraStream.as_view()
camera_record = CameraRecord.as_view()
camera_record_for_cs = CameraRecordForCS.as_view()
