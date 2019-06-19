from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import Stream
from apps.users.serializers import StreamSerializer
from rest_framework import serializers
from apps.users.utility import TokenVerify


class StreamAddorupload(APIView):
    TOKEN = 'token'
#新增功能
    # 调用Token验证
    @TokenVerify
    def post(self, request, *args, **kwargs):
        serializer = StreamSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="-1", msg="失败")

#修改功能
    # 调用Token验证
    @TokenVerify
    def put(self, request, *args, **kwargs):
        request.data['flag'] = Stream.UPDATE
        stream = Stream.objects.get(id=request.data['id'])
        serializer = StreamSerializer(stream, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="-1", msg="失败")

#删除功能（逻辑删除）
    # 调用Token验证
    @TokenVerify
    def delete(self, request, *args, **kwargs):
        for data_id in request.data:
            stream = Stream.objects.get(id=data_id)
            stream.flag = Stream.DELETE
            stream.save()
        return JsonResponse(data={}, code='999999', msg='成功')


class StreamView(APIView):
    TOKEN = 'token'
#显示列表信息
    # 调用Token验证
    @TokenVerify
    def get(self, request, *args, **kwargs):
        print(request.GET)
        if request.path_info.strip('/').split('/')[-1].isdigit() == False:
            a = int(request.GET['limit'])
            b = int(request.GET['page'])
            start = a * (b - 1)
            end = a * b
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!获取所有信息")
            streamsall = Stream.objects.all()
            streams = streamsall[start:end]
            serializer = StreamSerializer(streams, many=True)
            #return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999',
                                    #    msg='success')
            return JsonResponse(data={'list': serializer.data, 'count': len(streamsall)}, code='999999',
                    msg='success')
        else:
            #通过ID获取单个数据
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!获取特定信息")
            stream_id = int(request.path_info.split('/')[-1])
            print(stream_id)
            stream = Stream.objects.get(id=stream_id)
            serializer = StreamSerializer(stream)
            return JsonResponse(data=serializer.data, code='999999', msg='success')


stream_list = StreamView.as_view()
stream_add = StreamAddorupload.as_view()
