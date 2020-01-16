from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import Camera,WarningType,WarningEvent,WarningHistory,Face
from apps.users.serializers import WarningTypeSerializer,WarningEventSerializer,WarningHistorySerializer
from apps.users.tasks import add,start,stop,do_train
from rest_framework import serializers
from apps.users.utility import TokenVerify
from django.conf import settings
import os,json
import datetime,time
import configparser

class WarningTypeView(APIView):

    @TokenVerify
    def post(self,request,*args,**kwargs):
        print("now warning type new post!!!!!!!!!!!!!!!!!!!!")
        print(request.data)
        serializer = WarningTypeSerializer(data=request.data)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        print("now warning type error post!!!!!!!!!!!!!!!!!!!!")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    @TokenVerify
    def put(self,request,*args,**kwargs):
        warningtype = WarningType.objects.get(pk = request.data['id'])
        serializer = WarningTypeSerializer(warningtype, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    def delete(self,request,*args,**kwargs):
        ids = request.data
        for id in ids:
            warningtype= WarningType.objects.get(id=id).delete()
        return JsonResponse(data={}, code='999999', msg='成功')


    @TokenVerify
    def get(self,request,*args,**kwargs):
        ###获取所有预警事件类型信息###
        warningtypeid = request.GET.get('id')
        if warningtypeid != None and warningtypeid != '': 
            warningtype = WarningType.objects.get(pk=warningtypeid)
            serializer = WarningTypeSerializer(warningtype)
            print(serializer.data)
            return JsonResponse(data=serializer.data,code='999999', msg='success')

        warningtype = WarningType.objects.all()
        serializer = WarningTypeSerializer(warningtype, many=True)
        return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999',
                            msg='success')

class WarningEventCtrlView(APIView):
    @TokenVerify
    def post(self,request,*args,**kwargs):
        warningevent = WarningEvent.objects.get(pk = request.data['params']['id'])
        print(type(warningevent))
        ret = ''
        result = ''
        if(request.data['params']['start']):
            warningevent.warning_event_flag = 1
            warningevent.warning_event_time = datetime.datetime.now()
            warningevent.save()
            ret = start(warningevent)
            print('-----eee----------')
            result1 = do_train.apply_async(args=[1,21], queue="train", routing_key="train")
            #re_data = result1.get()
            #print(re_data)
        else:
            warningevent.warning_event_flag = 0
            warningevent.warning_event_time = datetime.datetime.now()
            warningevent.save()
            ret = stop(warningevent)
            print('-----eee----------')
            result1 = do_train.apply_async(args=[3,4], queue="train", routing_key="train")
            print(result1)
            #re_data = result1.get()
        return JsonResponse(data={'result':result,'ret':ret}, code="999999", msg="成功")

