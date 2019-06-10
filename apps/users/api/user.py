from rest_framework.authtoken.serializers import AuthTokenSerializer
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.serializers import TokenSerializer
from users.common.api_response import JsonResponse


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

obtain_auth_token = ObtainAuthToken.as_view()

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

    def post(self, request, *args, **kwargs):
        print(request.data)
        print('aaa')
        serializer = self.serializer_class(data=request.data,
                                           context={"request": request})
        data = 'aaa'
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
            {"streamname": "Bill", "streamlocation": "Gates"},
            {"streamname": "George", "streamlocation": "Bush"},
            {"streamname": "Thomas", "streamlocation": "Carter"}
        ]}
        return JsonResponse(data=list, code="999999", msg="成功")

get_stream = GetStream.as_view()

