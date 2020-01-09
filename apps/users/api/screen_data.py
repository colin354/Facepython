from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import FaceImg,WarningType,WarningEvent,WarningHistory,Camera,CameraStream,CameraRealtime
from apps.users.serializers import WarningTypeSerializer,WarningEventSerializer,WarningHistorySerializer,CameraRealtimeSerializer
from apps.users.tasks import add,start,stop
from rest_framework import serializers
from apps.users.utility import TokenVerify
from django.conf import settings
import os,json
import datetime,time
import configparser

class ScreenInfoView(APIView):
    @TokenVerify
    def get(self,request,*args,**kwargs):
        ###获取所有预警事件类型信息###
        print('Inforrrrrequest!!!!!')
        base_info = {}
        base_info['warning_count'] = WarningHistory.objects.all().count()
        base_info['camera_count'] = Camera.objects.all().count()
        base_info['face_count'] = CameraRealtime.objects.filter(c_threshold = '1.000000').distinct().count()
        print(base_info)
        return JsonResponse(data={'code':200,'data':base_info}, code='999999', msg='success')

class ScreenDeviceView(APIView):
    @TokenVerify
    def get(self,request,*args,**kwargs):
        ###获取所有预警事件类型信息###
        print('Devicerrrrrequest!!!!!')
        cameralocations = list(Camera.objects.all().values('cameraLocation').distinct())
        camera_infos = []
        for i in range(len(cameralocations)):
            camera_info = {}
            camera_info['name'] = cameralocations[i]['cameraLocation']
            camera_info['count'] = Camera.objects.filter(cameraLocation = cameralocations[i]['cameraLocation']).count()
            camera_infos.append(camera_info)
       
        warningevent = WarningEvent.objects.all()
        serializer = WarningEventSerializer(warningevent, many=True)
        result_list = serializer.data
        warning_infos = []
        for i in range(len(serializer.data)):
            warning_info = {}
            #print(list(map(int,serializer.data[i]['warning_target_camera'].split('.'))))
            warning_info['name'] = serializer.data[i]['warning_name']
            warning_info['count'] = len((list(filter(lambda x : x<=10000 ,list(map(int,serializer.data[i]['warning_target_camera'].split('.')))))))
            warning_infos.append(warning_info)
        print(warning_infos)
        return JsonResponse(data={'data':warning_infos,'camera':camera_infos}, code='999999', msg='success')

class ScreenWarningView(APIView):
    @TokenVerify
    def get(self,request,*args,**kwargs):
        ###获取所有预警事件类型信息###
        #滚动播放,return list
        print('Warningrrrrrequest!!!!!')
        warninghistory = WarningHistory.objects.all()
        serializer = WarningHistorySerializer(warninghistory, many=True)
        
        #target 目标人物
        warningevent = WarningEvent.objects.filter(warning_target_people__isnull=False)
        serializer_event = WarningEventSerializer(warningevent, many=True)
        result_list = serializer_event.data
        target_people = []
        people_infos  = []
        #这里写法待优化！！！
        for i in range(len(result_list)):
            for e in result_list[i]['warning_target_people'].split('.'):
                people_info = {}
                if e not in target_people:
                    people_info['faceid'] = e
                    people_info['imgurl'] = FaceImg.objects.filter(userid_id=e).values('imgurl')[0]['imgurl']
                    target_people.append(e)
                    people_infos.append(people_info)

        #strange 陌生人抓拍
        real_people = CameraRealtime.objects.filter(c_threshold = '1.000000').distinct().order_by('-id')[:30]
        serializer_real = CameraRealtimeSerializer(real_people, many=True)
        for i in range(len(serializer_real.data)):
            serializer_real.data[i]['imgurl'] = settings.FACE_IMG_REAL_ROOT_URL + serializer_real.data[i]['imgurl']
        strangers = serializer_real.data
        return JsonResponse(data={'list':serializer.data,'target':people_infos,'strange':strangers}, code='999999', msg='success')

class WarningEventCtrlView(APIView):
    @TokenVerify
    def post(self,request,*args,**kwargs):
        warningevent = WarningEvent.objects.get(pk = request.data['params']['id'])
        print(type(warningevent))
        print(warningevent.warning_target_camera)
        ret = ''
        if(request.data['params']['start']):
            warningevent.warning_event_flag = 1
            warningevent.warning_event_time = datetime.datetime.now()
            warningevent.save()
            ret = start(warningevent)
            result = add(1,2)
        else:
            warningevent.warning_event_flag = 0
            warningevent.warning_event_time = datetime.datetime.now()
            warningevent.save()
            ret = stop(warningevent)
            result = add(2,2)
        return JsonResponse(data={'result':result,'ret':ret}, code="999999", msg="成功")

