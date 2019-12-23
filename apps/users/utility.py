from users.common.api_response import JsonResponse
from django.core.exceptions import ObjectDoesNotExist
from rest_framework.authtoken.models import Token
from functools import wraps
from django.contrib.auth.models import User
from users.serializers import OperationRecordSerializer

# 验证token装饰器

def TokenVerify(func):
    @wraps(func)
    def handler(self, *args, **kwargs):
        request = args[0]
        TOKEN = 'token'
        if TOKEN not in request.GET.keys():
            return JsonResponse(data={}, code='-1', msg='缺少token')
        token = request.GET[TOKEN]
        try:
            user_id = Token.objects.get(key=token).user_id
        except ObjectDoesNotExist as e:
            return JsonResponse(data={}, code="-1", msg='token错误')
        return func(self, *args, **kwargs)
    return handler

def OperationLog(func):
    @wraps(func)
    def handler(self,*args, **kwargs):
        operationlog = {}
        request = args[0]
        print("now Get HTTP Args")
        #print(self.data.readline().decode())
        token = request.META['HTTP_AUTHORIZATION']
        #数据封装
        operationlog["operation_username"] = Token.objects.get(key=token).user.username
        #前端发送http请求未封装
        operationlog["operation_op"]=request.GET.get('Operation')
        operationlog["operation_method"] = request.method
        operationlog["operation_params"] = request.META["QUERY_STRING"]
        operationlog["operation_url"] = request.path_info
        operationlog["operation_status"] = 1
        operationlog["operation_ip"] =request.META["REMOTE_ADDR"]
        operationlog["operation_useragent"] = request.META["HTTP_USER_AGENT"]
        print(operationlog)
        serializer = OperationRecordSerializer(data=operationlog)
        if serializer.is_valid():
            print("now record into mysql")
            serializer.save()
        else:
            return JsonResponse(data=serializer.errors,code="-1",msg = "failed")
        return func(self, *args, **kwargs)
    return handler
