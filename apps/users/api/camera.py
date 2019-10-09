from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import Camera,CameraUrl
from apps.users.serializers import CameraSerializer,CameraUrlSerializer
from rest_framework import serializers
from apps.users.utility import TokenVerify
from apps.users.models import CameraUrl as CameraUrlModel
import cv2

class CameraView(APIView):

    def post(self,request,*args,**kwargs):
        print("now camera new post!!!!!!!!!!!!!!!!!!!!")
        serializer = CameraSerializer(data=request.data)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")


    def get(self,request,*args,**kwargs):
        print("now camera new get!!!!!!!!!!!!!!!!!!!!")
        cameras = Camera.objects.all()
        serializer = CameraSerializer(cameras, many=True)
        return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999',
                                    msg='success')


class CameraStream(APIView):

    def post(self,request,*args,**kwargs):
        print("now camerastream new post!!!!!!!!!!!!!!!!!!!!")
        cameraid = request.data['cameraid']
        camera = Camera.objects.get(pk=cameraid)
        streamurl_value = request.data['streamurl']
        cap = cv2.VideoCapture(streamurl_value)
        if cap.isOpened():  # 当成功打开视频时cap.isOpened()返回True,否则返回False
            rate = cap.get(5)  # 帧速率
            frame_number = cap.get(7)  # 视频文件的帧数
            seconds = frame_number / rate
            rate = ("%.1f" % rate)
            seconds = ("%.1f" % seconds)
            streamfps_value = str(rate)
            streamtime_value = str(seconds)
            cameraUrlModel = CameraUrlModel(streamurl=streamurl_value,cameraid =camera,streamfps = streamfps_value,streamtime = streamtime_value,streamstatus='0')
            cameraUrlModel.save()
            return JsonResponse(data={}, code='999999',msg='success')
        return JsonResponse(data={}, code="-1", msg="failed")

    def get(self,request,*args,**kwargs):
        print("now camerastream get !!!!!!!!!!!!!!!!!!!!!!!!!")
        return JsonResponse(data={}, code='999999', msg='success')

cameras = CameraView.as_view()
camera_stream = CameraStream.as_view()