class WarningHistoryView(APIView):
    @TokenVerify
    def get(self,request,*args,**kwargs):
        print('------history---------')
        print(request.GET)
        c_token = request.GET.get('c_token')

        if c_token :
            camera_id = Camera.objects.get(c_token = c_token).id
            warninghistory = WarningHistory.objects.filter(warning_camera_id = camera_id).order_by('-id')[:5]
            serializer = WarningHistorySerializer(warninghistory, many=True)
            for i in range(len(serializer.data)):
                warningevent = WarningEvent.objects.get(pk=int(serializer.data[i]['warning_event_id']))
                warningtype = WarningType.objects.get(pk=int(warningevent.warning_type_id_id))
                serializer.data[i]['warning_type']  = warningtype.warning_type
                serializer.data[i]['warning_level'] = str(warningtype.warning_level) + '级'
                #serializer.data[i]['warning_color'] = warningtype.warning_level
                serializer.data[i]['warning_name'] = warningevent.warning_name
                serializer.data[i]['warning_id'] = warningevent.warning_id
                serializer.data[i]['warning_capture_url'] = settings.FACE_IMG_REAL_ROOT_URL+serializer.data[i]['warning_capture_url'] 
                serializer.data[i]['warning_video_url'] = settings.FACE_IMG_REAL_ROOT_URL+serializer.data[i]['warning_video_url'] 
            return JsonResponse(data={'list':serializer.data}, code="999999", msg="成功")
        
        #默认返回
        a = int(request.GET['limit'])
        b = int(request.GET['page'])
        start = a * (b - 1)
        end = a * b
        if request.GET.get('queryName') :
            print('qqqeryname')
            queryName = request.GET.get('queryName')
            warninghistoryall = WarningHistory.objects.filter(warning_message__contains=queryName)
            warninghistory = warninghistoryall[start:end]
        else:
            print('no qqqeryname')
            warninghistoryall = WarningHistory.objects.all()
            warninghistory = warninghistoryall[start:end]
        serializer = WarningHistorySerializer(warninghistory, many=True)
        for i in range(len(serializer.data)):
            warningevent = WarningEvent.objects.get(pk=int(serializer.data[i]['warning_event_id']))
            warningtype = WarningType.objects.get(pk=int(warningevent.warning_type_id_id))
            serializer.data[i]['warning_type']  = warningtype.warning_type
            serializer.data[i]['warning_level'] = warningtype.warning_level
            #serializer.data[i]['warning_color'] = warningtype.warning_level
            serializer.data[i]['warning_name'] = warningevent.warning_name
            serializer.data[i]['warning_id'] = warningevent.warning_id
            serializer.data[i]['warning_capture_url'] = settings.FACE_IMG_REAL_ROOT_URL+serializer.data[i]['warning_capture_url'] 
            serializer.data[i]['warning_video_url'] = settings.FACE_IMG_REAL_ROOT_URL+serializer.data[i]['warning_video_url'] 
        return JsonResponse(data={'list':serializer.data,'count':len(warninghistoryall)}, code="999999", msg="成功")

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
        #if(request.data.__contains__('warning_target_people')):
        #    request.data['warning_target_people'] = '.'.join([str(x) for x in request.data['warning_target_people']])
        #if(request.data.__contains__('warning_target_car')):
        #    request.data['warning_target_car'] = '.'.join([str(x) for x in request.data['warning_target_car']])
        #if(request.data.__contains__('warning_target_camera')):
        #    request.data['warning_target_camera'] = '.'.join([str(x) for x in request.data['warning_target_camera']])
             
        serializer = WarningEventSerializer(data=request.data)
        print(request.data['warning_target_camera'].split('.'))
        if request.data['warning_target_camera']:
            camera_ids = request.data['warning_target_camera'].split('.')
            for camera_id in list(camera_ids):
                camera = Camera.objects.get(id=int(camera_id))
                if camera.warning_event == None or camera.warning_event == '':
                    camera.warning_event = request.data['warning_id'] + '.'
                else:
                    camera.warning_event = camera.warning_event + request.data['warning_id'] + '.'
                camera.save()
        print("now warning event new post!!!!!!!!!!!!!!!!!!!!")
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data={}, code="-1", msg="操作失败")

    @TokenVerify
    def delete(self,request,*args,**kwargs):
        print(request.data)
        ids = request.data
        for id in ids:
            warningevent= WarningEvent.objects.get(id=id)
            print(warningevent.warning_target_camera)
            if warningevent.warning_target_camera:
                camera_ids = warningevent.warning_target_camera.split('.')
                for camera_id in list(camera_ids):
                    camera = Camera.objects.get(id=int(camera_id))
                    if warningevent.warning_id in camera.warning_event.split('.'):
                        camera.warning_event = camera.warning_event.replace(str(warningevent.warning_id)+'.','')
                        camera.save()
            warningevent.delete()
        return JsonResponse(data={}, code='999999', msg='成功')

    @TokenVerify
    def put(self,request,*args,**kwargs):
        print('----------------put------------------')
        print(request.data)
        if(request.data['warning_target_people'] == ""):
            print('here1')
            print(request.data['warning_target_people'])
            #request.data['warning_target_people'] = '.'.join([str(x) for x in request.data['warning_target_people']])
            request.data['warning_target_people'] = None
            print(request.data['warning_target_people'])
        if(request.data['warning_target_car'] == ""):
            print('here2')
            request.data['warning_target_car'] = None
            #request.data['warning_target_car'] = '.'.join([str(x) for x in request.data['warning_target_car']])
        if(request.data['warning_target_camera'] == ""):
            print('here3')
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
        print("now warning event get !!!!!!!!!!!!!!!!!!!!!!!!!")
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
        #result1 = do_train.apply_async(args=[1,21], queue="train", routing_key="train")
        #re_data = result1.get()
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

warning_history = WarningHistoryView.as_view()
warning_type = WarningTypeView.as_view()
warning_event = WarningEventView.as_view()
warning_event_ctrl = WarningEventCtrlView.as_view()
