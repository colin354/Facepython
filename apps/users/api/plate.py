from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from django.core.exceptions import ObjectDoesNotExist
from django.conf import settings
from apps.users.serializers import PlateSerializer,PlateRealtimeSerializer
from rest_framework.parsers import JSONParser
from apps.users.utility import TokenVerify,OperationLog
from apps.users.models import Plate,PlateRealtime
import os, shutil
import pdb

from django.core.cache import cache,caches

class PlateView(APIView):
    def post(self,request,*args,**kwargs):
        print("now stranger new post!!!!!!!!!!!!!!!!!!!!")

        print(request.data)
        serializer = PlateSerializer(data=request.data)
        print(serializer)
        if serializer.is_valid():
            #这里可以解析post上传数据，再存储，目前做个简单的
            #从前端上传的车牌信息也需要对应的redis
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")
    
    @TokenVerify
    def get(self, request, *args, **kwargs):
        print('get stanger')
        print(request.GET)
        a = int(request.GET['limit'])
        b = int(request.GET['page'])
        start = a * (b - 1)
        end = a * b
        plateall = Plate.objects.all().order_by('id')
        plates = plateall[start:end]        
        serializer = PlateSerializer(plates, many=True)
        for i in range(len(serializer.data)):
            #serializer.data[i]['plate_id'] = '车牌:' + str(serializer.data[i]['plate_id'])
            serializer.data[i]['plate_url'] = settings.PLATE_IMG_REAL_ROOT_URL + serializer.data[i]['plate_url']
        return JsonResponse(data={'list': serializer.data, 'count': len(plateall)}, code='999999', msg='success')

    @TokenVerify
    def delete(self,request,*args,**kwargs):
        print('delete!!!-------')
        # plate_flow = caches['flow']
        # try:
        #     a = plate_flow.get('/daiodhi/asdagsgd.mp3')
        #     print(a)
        #     print("1111111")
        # except:
        #     print("222222")
        # buf = {"people_num":1,"plat_num":1}
        # plate_flow.set("/dsaiodhi/asdagsgd.mp3",buf)
        
        plateids = request.data
        if plateids:
            plates = Plate.objects.filter(id__in=plateids)
            #删除redis里对应数据
            plateid_list = plates.values_list("plate_id",flat=True)
            cache.delete_pattern(plateid_list)
            plates.delete()
        else:
            return JsonResponse(data={},code='-1',msg='缺少必要参数')
        return JsonResponse(data={},code='999999',msg="成功")



plates= PlateView.as_view()
