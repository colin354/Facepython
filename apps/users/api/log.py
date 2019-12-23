from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import LoginRecord,OperationRecord
from apps.users.serializers import LoginRecordSerializer,OperationRecordSerializer
from rest_framework import serializers
from django.conf import settings
from apps.users.utility import TokenVerify,OperationLog
import os,json
import datetime,time

class LoginRecordView(APIView):
    @TokenVerify
    @OperationLog
    def get(self,request,*args,**kwargs):
        print('------')
        print(self)
        loginrecord = LoginRecord.objects.all()
        serializer = LoginRecordSerializer(loginrecord, many=True)
        return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999',
                            msg='success')

class OperationRecordView(APIView):
    @TokenVerify
    @OperationLog
    def get(self,request,*args,**kwargs):
        operationrecord = OperationRecord.objects.all()
        serializer = OperationRecordSerializer(operationrecord,many=True)
        return JsonResponse(data={'list':serializer.data}, code="999999", msg="成功")

login_record = LoginRecordView.as_view()
operation_record = OperationRecordView.as_view()
