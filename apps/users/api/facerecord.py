from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.serializers import PersonReidSerializer
from apps.users.models import Check as CheckModel
from apps.users.models import FaceImg as FaceImgModel
from django.conf import settings
from apps.users.models import Stream as StreamModel
from apps.users.models import CameraStream as CameraStreamModel
from apps.users.models import Face as FaceModel
from apps.users.models import PersonReid as PersonReidModel

from collections import OrderedDict

class FaceRecord(APIView):

    def post(self, request, *args, **kwargs):
        tempUrl = request.data.get('url')
        #strid = StreamModel.objects.filter(streamurl=settings.FACE_IMG_CHECK_ROOT_URL + tempUrl).values("id","streamfps")[0]
        strid = CameraStreamModel.objects.filter(streamUrl=settings.FACE_IMG_CHECK_ROOT_URL + tempUrl).values("id", "streamFps")[0]
        buf = request.data.copy()
        buf['streamid'] = strid['id']
        #timebuf = float(buf['timestap']) / float(strid['streamfps'])
        timebuf = float(buf['timestap']) / float(strid['streamFps'])
        buf['time'] = str(round(timebuf, 2))
        serializer = PersonReidSerializer(data=buf)
        if serializer.is_valid():
            # 这里可以解析post上传数据，再存储，目前做个简单的
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")
        # print("face record post")
        # print(request.data)
        # serializer = PersonReidSerializer(data=request.data)
        # print(serializer)
        # if serializer.is_valid():
        #     print("1111111111111111111")
        #     rev = serializer.save()
        #     for reid in request.data['reid_c']:
        #         if reid:
        #             personTopModel = PersonTopModel(personreid=rev,reid_imgurl= reid['reid_imgurl'],confidence=reid['confidence'],timestap= reid['timestap'])
        #             personTopModel.save()
        #     return JsonResponse(data={}, code="999999", msg="成功")
        # return JsonResponse(data=serializer.errors, code="-1", msg="失败")

    def get(self, request, *args, **kwargs):
        print("face record get!")
        return JsonResponse(data={}, code="999999", msg="成功")



face_record = FaceRecord.as_view()
