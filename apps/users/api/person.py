from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from django.conf import settings
from apps.users.models import PersonDetect as PersonDetectModel
from apps.users.serializers import PersonDetcetSerializer
from apps.users.utility import TokenVerify


class PersonDetect(APIView):

    def post(self,request,*args,**kwargs):
        print("111111111111111111111111111")
        serializer = PersonDetcetSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")



person_detect = PersonDetect.as_view()

