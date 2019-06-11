from rest_framework.authtoken.serializers import AuthTokenSerializer
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.serializers import TokenSerializer
from users.common.api_response import JsonResponse
from django.core.exceptions import ObjectDoesNotExist
from django.contrib.auth.models import User
from apps.users.utility import TokenVerify
import pdb


class ObtainAuthToken(APIView):
    serializer_class = AuthTokenSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                context={"request": request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data["user"]
        data = TokenSerializer(Token.objects.get(user=user)).data
        # pdb.set_trace()
        return JsonResponse(data=data, code="999999", msg="成功")

class UserProfile(APIView):

    def get(self, request, format=None):
        token = request.META['HTTP_AUTHORIZATION']
        user_id = Token.objects.get(key=token).user_id
        username = User.objects.get(id=user_id).username
        # pdb.set_trace()
        return JsonResponse(data={"username":username}, code='999999', msg='成功')

obtain_auth_token = ObtainAuthToken.as_view()
user_profile = UserProfile.as_view()
