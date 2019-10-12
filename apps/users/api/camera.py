from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import Camera,CameraStream
from apps.users.serializers import CameraSerializer,CameraStreamSerializer
from rest_framework import serializers
from apps.users.utility import TokenVerify
from apps.users.models import CameraStream as CameraStreamModel
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

cameras = CameraView.as_view()
camera_stream = CameraStream.as_view()
