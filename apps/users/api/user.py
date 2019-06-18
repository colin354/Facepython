from rest_framework.authtoken.serializers import AuthTokenSerializer
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.serializers import TokenSerializer
from users.common.api_response import JsonResponse
from django.core.exceptions import ObjectDoesNotExist
from django.contrib.auth.models import User
from apps.users.utility import TokenVerify

import pdb
#import random

from captcha.models import CaptchaStore
from captcha.helpers import captcha_image_url
from captcha.models import CaptchaStore

#from django.http import HttpResponse

def captcha():
    hashkey = CaptchaStore.generate_key()   #验证码答案
    image_url = captcha_image_url(hashkey)  #验证码地址
    captcha_data = {'hashkey': hashkey, 'image_url': image_url}
    #print("*********************************")
    #print("*********************************")
    #local_imag_url = "http://127.0.0.1:8000"+image_url
    return(captcha_data)
    #return local_imag_url
def jarge_captcha(captchaStr, captchaHashkey):
    if captchaStr and captchaHashkey:
        try:
            # 获取根据hashkey获取数据库中的response值
            get_captcha = CaptchaStore.objects.get(hashkey=captchaHashkey)
            # 如果验证码匹配
            if get_captcha.response == captchaStr.lower():
                return True
        except:
            return False
    else:
        return False

class ObtainAuthToken(APIView):
    serializer_class = AuthTokenSerializer

    def post(self, request, *args, **kwargs):
        uuid = request.data.get('uuid','')
        captcha = request.data.get('captcha','')
        captcha_up = captcha.upper()
        print(captcha_up)
        get_challenge = CaptchaStore.objects.get(hashkey = uuid['hashkey']).challenge
        print(get_challenge)
        if captcha_up != get_challenge:
            data = "error"
            return JsonResponse(data=data, code="1", msg="验证码出错")
        serializer = self.serializer_class(data=request.data,context={"request": request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data["user"]
        data = TokenSerializer(Token.objects.get(user=user)).data
        # pdb.set_trace()
        return JsonResponse(data=data, code="999999", msg="成功")

class UserProfile(APIView):
    #TOKEN = 'token'

    @TokenVerify
    def get(self, request, format=None):
        token = request.META['HTTP_AUTHORIZATION']
        print(token)
        print('****************************')
        user_id = Token.objects.get(key=token).user_id
        username = User.objects.get(id=user_id).username
        print(username)
        # pdb.set_trace()
        return JsonResponse(data={"username":username}, code='999999', msg='成功')


class verificationcode(APIView):

    def get(self ,request , *args,**kwargs):
        return JsonResponse(captcha() , code = '0', msg = '验证码' , content_type='application/json')


verification_code = verificationcode.as_view()
obtain_auth_token = ObtainAuthToken.as_view()
user_profile = UserProfile.as_view()
