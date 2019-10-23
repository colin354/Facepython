from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import Stream , Check , PersonReid,Camera,CameraStream
from apps.users.serializers import StreamSerializer
from rest_framework import serializers
from apps.users.utility import TokenVerify
import cv2
import datetime

class StreamCheck(APIView):
    def post(self, request, *args, **kwargs):
        streams = Stream.objects.all().update(streamstatus = "1")
        return JsonResponse(data={}, code="999999", msg="成功")


class StreamAddorupload(APIView):
    TOKEN = 'token'
#新增功能
    # 调用Token验证
    @TokenVerify
    def post(self, request, *args, **kwargs):
        cap = cv2.VideoCapture(request.data['streamurl'])
        if cap.isOpened():  # 当成功打开视频时cap.isOpened()返回True,否则返回False
            rate = cap.get(5)  # 帧速率
            frame_number = cap.get(7)  # 视频文件的帧数
            seconds = frame_number / rate
            rate = ("%.1f" % rate)
            seconds = ("%.1f" % seconds)
            request.data['streamfps'] = str(rate)
            request.data['streamtime'] = str(seconds)
            serializer = StreamSerializer(data=request.data)
            if serializer.is_valid():
                print('11111111111111111111111111')
                stream = serializer.save()
                return JsonResponse(data={}, code="999999", msg="成功")
            return JsonResponse(data=serializer.errors, code="-1", msg="失败")
        return JsonResponse(data={}, code="-1", msg="无效的streamurl")

#修改功能
    # 调用Token验证
    @TokenVerify
    def put(self, request, *args, **kwargs):
        request.data['flag'] = Stream.UPDATE
        stream = Stream.objects.get(id=request.data['id'])
        print(request.data['streamurl'])
        print(stream.streamurl)
        if(request.data['streamurl'] != stream.streamurl):
            cap = cv2.VideoCapture(request.data['streamurl'])
            if cap.isOpened():  # 当成功打开视频时cap.isOpened()返回True,否则返回False
                rate = cap.get(5)  # 帧速率
                frame_number = cap.get(7)  # 视频文件的帧数
                seconds = frame_number / rate
                rate =("%.1f"%rate)
                seconds = ("%.1f" % seconds)
                request.data['streamfps'] = str(rate)
                request.data['streamtime'] = str(seconds)
            else:
                return JsonResponse(data={}, code="-1", msg="无效的streamurl")
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
        # print("111111111111111111111111111")
        # print(request.GET.get('map_location'))
        # print("222222222222222222222222222")
        #params里带map_location摄像头位置预览的GET请求获取所谓视频信息用于做点标记
        if(request.GET.get('map_location') == 'GETLOCATION'):
            # streams = Stream.objects.all()
            # serializer = StreamSerializer(streams, many=True)
            streamlocations = Stream.objects.all().values('streamlocation').distinct()
            cameralocations = Camera.objects.all().values('cameraLocation').distinct()
            newlist = []
            for cameralocation in cameralocations:
                ret1 = {}
                ret1['label']=cameralocation['cameraLocation']
                ret1['streamlng'] = []
                # streamnames = Stream.objects.filter(streamlocation=streamlocation['streamlocation']).values('streamname','id','streamlon','streamlat','streamurl')
                cameranames = Camera.objects.filter(cameraLocation=cameralocation['cameraLocation']).values(
                    'cameraName', 'id', 'cameraLon', 'cameraLat', 'c_token')
                ret2 = []
                for cameraname in cameranames:
                    ret3 = {}
                    ret3['id'] = cameraname['id']
                    ret3['label'] = cameraname['cameraName']
                    # ret3['streamUrl'] = streamname['streamurl']
                    ret3['streamlng'] = []
                    ret3['streamlng'].append([cameraname['cameraLon'],cameraname['cameraLat']])
                    ret1['streamlng'].append([cameraname['cameraLon'], cameraname['cameraLat']])
                    ret2.append(ret3)
                ret1['children'] = ret2
                newlist.append(ret1)
            return JsonResponse(data={'streamList':newlist}, code='999999',
                                    msg='success')
        # params里带map_location摄像头位置余力的GET请求用于做树形结构
        if (request.GET.get('map_location') == 'GETMAP'):
            # streamlngs = Stream.objects.all().values('streamlon','streamlat')
            cameralngs = Camera.objects.all().values('cameraLon','cameraLat')
            newlist = []
            ret = []
            lon = 0
            lat = 0
            ret = []
            for cameralng in cameralngs:
                newlist.append([cameralng['cameraLon'],cameralng['cameraLat']])
                lon = lon+float(cameralng['cameraLon'])
                lat = lat + float(cameralng['cameraLat'])
            i = len(newlist)
            if i!=0:
                ret = [lon/i,lat/i]
            return JsonResponse(data={'list': newlist, 'count': len(newlist),'center':ret},code='999999',msg='success')

        # print("333333333333333333333333333333")
        # print(request.GET.get('streamlocation'))
        # print("44444444444444444444444444444")
        # if (request.GET.get('streamlocation') != None) and (request.GET.get('streamlocation') != ""):
        #     streams = Stream.objects.filter(streamlocation=request.GET['streamlocation']).values('streamlon','streamlat').distinct()
        #     return JsonResponse(data={'list': streams, 'count': len(streams)}, code='999999',
        #                         msg='success')
        if request.path_info.strip('/').split('/')[-1].isdigit() == False:
            a = int(request.GET['limit'])
            b = int(request.GET['page'])
            start = a * (b - 1)
            end = a * b
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!获取所有信息")
            streamsall = Stream.objects.all().values('id','streamname','streamlocation','streamurl','streamlat','streamlon','flag','createDate','streamtime','streamfps','streamstatus')
            streams = streamsall[start:end]
            for stream in streams:
                stream['check_match'] = len(Check.objects.filter(streamid=stream['id']))+len(PersonReid.objects.filter(streamid=stream['id']))
            newlist = {}
            newlist['videonum'] = len(streamsall)
            newlist['finishmatch'] = len(Stream.objects.filter(streamstatus='1'))
            newlist['check_num'] = len(Check.objects.all())+len(PersonReid.objects.all())
            newlist['check_percentage'] = 0 if (newlist['videonum']==0) else (int(newlist['finishmatch'] / newlist['videonum'] * 100))
            #serializer = StreamSerializer(streams, many=True)
            #print(serializer)
            return JsonResponse(data={'list': streams, 'count': len(streamsall),'check_info':newlist}, code='999999',
                    msg='success')
        else:
            #通过ID获取单个数据
            stream_id = int(request.path_info.split('/')[-1])
            stream = Stream.objects.get(id=stream_id)
            serializer = StreamSerializer(stream)
            return JsonResponse(data=serializer.data, code='999999', msg='success')



