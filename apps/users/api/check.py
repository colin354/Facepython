from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.serializers import CheckSerializer
from apps.users.models import Check as CheckModel
from apps.users.models import FaceImg as FaceImgModel
import ipdb

class Check(APIView):

    def post(self, request, *args, **kwargs):
        serializer = CheckSerializer(data=request.data)
        if serializer.is_valid():
            #这里可以解析post上传数据，再存储，目前做个简单的
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    def get(self, request, *args, **kwargs):
        # 获取所有人脸的信息
        faceid = request.GET.get('faceid')
        streamid = request.GET.get('streamid')
        faceid = str(faceid)
        streamid = str(streamid)
        # ipdb.set_trace()
        if (faceid =='None' or faceid == '') and (streamid == 'None' or streamid == ''):
            checks = CheckModel.objects.values('faceid', 'streamid', 'url').distinct()
            return JsonResponse(data={'list': checks, 'count': len(checks)}, code='999999', msg='success')
        # 获取某一个具体人脸的信息
        elif ((faceid != 'None' or faceid != '') and (streamid == 'None' or streamid == '')):
            checks = CheckModel.objects.filter(faceid=faceid).values('faceid','streamid','url').distinct()
            return JsonResponse(data={'list': list(checks), 'count': len(checks)}, code='999999', msg='success')
        elif ((faceid != 'None' or faceid != '') and (streamid != 'None' or streamid != '')):
            checks = CheckModel.objects.filter(faceid=faceid, streamid=streamid).values('faceid', 'time')
            checks_list = list(checks)
            for ind, item in enumerate(checks_list):
                imgs = FaceImgModel.objects.filter(userid_id=item['faceid']).values('id', 'imgurl')
                checks_list[ind]['imgList'] = list(imgs)
            return JsonResponse(data={'list': list(checks_list), 'count': len(checks_list)}, code='999999', msg='success')
        else:
            return JsonResponse(data={}, code="999999", msg="成功")

check_face = Check.as_view()
