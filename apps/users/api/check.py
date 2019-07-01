from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.serializers import CheckSerializer
from apps.users.models import Check
from apps.users.utility import TokenVerify

#按流查询后端数据处理过程
def getmarkers(data):
    print('getmarkers!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
    res = []
    for marker in data:
        newlist = {}
        for marker_data in res:
            if marker.timestap == marker_data['time']:

                newlist = {'id':marker.faceid,'imgurl':marker.imgurl}
                marker_data['imgList'].append(newlist)
                break
        if newlist:
            print('same time')
        else:
            res.append({'time': marker.time, 'text': marker.c_threshold,'imgList':[{'id':marker.faceid,'imgurl':marker.imgurl}],
                            'width':"50%"})
    return res

class CheckView(APIView):

    # 调用Token验证
    @TokenVerify
    #???????????????????
    def post(self, request, *args, **kwargs):
        serializer = CheckSerializer(data=request.data)
        print(request.data)
        if serializer.is_valid():
        #这里可以解析post上传数据，再存储，目前做个简单的
            serializer.save()
            print("save")
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="成功")

    # 调用Token验证
    @TokenVerify
    #前端查询（分按流查询以及按人脸查询）
    def get(self, request, *args, **kwargs):
        #按流查询后端返回数据
        # if len(request.path_info.split('/')) > 6:
        #     print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        #     print(request.path_info.split('/'))
        #     streamurl = request.path_info.split('/')[3]+'//'+ request.path_info.split('/')[5]+'/'+request.path_info.split('/')[6]
        #     print(streamurl)
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        streamurl = request.GET.get("streamurl",default = None)
        print(streamurl)
        if streamurl:
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            # checks = Check.objects.filter(url=streamurl)
            checks = Check.objects.filter(url=streamurl)
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print(checks)
            serializer =getmarkers(checks)
            print("serializer = ",serializer)
            return JsonResponse(data={'list': serializer, 'count': len(serializer)}, code='999999',
                                msg='success')
        else:
            print('NO Streamurl')
            return JsonResponse(data={}, code='999999',
                                msg='success')
        # checks = Check.objects.all()
        # streamurls = Check.objects.values_list('url','faceid')
        # print(checks)
        # print(streamurls)
        # serializer = CheckSerializer(checks,many=True)
        # #return JsonResponse(data = serializer,code = '999999',msg = 'success')
        # return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999', msg='success')

check_face = CheckView.as_view()
