from rest_framework.views import APIView
from users.common.api_response import JsonResponse

class Stream(APIView):

    def post(self, request, *args, **kwargs):
        return JsonResponse(data={}, code="999999", msg="成功")

    def get(self, request, *args, **kwargs):
        return JsonResponse(data={}, code="999999", msg="成功")

stream = Stream.as_view()
