from users.common.api_response import JsonResponse
from django.core.exceptions import ObjectDoesNotExist
from rest_framework.authtoken.models import Token
from functools import wraps
from django.conf import settings

# 验证token装饰器

def TokenVerify(func):
    @wraps(func)
    def handler(self, *args, **kwargs):
        request = args[0]
        TOKEN = 'token'
        if(settings.DEBUG == True):
            return func(self, *args, **kwargs)
        if TOKEN not in request.GET.keys():
            return JsonResponse(data={}, code='-1', msg='缺少token')
        token = request.GET[TOKEN]
        try:
            user_id = Token.objects.get(key=token).user_id
        except ObjectDoesNotExist as e:
            return JsonResponse(data={}, code="-1", msg='token错误')
        return func(self, *args, **kwargs)
    return handler



