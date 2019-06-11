from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from django.core.exceptions import ObjectDoesNotExist
from apps.users.models import Face
from django.conf import settings
from django.contrib.auth.models import User
from apps.users.serializers import FaceSerializer
from rest_framework.parsers import JSONParser
from apps.users.utility import TokenVerify
import pdb

class FaceImgUpload(APIView):

    TOKEN = 'token'

    @TokenVerify
    def post(self, request, *args, **kwargs):
        if request.FILES.get('file') != None:
            src = request.FILES['file']
            with open(settings.BASE_DIR+'/media/'+src.name ,'wb+') as f:
                for chunk in src.chunks():
                    f.write(chunk)
                pass
        data = {'imgurl':'http://192.17.1.150:8000/'+'media/'+request.FILES['file'].name}
        return JsonResponse(data=data, code="999999", msg="成功")

class FaceView(APIView):
    TOKEN = 'token'

    @TokenVerify
    def post(self, request, *args, **kwargs):
        serializer = FaceSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="-1", msg="失败")

    @TokenVerify
    def get(self, request, format=None):
        if request.path_info.strip('/').split('/')[-1].isdigit() == False:
            faces = Face.objects.all()
            serializer = FaceSerializer(faces, many=True)
            return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999', msg='success')
        else:
            face_id = int(request.path_info.split('/')[-1])
            face = Face.objects.get(id=face_id)
            serializer = FaceSerializer(face)
            return JsonResponse(data=serializer.data, code='999999', msg='success')

    @TokenVerify
    def put(self, request, *args, **kwargs):
        face = Face.objects.get(id=request.data['id'])
        request.data['flag'] = Face.UPDATE
        serializer = FaceSerializer(face, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="-1", msg="失败")

    @TokenVerify
    def delete(self, request, *args, **kwargs):
        face = Face.objects.get(id=request.data[0])
        face.flag = Face.DELETE
        face.save()
        return JsonResponse(data={}, code='999999', msg='成功')


face_img_upload = FaceImgUpload.as_view()
faces = FaceView.as_view()
