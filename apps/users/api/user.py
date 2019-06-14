from rest_framework.authtoken.serializers import AuthTokenSerializer
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.serializers import TokenSerializer
from users.common.api_response import JsonResponse
from captcha.models import CaptchaStore
from captcha.helpers import captcha_image_url
from rest_framework import renderers
from rest_framework.renderers import StaticHTMLRenderer, BrowsableAPIRenderer, TemplateHTMLRenderer, JSONRenderer
from rest_framework.response import Response
import json

class ObtainAuthToken(APIView):
    serializer_class = AuthTokenSerializer

    def post(self, request, *args, **kwargs):
        print(request.data)
        serializer = self.serializer_class(data=request.data,
                                           context={"request": request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data["user"]
        data = TokenSerializer(Token.objects.get(user=user)).data
        return JsonResponse(data=data, code="999999", msg="成功")

    def captcha():
        hashkey = CaptchaStore.generate_key()
        image_url = captcha_image_url(hashkey)
        captcha = {'hashkey': hashkey, 'image_url': image_url}
        return captcha

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

obtain_auth_token = ObtainAuthToken.as_view()

class JPEGRenderer(renderers.BaseRenderer):
    media_type = 'image/jpeg'
    format = 'jpg'
    charset = None
    render_style = 'binary'

    def render(self, data, media_type=None, renderer_context=None):
        print('aaaaa')
        print(data)
        print('bbbbb')
        return data

def captcha():
    hashkey = CaptchaStore.generate_key()
    image_url = captcha_image_url(hashkey)
    captcha = {'hashkey': hashkey, 'image_url': image_url}
    return captcha

class ObtainCaptcha(APIView):
    renderer_classes = (StaticHTMLRenderer, )
    def get(self, request, *args, **kwargs):
        hashkey = CaptchaStore.generate_key()
        image_url = captcha_image_url(hashkey)
        captcha = {'hashkey': hashkey, 'image_url': image_url}
        print(image_url)
        data = '<html><body><img src='+'http://localhost:8000'+image_url+'></body></html>'
        return Response(data,content_type='image/png')

obatin_captcha = ObtainCaptcha.as_view()

class ObtainUserInfo(APIView):
    serializer_class = AuthTokenSerializer

    def get(self, request, *args, **kwargs):
        print(request)
        serializer = self.serializer_class(data=request.data,
                                           context={"request": request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data["user"]
        data = TokenSerializer(Token.objects.get(user=user)).data
        return JsonResponse(data=data, code="0", msg="oka")

obtain_user_info = ObtainUserInfo.as_view()

class UploadFace(APIView):
    serializer_class = AuthTokenSerializer
    def get(self,request, *args, **kwargs):
        print(request.data)
        print('get get get')
        data = 'aaabbb'
        return JsonResponse(data=data, code="999999", msg="成功")

    def post(self, request, *args, **kwargs):
        print(request.data)
        print('aaa')
        serializer = self.serializer_class(data=request.data,
                                           context={"request": request})
        data = 'aaa'
        return JsonResponse(data=data, code="999999", msg="成功")

    def delete(self, request, *args, **kwargs):
        print(request.data)
        print('cccccc')
        data = 'aaabbb'
        return JsonResponse(data=data, code="999999", msg="成功")

upload_face = UploadFace.as_view()

class GetStream(APIView):
    serializer_class = AuthTokenSerializer

    def get(self, request, *args, **kwargs):
        print(request.data)
        print('aaa')
        serializer = self.serializer_class(data=request.data,
                                           context={"request": request})
        list ={"list":[
            {"id": "1", "streamname": "Bill", "streamlocation": "Gates"},
            {"id": "2", "streamname": "George", "streamlocation": "Bush"},
            {"id": "3", "streamname": "Thomas", "streamlocation": "Carter"}
        ]}
        return JsonResponse(data=list, code="999999", msg="成功")

get_stream = GetStream.as_view()

class GetFaceStatus(APIView):
    serializer_class = AuthTokenSerializer

    def get(self, request, *args, **kwargs):
        print(request.data)
        data ={"faces":[
                   {"flag": "1", "p_id": "1", "url":"http://location/aa"},
                   {"flag": "2", "p_id": "2", "url":"http://location/bb"},
                   {"flag": "3", "p_id": "3", "url":"http://location/cc"}
               ],"total_count":"3"}
        return JsonResponse(data=data, code="999999", msg="成功")

obtain_face_status = GetFaceStatus.as_view()

class ObtainFaceInfo(APIView):
    serializer_class = AuthTokenSerializer

    def get(self, request, *args, **kwargs):
        print(request.data)
        print('aaa')
        serializer = self.serializer_class(data=request.data,
                                           context={"request": request})
        list ={"list":[
            {"id": "1", "name": "Bill", "url": "Gates", "createDate": "2019-06-11"},
            {"id": "2", "name": "George", "url": "Bush", "createDate": "2019-06-11"},
            {"id": "3", "name": "Thomas", "url": "Carter", "createDate": "2019-06-11"}
        ]}
        return JsonResponse(data=list, code="999999", msg="成功")

obtain_face_info = ObtainFaceInfo.as_view()

