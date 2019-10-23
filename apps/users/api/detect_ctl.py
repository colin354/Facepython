from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import Camera,CameraStream
from apps.users.serializers import CameraSerializer,CameraStreamSerializer
from rest_framework import serializers
from apps.users.utility import TokenVerify
from apps.users.models import CameraStream as CameraStreamModel
from django.conf import settings
import configparser,json

class DetectView(APIView):

    @TokenVerify
    def post(self,request,*args,**kwargs):
        print("now camera new post!!!!!!!!!!!!!!!!!!!!")
        print(request.data)
        conf_file = settings.CONF_FILE
        config = configparser.ConfigParser()
        config.read(conf_file,encoding="utf-8")
        config["detect_state"] = request.data
        config.write(open(conf_file,mode="w"))
        return JsonResponse(data="", code="999999", msg="失败")

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
        print("now detect_state new get!!!!!!!!!!!!!!!!!!!!")
        conf_file = settings.CONF_FILE
        config = configparser.ConfigParser()
        config.read(conf_file,encoding="utf-8")
        detect_state = config.get("detect_state","detect_state")
        print(detect_state)
        return JsonResponse(data={'detect_state': detect_state,}, code='999999',
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

detect = DetectView.as_view()
camera_stream = CameraStream.as_view()
