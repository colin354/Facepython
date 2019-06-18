from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.serializers import CheckSerializer

class Check(APIView):

    def post(self, request, *args, **kwargs):
        serializer = CheckSerializer(data=request.data)
        print(request.data)
        if serializer.is_valid():
        #这里可以解析post上传数据，再存储，目前做个简单的
            serializer.save()
            print("save")
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="成功")

    def get(self, request, *args, **kwargs):
        return JsonResponse(data={}, code="999999", msg="成功")

check_face = Check.as_view()
