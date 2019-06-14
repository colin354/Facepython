from rest_framework.authtoken.serializers import AuthTokenSerializer
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.serializers import TokenSerializer
from users.common.api_response import JsonResponse

class FaceMatchInfo(APIView):

    def post(self, request, *args, **kwargs):
        print(request.data)

        data = {"list":[
            {"p_id": "001", "streamlocation": "Gates"}
        ]}
        return JsonResponse(data=data, code="999999", msg="成功")

face_match_info = FaceMatchInfo.as_view()