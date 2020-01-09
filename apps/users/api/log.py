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
        a = int(request.GET['limit'])
        b = int(request.GET['page'])
        start = a * (b - 1)
        end = a * b
        loginrecordall = LoginRecord.objects.all()
        loginrecord = loginrecordall[start:end]
        serializer = LoginRecordSerializer(loginrecord, many=True)
        return JsonResponse(data={'list': serializer.data, 'count': len(loginrecordall)}, code='999999',
                            msg='success')

class OperationRecordView(APIView):
    @TokenVerify
    @OperationLog
    def get(self,request,*args,**kwargs):
        a = int(request.GET['limit'])
        b = int(request.GET['page'])
        start = a * (b - 1)
        end = a * b
        operationrecordall = OperationRecord.objects.all()
        operationrecord = operationrecordall[start:end]
        serializer = OperationRecordSerializer(operationrecord,many=True)
        return JsonResponse(data={'list':serializer.data,'count':len(operationrecordall)}, code="999999", msg="成功")

login_record = LoginRecordView.as_view()
operation_record = OperationRecordView.as_view()
