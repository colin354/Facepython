from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from django.db.models import Q
from apps.users.models import Camera,CameraStream,Face,FaceImg,WarningType,WarningEvent,WarningHistory,Stranger,Check,PlateRealtime,Plate,PersonRealtime
from apps.users.serializers import CameraSerializer,CameraStreamSerializer,StreamSerializer,CameraRealtimeSerializer,WarningTypeSerializer,WarningEventSerializer,StrangerSerializer,CheckSerializer,PlateRealtimeSerializer,PlateSerializer,PersonRealtimeSerializer,PersonReidSerializer
from apps.users.serializers import WarningHistorySerializer,PlateSerializer

from apps.users.models import Plate
from rest_framework import serializers
from apps.users.utility import TokenVerify
from apps.users.models import CameraStream as CameraStreamModel
from apps.users.models import CameraRealtime as CameraRealtimeModel
from django.conf import settings
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync
import os,json,sys
import cv2
import datetime,time
import pandas as pd
import numpy as np
import paramiko
import configparser


from django.core.cache import cache,caches

class CameraView(APIView):

    @TokenVerify
    def post(self,request,*args,**kwargs):
        print("now camera new post!!!!!!!!!!!!!!!!!!!!")
        serializer = CameraSerializer(data=request.data)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    @TokenVerify
    def put(self,request,*args,**kwargs):
        camera = Camera.objects.get(pk = request.data['id'])
        serializer = CameraSerializer(camera, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    def delete(self,request,*args,**kwargs):
        ids = request.data
        for id in ids:
            camerarcv= Camera.objects.get(id=id).delete()
        return JsonResponse(data={}, code='999999', msg='成功')


    @TokenVerify
    def get(self,request,*args,**kwargs):
        print("now camera new get!!!!!!!!!!!!!!!!!!!!")
        #GET.get方法当无此参数时不会报错
        cameraid = request.GET.get('id')
        cameraname = request.GET.get('cameraName')
        export = request.GET.get("export")
        if cameraid != '' and cameraid !=None:
            ####获取单个camera的信息修改时调用###
            print("cameraid")
            print(cameraid)
            cameras = Camera.objects.get(pk=cameraid)
            serializer = CameraSerializer(cameras)
            return JsonResponse(data=serializer.data, code='999999', msg='success')

        if cameraname != '' and cameraname !=None:
            ###查询###
            print("cameraname")
            print(cameraname)
            cameras = Camera.objects.filter(cameraName__contains=cameraname)
            print(cameraname)
            serializer = CameraSerializer(cameras,many=True)
            return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999',msg='success')
        ###获取所有camera信息###
        camerasall = Camera.objects.all()
        if export == "export":
            serializer = CameraSerializer(camerasall,many=True)
            return JsonResponse(data={'list': serializer.data, 'count': len(camerasall)}, code='999999', msg='success')
        #GET方法 无此参数会报错
        a = int(request.GET['limit'])
        b = int(request.GET['page'])
        start = a * (b - 1)
        end = a * b
        print("now camera new get!!!!!!!!!!!!!!!!!!!!---cccolin")
        cameras = camerasall[start:end]
        serializer = CameraSerializer(cameras, many=True)
       # for i in range(len(serializer.data)):
       #     print(serializer.data[i]['id'])
        return JsonResponse(data={'list': serializer.data, 'count': len(camerasall)}, code='999999', msg='success')



class CameraStream(APIView):
    @TokenVerify
    def post(self,request,*args,**kwargs):
        print("now camerastream new post!!!!!!!!!!!!!!!!!!!!")
        token_buf = request.data['imgurl'].split('/')[2]
        camera = Camera.objects.filter(c_token=token_buf)[0]
        streamurl_value = "/mnt/public/media"+request.data['imgurl']
        start_time = request.data['imgurl'].split('/')[-1].split('.')[0]
        cap = cv2.VideoCapture(streamurl_value)
        if cap.isOpened():  # 当成功打开视频时cap.isOpened()返回True,否则返回False
            rate = cap.get(5)  # 帧速率
            frame_number = cap.get(7)  # 视频文件的帧数
            seconds = frame_number / rate
            rate = ("%.1f" % rate)
            seconds = ("%.1f" % seconds)
            streamfps_value = str(rate)
            streamtime_value = str(seconds)
            camerareals = CameraRealtimeModel.objects.filter(StreamUrl=request.data['imgurl']).values("faceid","c_x","c_y","c_w","c_h","imgurl",'c_threshold',"cameraid","StreamUrl","timestap",'datetime')
            buf = dict()
            buf['cameraId'] = camera.id
            buf['streamTime'] = streamtime_value
            buf['streamFps'] = streamfps_value
            start_time = start_time.replace("_","")
            start_time = datetime.datetime.strptime(start_time,"%Y%m%d%H%M%S")
            buf['startTime'] = start_time.strftime("%Y-%m-%d %H:%M:%S")
            end_time   = request.data['end_time'].replace("_","")
            end_time = datetime.datetime.strptime(end_time,"%Y%m%d%H%M%S")
            buf['endTime'] = end_time.strftime("%Y-%m-%d %H:%M:%S")
            buf['label'] = buf['startTime'].split(" ")[0]
            buf['faceNum'] = camerareals.count()
            buf['streamUrl'] = settings.FACE_IMG_REAL_ROOT_URL + request.data['imgurl']
            serializers = CameraStreamSerializer(data = buf)
            if serializers.is_valid():
                camera_stream = serializers.save()
                camerareals = list(camerareals)
                if len(camerareals):
                    checks = getchecks(camerareals,camera_stream)
                    serializers = CheckSerializer(data=checks,many=True)
                    if serializers.is_valid():
                        serializers.save()
                        CameraRealtimeModel.objects.filter(StreamUrl=request.data['imgurl']).update(StreamUrl='')
                        return JsonResponse(data={}, code='999999',msg='success')
                    else:
                        return JsonResponse(data=serializers.errors, code="999999", msg="失败")
                return JsonResponse(data={}, code='999999',msg='success')
            else:
                return JsonResponse(data=serializers.errors, code="999999", msg="失败")
        return JsonResponse(data={}, code="-1", msg="视频文件无效")

    def get(self,request,*args,**kwargs):
        print("now camerastream get !!!!!!!!!!!!!!!!!!!!!!!!!colin---------")
        a = int(request.GET['limit'])
        b = int(request.GET['page'])
        start = a * (b - 1)
        end = a * b
        cameraid = request.GET.get('cameraid')
        # camera = Camera.objects.get(pk = cameraid)
        #camerastreams = CameraStreamModel.objects.all()
        camerastreamsall = CameraStreamModel.objects.filter(cameraId_id=int(cameraid))
        camerastreams = camerastreamsall[start:end]
        #print(camerastreams)
        serializers = CameraStreamSerializer(camerastreams,many=True)
        return JsonResponse(data={'list':serializers.data,'count':len(camerastreamsall)}, code='999999', msg='success')

    def delete(self,request,*args,**kwargs):
        ids = request.data
        for id in ids:
            #删除check表中对应数据
            checks = Check.objects.filter(streamid=id)
            url = checks.values('url')[0]['url']
            checks.delete()
            #删除waringhistory表对应数据
            warninghistorys= WarningHistory.objects.filter(warning_video_url=url).delete()
            #更新realtime表中对应的StreamUrl字段
            realtimes = CameraRealtime.objects.filter(StreamUrl=url).update(StreamUrl='')
            #删除camerastream表中记录
            camerars= CameraStreamModel.objects.get(id=id).delete()
            #删除视频文件
            src_video=settings.LOCAL_VIDEO_URL+url
            if os.path.exists(src_video):
                os.remove(src_video)
        return JsonResponse(data={}, code='999999', msg='成功')

class CameraRecord(APIView):
    def post(self,request,*args,**kwargs):
        print('colin: new')
        print(request.data)
        print(request.data['cameraId'])
        cameraId = request.data['cameraId']
        camera = Camera.objects.get(pk = cameraId)
        serializer = CameraSerializer(camera)
        print(serializer.data)
        print(serializer.data['c_token'])
        filepath = settings.CAMERA_RECORD_BASE_URL + serializer.data['c_token']
        file_list = getfilelist(filepath)
        print((file_list[0]))
        stream_data = {}
        for i in range(0, len(file_list)):
            #print(file_list[i])
            stream_data['streamname'] =  str(i) + '-' + file_list[i].split(serializer.data['c_token'])[1]
            stream_data['streamlocation'] = serializer.data['cameraName'] + serializer.data['cameraLocation']
            stream_data['streamurl'] = settings.RECORD_ROOT_URL + file_list[i].split('record/')[1]
            stream_data['streamlat'] = serializer.data['cameraLat']
            stream_data['streamlon'] = serializer.data['cameraLon']
            stream_data['flag'] = '0'
            stream_data['streamstatus'] = '0'
            cap = cv2.VideoCapture(file_list[i])
            if cap.isOpened():  # 当成功打开视频时cap.isOpened()返回True,否则返回False
                rate = cap.get(5)  # 帧速率
                frame_number = cap.get(7)  # 视频文件的帧数
                seconds = frame_number / rate
                rate = ("%.1f" % rate)
                seconds = ("%.1f" % seconds)
                streamfps_value = str(rate)
                streamtime_value = str(seconds)
            stream_data['streamfps'] = streamfps_value
            stream_data['streamtime'] = streamtime_value
            stream_serializer = StreamSerializer(data=stream_data)
            if stream_serializer.is_valid():
                stream = stream_serializer.save()
            print(stream_serializer.data)

        return JsonResponse(data=serializer.data, code="999999", msg="成功")
    def get(self,request,*args,**kwargs):
        print('colin: new')
        print(request.data)
        return JsonResponse(data={}, code="999999", msg="成功")

class CameraRecordForCS(APIView):
    def post(self,request,*args,**kwargs):
        print('colin: new')
        print(request.data)
        print(request.data['cameraId'])
        cameraId = request.data['cameraId']
        camera = Camera.objects.get(pk = cameraId)
        serializer = CameraSerializer(camera)
        print(serializer.data)
        print(serializer.data['c_token'])
        filepath = settings.CAMERA_RECORD_BASE_URL + serializer.data['c_token']
        file_list = getfilelist(filepath)
        print((file_list[0]))
        stream_data = {}
        stream_data['cameraId'] = cameraId
        for i in range(0, len(file_list)):
            print('------0-000-----')
            stream_data['startTime'] = file_list[i].split(serializer.data['c_token'])[1]
            stream_data['label'] = serializer.data['cameraName'] + serializer.data['cameraLocation']
            stream_data['streamUrl'] = settings.RECORD_ROOT_URL + file_list[i].split('record/')[1]
            stream_data['flag'] = '0'
            stream_data['streamStatus'] = '0'
            cap = cv2.VideoCapture(file_list[i])
            if cap.isOpened():  # 当成功打开视频时cap.isOpened()返回True,否则返回False
                rate = cap.get(5)  # 帧速率
                frame_number = cap.get(7)  # 视频文件的帧数
                seconds = frame_number / rate
                rate = ("%.1f" % rate)
                seconds = ("%.1f" % seconds)
                streamfps_value = str(rate)
                streamtime_value = str(seconds)
            stream_data['streamFps'] = streamfps_value
            stream_data['streamTime'] = streamtime_value
            serializers = CameraStreamSerializer(data = stream_data)
            if serializers.is_valid():
                stream = serializers.save()
            print('dddddataeddd')
            print(serializers.data)
        return JsonResponse(data=serializers.data, code="999999", msg="成功")
    def get(self,request,*args,**kwargs):
        print('colin: new')
        print(request.data)
        return JsonResponse(data={}, code="999999", msg="成功")

class CameraPersonWS(APIView):
    def post(self,request,*args,**kwargs):
        print(request.data)
        buf = request.data.copy()
        # if int(float(buf["c_threshold"])) == 1 and int(buf['faceid']) > 1000:
        #     stranger = Stranger.objects.filter(faceid= buf['faceid'])
        #     if not stranger:
        #         serializer = StrangerSerializer(data=buf)
        #         if serializer.is_valid():
        #             serializer.save()
        #         else:
        #             return JsonResponse(data=serializer.errors,code='999999',msg="failed")
        token_buf = buf['url'].split('/')[-1]
        buf['cameraid'] = Camera.objects.filter(c_token = token_buf).values("id")[0]['id']
        #warning_ret = []
        #warning_ret = warning_judge(buf)
        buf['datetime'] = datetime.datetime.strptime(buf['datetime'],'%Y%m%d_%H%M%S')
        serializer = PersonRealtimeSerializer(data=buf)
        if serializer.is_valid():
            serializer.save()
            getpersonreid()
        else:
            return JsonResponse(data=serializer.errors,code='999999',msg="失败")
        return JsonResponse(data={}, code="999999", msg="成功")

class CameraPlateWS(APIView):
    def post(self,request,*args,**kwargs):
        print("-----plate websocket--------")
        buf = request.data.copy()
        #if int(float(buf["c_threshold"])) == 1:
         #   serializer = PlateSerializer(data=buf)
         #   if serializer.is_valid():
         #       serializer.save()
         #   else:
         #       return JsonResponse(data=serializer.errors,code='999999',msg="failed")
        plates = Plate.objects.filter(plate_id =buf['plate_id']).count()
        # conn = redis.Redis(connection_pool=POOL_DB_TWO)
        #查询车牌是否已存在，后期可考虑用redis做查询
        if not plates:
            serializer = PlateSerializer(data=buf)
            if serializer.is_valid():
                rcv = serializer.save()
                #存对应数据到redis
                #conn.set(rcv.plate_id,rcv.id)
                #采用django-redis使用Cache
                cache.set(rcv.plate_id,rcv.id)
                buf['plate_key'] = rcv.id
        else:
            # buf_con = conn.get(buf['plate_id'])
            buf_con = cache.get(buf['plate_id'])
            buf['plate_key'] = buf_con
        print(buf)
        token_buf = buf['url'].split('/')[-1]
        #print(buf['datetime'])
        buf['cameraid'] = Camera.objects.filter(c_token = token_buf).values("id")[0]['id']
        warning_ret = []
        warning_ret = warning_judge(buf)
        #转化时间格式存进数据库中
        #print(buf['datetime'])
        buf['datetime'] = datetime.datetime.strptime(buf['datetime'],'%Y%m%d%H%M%S')
        serializer = PlateRealtimeSerializer(data=buf)
        print("1111111111111111111111111111111111111111")
        if serializer.is_valid():
            serializer.save()
            #存储数据进数据库同时存数据到车流量
            flow = caches['flow']
            plate_flow=flow.get(buf['stream_url'])
            if plate_flow:
                plate_flow['plate_num'] +=1
            else:
                buf_data = {"people_num":0,"plate_num":1}
                flow.set(buf['stream_url'],buf_data)

        #转化时间格式为str方便数据传输
        buf['datetime'] = datetime.datetime.strftime(buf['datetime'],'%Y-%m-%d %H:%M:%S')
        channel_layer = get_channel_layer()
        c_token = Camera.objects.get(pk = int(buf['cameraid'])).c_token
        conf_file = settings.CONF_FILE
        config = configparser.ConfigParser()
        config.read(conf_file,encoding="utf-8")
        print('-----plate_here--------')
        print(c_token)
        print(config['camera_detect_token']['c_token'])
        if c_token == config['camera_detect_token']['c_token']:
            print("-----token=====c_token--------")
            buf['plate_url'] = settings.FACE_IMG_REAL_ROOT_URL+buf['plate_url']
            result_all = json.dumps(buf)
            async_to_sync(channel_layer.group_send)(c_token, {"type": "user.message", 'text': result_all})
            print("websocket ok")
        return JsonResponse(data={}, code="999999", msg="成功")

class CameraWS(APIView):
    def post(self,request,*args,**kwargs):
        print("now cameraws -------- from other mechine!!!!")
        print(request.data)
        buf = request.data.copy()
        #转化时间格式存入表中
        buf['datetime'] = datetime.datetime.strptime(buf['datetime'],'%Y%m%d_%H%M%S')
        #buf['cameraid'] = str(Camera.objects.filter(c_ip= buf['cameraip']).values('id')[0]['id'])
        #stranger单独维护
        # if int(float(buf["c_threshold"])) == 1 and int(buf['faceid']) > 1000:
        #     if serializer.is_valid():
        #         serializer.save()
        #     else:
        #         return JsonResponse(data=serializer.errors,code='999999',msg="failed")
        #buf['imgurl'] = settings.FACE_IMG_REAL_ROOT_URL+buf['imgurl']
        token_buf = buf['url'].split('/')[-1]
        buf['cameraid'] = Camera.objects.filter(c_token = token_buf).values("id")[0]['id']
        warning_ret = []
        warning_ret = warning_judge(buf)
        print(buf)
        serializer = CameraRealtimeSerializer(data=buf)
        if serializer.is_valid():
            serializer.save()
        channel_layer = get_channel_layer()
        #c_token = 'token112'
        c_token = Camera.objects.get(pk = int(buf['cameraid'])).c_token
        conf_file = settings.CONF_FILE
        config = configparser.ConfigParser()
        config.read(conf_file,encoding="utf-8")
        print('-----here--------')
        print(c_token)
        print(config['camera_detect_token']['c_token'])
        #python自带的json无法识别datetime
        buf['datetime'] = datetime.datetime.strftime(buf['datetime'],'%Y-%m-%d %H:%M:%S')
        if c_token == config['camera_detect_token']['c_token']:
            if int(buf['faceid']) < 1000:
                buf['faceurl'] = FaceImg.objects.filter(userid_id=int(buf['faceid'])).values('imgurl')[0]['imgurl']
            else:
                buf['faceurl'] = ''
            buf['count'] = len(CameraRealtimeModel.objects.filter(cameraid=str(buf['cameraid'])).values('faceid').distinct())
            if warning_ret:
                print('---------hhhhiiioooo----')
                #print(warning_ret)
                warning_ret['warning_capture_url'] = settings.FACE_IMG_REAL_ROOT_URL +buf['imgurl']
                warning_type_level = WarningType.objects.get(id = (WarningEvent.objects.get(id=warning_ret['warning_event_id']).warning_type_id_id)).warning_level
                #WarningEvent.objects.get(id=warning_ret['warning_event_id'])
                warning_ret['warning_level'] = str(warning_type_level) + '级'
            buf['warning_info'] = warning_ret
            buf['imgurl'] = settings.FACE_IMG_REAL_ROOT_URL+buf['imgurl']
            result_all = json.dumps(buf)
            async_to_sync(channel_layer.group_send)(c_token, {"type": "user.message", 'text': result_all})
        else:
            print('hhhhhhhhhxxxxxxxx')
            result_all = json.dumps(buf)
            async_to_sync(channel_layer.group_send)('token_ws', {"type": "user.message", 'text': result_all})
        return JsonResponse(data={}, code="999999", msg="成功")

class CameraReal(APIView):
    def post(self,request,*args,**kwargs):
        print('hello exec detect--------------')
        print(request.data['c_id'])
        print(request.data['c_token'])
        conf_file = settings.CONF_FILE
        config = configparser.ConfigParser()
        config.read(conf_file,encoding="utf-8")
        cameraId = request.data['c_id']
        cameraToken = request.data['c_token']
        print(cameraToken)
        #camera = Camera.objects.get(pk = cameraId)
        #serializer = CameraSerializer(camera)
        #config["camera_detect_token"] = serializer.data['c_token']
        config["camera_detect_token"] = request.data
        config.write(open(conf_file,mode='w'))
        return JsonResponse(data={'e':''}, code="999999", msg="成功")

def getchecks(lists,serializer):
    print("now turn date to checks")
    print(serializer.id)
    check_frame= pd.DataFrame(lists)
    #print(check_frame)
    num = float(serializer.streamFps)
    check_frame['streamid'] = str(serializer.id)
    check_frame['timestap'] = check_frame['timestap'].astype(float)
    check_frame['time'] = check_frame['timestap']/num
    #print(check_frame)
    check_frame['timestap'] = check_frame['timestap'].astype(str)
    check_frame['url'] = check_frame['StreamUrl']
    #print(check_frame)
    check_frame = check_frame.to_dict(orient="records")
    #print(check_frame)
    return check_frame

def getpersonreid():
    #get personrealtime streamUrl not null
    personreals=PersonRealtime.objects.filter(~Q(StreamUrl = ""))
    streamurls = personreals.values("StreamUrl").distinct()
    print("getpersonreid!!!!!!!")
    for streamurl in streamurls:
        camerastream_streamurl = settings.FACE_IMG_REAL_ROOT_URL+streamurl['StreamUrl']
        print(camerastream_streamurl)
        camerastream_buf = CameraStreamModel.objects.filter(streamUrl = camerastream_streamurl).values('id','streamFps')
        if len(camerastream_buf):
            personreals_buf = PersonRealtime.objects.filter(StreamUrl = streamurl['StreamUrl'])
            personreals_values=personreals_buf.values("faceid",'query_imgurl','imgurl','StreamUrl',"c_x",'c_y','c_w','c_h','c_threshold','timestap','datetime')
            person_len = len(personreals_values)
            person_frame = pd.DataFrame(list(personreals_values))
            streamid = camerastream_buf[0]['id']
            num = float(camerastream_buf[0]['streamFps'])
            person_frame['streamid'] = str(streamid)
            person_frame['timestap'] = person_frame['timestap'].astype(float)
            person_frame['time'] = person_frame['timestap']/num
            person_frame['timestap'] = person_frame['timestap'].astype(str)
            person_frame['url'] = person_frame['StreamUrl']
            personreid_buf = person_frame.to_dict(orient="records")
            personreids = PersonReidSerializer(data=personreid_buf,many=True)
            if personreids.is_valid():
                personreids.save()
                camerastream_personnum = CameraStreamModel.objects.get(id= streamid)
                camerastream_personnum.personNum = camerastream_personnum.personNum+person_len
                camerastream_personnum.save()
                # personrealtime表StreamUrl置空
                realtimes = personreals_buf.update(StreamUrl='')

def rtsp_result(c_token,hostname,port,username,password,private,tail):
    channel_layer = get_channel_layer()
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    if password:
        ssh.connect(hostname=hostname, port=port, username=username,password=password)
    else:
        pkey = paramiko.RSAKey.from_private_key_file(private)
        ssh.connect(hostname=hostname, port=port, username=username, pkey=pkey)
    cmd = "sh " + tail
    print(cmd)
    stdin, stdout, stderr = ssh.exec_command(cmd)
    print('99990000999999')
    for line in iter(stdout.readline, ""):
        result = {"status": 0, 'data': line}
        print(result)
        result_all = json.dumps(result)
        print("hello nihao aaaaa")
        async_to_sync(channel_layer.group_send)(c_token, {"type": "user.message", 'text': result_all})

    result_all = 'mmmdddd!fu'
    async_to_sync(channel_layer.group_send)(c_token, {"type": "user.message", 'text': result_all})

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

def warning_judge(buf):
    print('-----start judge-----')
    warningevent = WarningEvent.objects.all()
    serializer = WarningEventSerializer(warningevent, many=True)
    result_list = serializer.data
    for i in range(len(serializer.data)):
        warning_thing = {}
        result = {}
        print(serializer.data[i])
        if(str(buf['cameraid']) in serializer.data[i]['warning_target_camera'].split('.') and serializer.data[i]['warning_event_flag'] == 1):
            #python没有switch语句，使用多个if判断,目标行人，目标车辆，徘徊，车流量上限等
            warning_thing = {}
            result = {}
            if( serializer.data[i]['warning_target_people'] != None and buf.get('faceid') and str(buf['faceid']) in serializer.data[i]['warning_target_people'].split('.') ):
                print('-----target-----')
                warning_thing['warning_camera_id'] = buf['cameraid']
                warning_thing['warning_video_url'] = buf['StreamUrl']
                warning_thing['warning_capture_url'] = buf['imgurl']
                warning_thing['warning_target_url'] = FaceImg.objects.filter(userid_id=int(buf['faceid'])).values('imgurl')[0]['imgurl']
                warning_thing['warning_event_id'] = serializer.data[i]['id']
                warning_thing['warning_message'] = '目标行人事件'
                warning_thing['warning_color'] = 1
                warning_thing['warning_time'] = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
                warning_history_serializer = WarningHistorySerializer(data=warning_thing)
                if warning_history_serializer.is_valid():
                    warning_history_serializer.save()
                    return warning_thing
        if( serializer.data[i]['warning_target_car'] != None and buf.get("plate_key") and str(buf['plate_key']) in serializer.data[i]['warning_target_car'].split('.') ):
            print('--------target car!!------------')
            warning_thing['warning_camera_id'] = buf['cameraid']
            #车牌内无imgurl，无StreamUrl，后期统一修改
            warning_thing['warning_video_url'] = buf.get('StreamUrl')
            warning_thing['warning_capture_url'] = buf['plate_url']
            warning_thing['warning_target_url'] = settings.FACE_IMG_REAL_ROOT_URL+Plate.objects.get(pk=buf['plate_key']).plate_url
            warning_thing['warning_event_id'] = serializer.data[i]['id']
            warning_thing['warning_message'] = '目标车辆'
            warning_thing['warning_color'] = 1
            warning_thing['warning_time'] = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
            warning_history_serializer = WarningHistorySerializer(data=warning_thing)
            if warning_history_serializer.is_valid():
                warning_history_serializer.save()
                return warning_thing
        if( serializer.data[i]['warning_target_people'] == None and serializer.data[i]['warning_target_car'] == None and
 serializer.data[i]['warning_people_max'] == '0' and serializer.data[i]['warning_car_max'] == '0' and float(buf['c_threshold']) == 1 and int(buf['faceid']) > 1000):
            print('-----stranger!!!!!!!-----')
            warning_thing['warning_camera_id'] = buf['cameraid']
            warning_thing['warning_video_url'] = buf['StreamUrl']
            warning_thing['warning_capture_url'] = buf['imgurl']
            warning_thing['warning_event_id'] = serializer.data[i]['id']
            warning_thing['warning_message'] = '陌生人事件'
            warning_thing['warning_color'] = 2
            warning_thing['warning_time'] = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
            warning_history_serializer = WarningHistorySerializer(data=warning_thing)
            if warning_history_serializer.is_valid():
                warning_history_serializer.save()
                return warning_thing

            print('-----default not warning-----')
            #warning_thing['warning_time'] = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
    print('------------------------------------------------')
    result = warning_thing
    return result



cameras = CameraView.as_view()
camera_real = CameraReal.as_view()
camera_ws = CameraWS.as_view()
camera_plate_ws = CameraPlateWS.as_view()
camera_person_ws = CameraPersonWS.as_view()
camera_stream = CameraStream.as_view()
camera_record = CameraRecord.as_view()
camera_record_for_cs = CameraRecordForCS.as_view()