class  VideoStruct(APIView):
    @TokenVerify
    def get(self, request, *args, **kwargs):
        cameralocations = Camera.objects.all().values('cameraLocation').distinct()
        newlist = []
        for cameralocation in cameralocations:
            ret1 = {}
            ret1['label'] = cameralocation['cameraLocation']
            # ret1['streamlng'] = []
            # streamnames = Stream.objects.filter(streamlocation=streamlocation['streamlocation']).values('streamname','id','streamlon','streamlat','streamurl')
            cameranames = Camera.objects.filter(cameraLocation=cameralocation['cameraLocation']).values(
                'cameraName','id')
            ret2 = []
            for cameraname in cameranames:
                ret3 = {}
                # ret3['id'] = cameraname['id']
                ret3['label'] = cameraname['cameraName']
                camerastreams = CameraStream.objects.filter(cameraId_id=int(cameraname['id'])).values('startTime','streamUrl','id')
                #ret3['children'] = list(camerastreams)
                for camerastream in camerastreams:
                    ret5 = []
                    ret4 = {}
                    match_num  = len(Check.objects.filter(streamid=str(camerastream['id'])))+len(PersonReid.objects.filter(streamid=str(camerastream['id'])))
                    print(camerastream['startTime'])
                    print(type(camerastream['startTime']))
                    ret4['label'] = camerastream['startTime'].strftime("%Y-%m-%d %H:%M:%S") +"("+"匹配次数"+str(match_num)+")"
                    ret4['id'] = camerastream['id']
                    ret4['streamUrl'] = camerastream['streamUrl']
                    ret5.append(ret4)
                    ret3['children'] = ret5
                # ret3['streamUrl'] = streamname['streamurl']
                # ret3['streamlng'] = []
                # ret3['streamlng'].append([cameraname['cameraLon'], cameraname['cameraLat']])
                # ret1['streamlng'].append([cameraname['cameraLon'], cameraname['cameraLat']])
                ret2.append(ret3)
            ret1['children'] = ret2
            newlist.append(ret1)
        print(newlist)
        return JsonResponse(data={'streamList': newlist}, code='999999',
                            msg='success')


stream_list = StreamView.as_view()
stream_add = StreamAddorupload.as_view()
stream_check = StreamCheck.as_view()
video_structred = VideoStruct.as_view()
