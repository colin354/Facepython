from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.serializers import CheckSerializer
from apps.users.models import Check as CheckModel
from apps.users.models import FaceImg as FaceImgModel
from django.conf import settings
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
        #按流查询后端返回数据
        streamurl = request.GET.get('streamurl')
        if streamurl:
            checks = CheckModel.objects.filter(url = streamurl)
            serializer =getmarkers(checks)
            return JsonResponse(data={'list': serializer, 'count': len(serializer)}, code='999999',
                                msg='success')
        elif (faceid =='None' or faceid == '') and (streamid == 'None' or streamid == ''):
            checks = CheckModel.objects.values('faceid', 'streamid', 'url').distinct()
            return JsonResponse(data={'list': checks, 'count': len(checks)}, code='999999', msg='success')
        # 获取某一个具体人脸的信息
        elif ((faceid != 'None' or faceid != '') and (streamid == 'None' or streamid == '')):
            checks = CheckModel.objects.filter(faceid=faceid).values('faceid','streamid','url').distinct()
            return JsonResponse(data={'list': list(checks), 'count': len(checks)}, code='999999', msg='success')
        elif ((faceid != 'None' or faceid != '') and (streamid != 'None' or streamid != '')):
            checks = CheckModel.objects.filter(faceid=faceid, streamid=streamid).values('faceid', 'time', 'imgurl')
            checks_list = list(checks)
            for ind, item in enumerate(checks_list):
                imgs = FaceImgModel.objects.filter(userid_id=item['faceid']).values('id', 'imgurl')
                imgs = list(imgs)
                imgs.clear()
                imgs.append({'imgurl':settings.FACE_IMG_CHECK_ROOT_URL+item['imgurl']})
                checks_list[ind]['imgList'] = imgs
            return JsonResponse(data={'list': list(checks_list), 'count': len(checks_list)}, code='999999', msg='success')
        else:
            return JsonResponse(data={}, code="999999", msg="成功")

#按流查询后端数据处理过程
def getmarkers(data):
    print('getmarkers!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
    res = []
    for marker in data:
        newlist = {}
        for marker_data in res:
            if marker.time == marker_data['time']:

                newlist = {'id':marker.faceid,'imgurl':marker.imgurl}
                marker_data['imgList'].append(newlist)
                break
        if newlist:
            print('same time')
        else:
            res.append({'time': marker.time, 'text': marker.c_threshold,'imgList':[{'id':marker.faceid,'imgurl':marker.imgurl}],
                            'width':"50%"})
    return res
check_face = Check.as_view()