class WarningHistoryView(APIView):
    @TokenVerify
    def get(self,request,*args,**kwargs):
        warninghistory = WarningHistory.objects.all()
        serializer = WarningHistorySerializer(warninghistory, many=True)
        for i in range(len(serializer.data)):
            warningevent = WarningEvent.objects.get(pk=int(serializer.data[i]['warning_event_id']))
            warningtype = WarningType.objects.get(pk=int(warningevent.warning_type_id_id))
            serializer.data[i]['warning_type']  = warningtype.warning_type
            serializer.data[i]['warning_level'] = warningtype.warning_level
            serializer.data[i]['warning_name'] = warningevent.warning_name
            serializer.data[i]['warning_id'] = warningevent.warning_id
        print(serializer.data)
        return JsonResponse(data={'list':serializer.data}, code="999999", msg="成功")

    @TokenVerify
    def delete(self,request,*args,**kwargs):
        ids = request.data
        for id in ids:
            warninghistory= WarningHistory.objects.get(id=id).delete()
        return JsonResponse(data={}, code='999999', msg='成功')

class WarningEventView(APIView):
    @TokenVerify
    def post(self,request,*args,**kwargs):
        print("now warning event new post!!!!!!!!!!!!!!!!!!!!")
        request.data['warning_id'] = 'YJ编号' + str(int(round(time.time()*1000)))
        serializer = WarningEventSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data={}, code="-1", msg="操作失败")

    @TokenVerify
    def delete(self,request,*args,**kwargs):
        ids = request.data
        for id in ids:
            warningevent= WarningEvent.objects.get(id=id).delete()
        return JsonResponse(data={}, code='999999', msg='成功')

    @TokenVerify
    def put(self,request,*args,**kwargs):
        if(request.data['warning_target_people'] == ""):
            #request.data['warning_target_people'] = '.'.join([str(x) for x in request.data['warning_target_people']])
            request.data['warning_target_people'] = None
        if(request.data['warning_target_car'] == ""):
            request.data['warning_target_car'] = None
            #request.data['warning_target_car'] = '.'.join([str(x) for x in request.data['warning_target_car']])
        if(request.data['warning_target_camera'] == ""):
            request.data['warning_target_camera'] = None
            #request.data['warning_target_camera'] = '.'.join([str(x) for x in request.data['warning_target_camera']])
        warningevent = WarningEvent.objects.get(pk = request.data['id'])
        serializer = WarningEventSerializer(warningevent, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    @TokenVerify
    def get(self,request,*args,**kwargs):
        warningeventid = request.GET.get('id')
        if warningeventid != None and warningeventid != '': 
            warningevent = WarningEvent.objects.get(pk=warningeventid)
            serializer = WarningEventSerializer(warningevent)
            print(serializer.data)
            if(serializer.data['warning_target_people'] != None):
                person_ids = serializer.data['warning_target_people'].split('.')
                for i in person_ids:
                    face = Face.objects.get(pk=int(i))
            #serializer.data['warning_type'] = warningtype_serializer.data
            return JsonResponse(data=serializer.data,code='999999', msg='success')
        
        #如果默认参数里没有带id一类的，则返回全部数据，将来需要考分页及limit的限制
        warningevent = WarningEvent.objects.all()
        serializer = WarningEventSerializer(warningevent, many=True)
        result_list = serializer.data
        for i in range(len(serializer.data)):
            warningtype = WarningType.objects.get(pk=int(serializer.data[i]['warning_type_id']))
            serializer.data[i]['warning_type']  = warningtype.warning_type
            serializer.data[i]['warning_level'] = warningtype.warning_level
            if(serializer.data[i]['warning_target_people'] != None):
                person_id = serializer.data[i]['warning_target_people'].split('.')
                serializer.data[i]['warning_target_people_name'] = []
                for x in person_id:
                    serializer.data[i]['warning_target_people_name'].append(Face.objects.get(pk=int(x)).username+'/')
            else:
                serializer.data[i]['warning_target_people_name'] = '无设置'

            if(serializer.data[i]['warning_target_car'] != None):
                serializer.data[i]['warning_target_car_name'] = '设置'
            else:
                serializer.data[i]['warning_target_car_name'] = '无设置'

            if(serializer.data[i]['warning_target_camera'] != None):
                camera_num = 0
                camera_ids = serializer.data[i]['warning_target_camera'].split('.')
                for camera_id in camera_ids:
                    if int(camera_id) < 10000:
                        camera_num = camera_num + 1
                serializer.data[i]['warning_target_camera_num'] = camera_num
            else:
                serializer.data[i]['warning_target_camera_num'] = 0
                
        #print(result_list['warning_type_id'])
        return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999',
                            msg='success')

#遍历文件及子文件的所有文件
def getfilelist(filepath):
    filelist = os.listdir(filepath)
    files = []
    for i in range(len(filelist)):
        child = os.path.join('%s/%s' % (filepath, filelist[i]))
        if os.path.isdir(child):
            files.extend(getfilelist(child))
        else:
            if '.mp4' in child:
                files.append(child)
    return files

screen_info = ScreenInfoView.as_view()
screen_device = ScreenDeviceView.as_view()
screen_warning = ScreenWarningView.as_view()
warning_event_ctrl = WarningEventCtrlView.as_view()
