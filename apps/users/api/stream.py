from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import Stream , Check , PersonReid
from apps.users.serializers import StreamSerializer
from rest_framework import serializers
from apps.users.utility import TokenVerify
import cv2

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
            streams = Stream.objects.all()
            serializer = StreamSerializer(streams, many=True)
            streamlocations = Stream.objects.all().values('streamlocation').distinct()
            newlist = []
            for streamlocation in streamlocations:
                ret1 = {}
                ret1['label']=streamlocation['streamlocation']
                ret1['streamlng'] = []
                streamnames = Stream.objects.filter(streamlocation=streamlocation['streamlocation']).values('streamname','id','streamlon','streamlat')
                ret2 = []
                for streamname in streamnames:
                    ret3 = {}
                    ret3['id'] = streamname['id']
                    ret3['label'] = streamname['streamname']
                    ret3['streamlng'] = []
                    ret3['streamlng'].append([streamname['streamlon'],streamname['streamlat']])
                    ret1['streamlng'].append([streamname['streamlon'], streamname['streamlat']])
                    ret2.append(ret3)
                ret1['children'] = ret2
                newlist.append(ret1)
            return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data) , 'streamList':newlist}, code='999999',
                                    msg='success')
        # params里带map_location摄像头位置余力的GET请求用于做树形结构
        if (request.GET.get('map_location') == 'GETMAP'):
            streamlngs = Stream.objects.all().values('streamlon','streamlat')
            newlist = []
            ret = []
            lon = 0
            lat = 0
            ret = []
            for streamlng in streamlngs:
                newlist.append([streamlng['streamlon'],streamlng['streamlat']])
                lon = lon+float(streamlng['streamlon'])
                lat = lat + float(streamlng['streamlat'])
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


stream_list = StreamView.as_view()
stream_add = StreamAddorupload.as_view()
stream_check = StreamCheck.as_view()
