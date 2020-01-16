from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.serializers import CheckSerializer
from apps.users.models import Check as CheckModel
from apps.users.models import FaceImg as FaceImgModel
from django.conf import settings
from apps.users.models import Stream as StreamModel
from apps.users.models import Face as FaceModel
from apps.users.models import Stranger as StrangerModel
from apps.users.models import PersonReid as PersonReidModel
from apps.users.models import MatchUp as MatchUpModel
from collections import OrderedDict
from itertools import chain

import random,json

from apps.users.models import CameraStream as CameraStreamModel
from apps.users.models import Camera as CameraModel

class Check(APIView):

    def post(self, request, *args, **kwargs):
        print("check post now!")
        tempUrl = request.data.get('url')
        #streamid = StreamModel.objects.filter(streamurl=settings.FACE_IMG_CHECK_ROOT_URL+tempUrl).values("id","streamfps")[0]
        #streamid = CameraStreamModel.objects.filter(streamUrl=settings.FACE_IMG_CHECK_ROOT_URL+tempUrl).values("id","streamFps")[0]
        streamid = CameraStreamModel.objects.filter(streamUrl=settings.FACE_IMG_CHECK_ROOT_URL+ tempUrl).values("id","streamFps")[0]
        buf = request.data.copy()
        buf['streamid'] = streamid['id']
        ######现在是相对时间，绝对时间的话得加上当前视频流的开始时间
        # timebuf = float(buf['timestap'])/float(streamid['streamfps'])
        timebuf = float(buf['timestap']) / float(streamid['streamFps'])
        buf['time'] = str(round(timebuf,2))
        print(buf)
        serializer = CheckSerializer(data=buf)
        print(serializer)
        if serializer.is_valid():
            #这里可以解析post上传数据，再存储，目前做个简单的
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    def get(self, request, *args, **kwargs):
        # 获取所有人脸的检测信息信息
        faceid = request.GET.get('faceid')
        streamid = request.GET.get('streamid')
        faceid = str(faceid)
        streamid = str(streamid)
        #如果只有streamid,没有faceid
        if (faceid =='None' or faceid == '') and (streamid != 'None' and streamid != ''):
            print("---------Only-----streamid--------------")
            checks = CheckModel.objects.filter(streamid=streamid) #流
            personreids = PersonReidModel.objects.filter(streamid = streamid)
            checkids1 = checks.values('faceid').distinct()
            checkids2 = personreids.values('faceid').distinct()
            checkids = list(checkids1)+list(checkids2)
            ###这块修改得改下camerastream表加上streamname字段
            # name = StreamModel.objects.get(pk=int(streamid)).streamname
            name = CameraStreamModel.objects.get(pk=int(streamid)).startTime
            # streamtime = float(StreamModel.objects.get(pk=int(streamid)).streamtime)
            streamtime = float(CameraStreamModel.objects.get(pk=int(streamid)).streamTime)
            ret = []
            i = 0
            faceids = []
            for face in checkids:
                if face['faceid'] in faceids:
                    continue
                faceids.append(face['faceid'])
                i+=1
                newlist = {}
                newlist1 = {}
                face_id = int(face["faceid"])
                if face_id < 1000:
                    newlist['facename'] = FaceModel.objects.get(pk=face_id).username
                    newlist['faceurl']  = FaceImgModel.objects.filter(userid = face_id).values('imgurl')[0]['imgurl']
                else:
                    newlist['facename'] = "陌生人"+face['faceid']
                    # print(CheckModel.objects.filter(faceid=face['faceid']).values('imgurl')[0]['imgurl'])
                    newlist['faceurl']  = settings.FACE_IMG_REAL_ROOT_URL+CheckModel.objects.filter(faceid=face['faceid']).values('imgurl')[0]['imgurl']
                newlist['facecount'] = len(checks.filter(faceid=face['faceid']))+len(personreids.filter(faceid=face['faceid']))
                newlist1 = getfacemarkers(checks , personreids,face_id)
                newlist['facetime'] =  newlist1['facetime']
                newlist['marks']  = newlist1['marks']
                newlist['url'] = newlist1['url']
                newlist['person_url'] = newlist1['person_url']
                ret.append(newlist)
                print(i)
            # print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
            print("---------5--------------")
            newlist = {}
            newlist['streamname'] = name
            newlist['streamtime'] = streamtime
            newlist['facematch'] = ret
            print("---------6--------------")
            serializer1 =getmarkers(list(checks),list(personreids))
            print("---------7--------------")
            #serializer2 = getmarkers(personreids)
            serializer2 = {}
            return JsonResponse(data={'list': serializer1, 'count': len(serializer1) , 'info':newlist,'list_reid':serializer2}, code='999999',
                                msg='success')
        #faceid和streamid都没有
        elif (faceid =='None' or faceid == '') and (streamid == 'None' or streamid == ''):
            print("no faceid no streamid")
            lists = []
            checks = CheckModel.objects.values('faceid', 'streamid', 'url').distinct()
            #checks = list(checks)
            personreids = PersonReidModel.objects.values("faceid","streamid","url").distinct()
            matchs = list(checks)+list(personreids)
            imgs = []
            faceids = set()
            for ind, item in enumerate(matchs):
                print(ind)
                faceid = item['faceid']
                streamid = item['streamid']
                if faceid in faceids:
                    continue
                faceids.add(faceid)
                rets = item
                #stream = StreamModel.objects.get(pk=streamid)
                try:
                    stream = CameraStreamModel.objects.get(pk=int(streamid))
                except:
                    continue
                # item['streamname'] = stream.streamlocation + '-' + stream.streamname
                ###暂时还没有streamName字段
                # camera =CameraModel.objects.get(pk = int(stream.cameraId))
                item['streamname'] = stream.cameraId.cameraLocation + '-' + stream.cameraId.cameraName
                print(int(faceid))
                if int(faceid) < 1000:
                    username = FaceModel.objects.get(pk=faceid).username
                    img = FaceImgModel.objects.filter(userid_id=faceid).values('userid_id', 'imgurl')
                    img[0]['username'] = username
                    img = img[0]
                    rets['facename'] = username
                else:
                    username = "陌生人"+'-'+faceid
                    try:
                        strangers = MatchUpModel.objects.get(faceid=str(faceid))
                        img = {"user_id":strangers.faceid,"imgurl":settings.FACE_IMG_CHECK_ROOT_URL+strangers.dec_img_url}
                    except:
                        strangers = StrangerModel.objects.filter(faceid = faceid).values('faceid','imgurl')
                        img = {"user_id":strangers[0]['faceid'],"imgurl":settings.FACE_IMG_CHECK_ROOT_URL+strangers[0]['imgurl']}
                    img['username'] = username
                    item['facename'] = username
                imgs.append(img)
                lists.append(rets)
                # if ind == 1:break

            return JsonResponse(data={'list': lists, 'count': len(checks), 'imgList':imgs}, code='999999', msg='success')
        # 获取某一个具体人脸的信息，只有faceid，没有streamid
        elif ((faceid != 'None' and faceid != '') and (streamid == 'None' or streamid == '')):
            print("Only faceid")
            print(faceid)
            checks = CheckModel.objects.filter(faceid=faceid).values('faceid','streamid','time','url').distinct()
            personreids =PersonReidModel.objects.filter(faceid = faceid).values("faceid","streamid","time",'url').distinct()
            imgs = []
            if int(faceid)< 1000:#集合陌生人
                imgs = FaceImgModel.objects.filter(userid_id=faceid).values('userid_id', 'imgurl')
            else:
                try:
                    img = {'imgurl': settings.FACE_IMG_CHECK_ROOT_URL +MatchUpModel.objects.get(faceid=str(faceid)).dec_img_url,'userid_id': faceid}
                except:
                    img = {'imgurl':settings.FACE_IMG_CHECK_ROOT_URL+CheckModel.objects.filter(faceid = faceid).values('imgurl')[0]['imgurl'],'userid_id':faceid}
                imgs.append(img)
            matchs = list(checks)+list(personreids)
            #根据time做排序（默认所有视频都是同一时间开始）
            matchs.sort(key=lambda k: (float(k.get('time'))), reverse=False)
            times = []
            locations = []
            front_location = []
            streamids = []
            cameraids = []
            markers = []
            rcv = []
            for match in matchs:

                if int(faceid)< 1000:
                    face = FaceModel.objects.get(pk=faceid)
                    match['facename'] = face.username
                else:
                    match['facename'] = "陌生人"+faceid
                stream = CameraStreamModel.objects.get(pk=int(match['streamid']))
                camera = stream.cameraId
                match['streamname'] = camera.cameraLocation + '-' + camera.cameraName
                time = match['time']
                if time in times:
                    continue
                if not times:
                    front_location = [float(camera.cameraLon), float(camera.cameraLat)]
                    match_location = front_location
                else:
                    sencond_location = [float(camera.cameraLon), float(camera.cameraLat)]
                    match_location = getmovelocation(front_location,sencond_location)
                    front_location = sencond_location
                times.append(time)
                locations.append(match_location)
                if match['streamid'] in streamids:
                    continue
                streamids.append(match['streamid'])
                rcv.append(match)
                #封装标记点
                if camera.id in cameraids:
                    continue
                cameraids.append(camera.id)
                markers.append((camera.cameraLon,camera.cameraLat))

            imgs = list(imgs)
            print(locations)
            print(rcv)

            return JsonResponse(data={'list': list(rcv), 'count': len(matchs), 'imgList':imgs,'location':list(locations),'Markers':markers}, code='999999', msg='success')
        #faceid和streamid都有
        elif ((faceid != 'None' and faceid != '') and (streamid != 'None' and streamid != '')):
            checks = CheckModel.objects.filter(faceid=faceid, streamid=streamid).values('faceid', 'time', 'imgurl','c_threshold')
            checks_list = list(checks)
            for ind, item in enumerate(checks_list):
                imgs = []
                imgs.append({'imgurl':settings.FACE_IMG_CHECK_ROOT_URL+item['imgurl'] , 'threshold': item['c_threshold']})
                checks_list[ind]['imgList'] = imgs
                #item['imgurl'] = settings.FACE_IMG_CHECK_ROOT_URL+item['imgurl']
            return JsonResponse(data={'list': list(checks_list), 'count': len(checks_list)}, code='999999', msg='success')
        else:
            return JsonResponse(data={}, code="999999", msg="成功")


class CheckLocations(APIView):
    def get(self, request, *args, **kwargs):
        faceid = request.GET.get('faceid')
        if(faceid != 'None' and faceid != ''):
            checks = CheckModel.objects.filter(faceid=faceid).values('streamid').distinct()
            newlist = {}
            ret = []
            i = 0
            centerlon = 0
            centerlat = 0
            for check in checks:
                # ret1 = StreamModel.objects.get(pk=check['streamid'])
                stream= CameraStreamModel.objects.get(pk =int(check['streamid']))
                ret1 = CameraModel.objects.get(pk=int(stream.cameraId))
                ret2 = []
                # centerlon += float(ret1.streamlon)
                # centerlat += float(ret1.streamlat)
                # ret2.append(ret1.streamlon)
                # ret2.append(ret1.streamlat)
                centerlon += float(ret1.streamLon)
                centerlat += float(ret1.streamLat)
                ret2.append(ret1.streamLon)
                ret2.append(ret1.streamLat)
                ret.append(ret2)
                i+= 1
            newlist['location'] = ret
            newlist['center'] = [centerlon/i,centerlat/i]
            return JsonResponse(data=newlist, code="999999", msg="成功")

#按流查询后端数据处理过程
def getmarkers(data,data1):
    res = []
    len1 =len(data)
    print("66---------(1)--------------")
    data = data+data1
    print("66---------(2)--------------")
    for i,marker in enumerate(data):
        newlist = {}
        # if i < len1:
        #     flag = "0"
        # else:
        #     flag = "1"
        for marker_data in res:
            if marker.time == marker_data['time']:
                newlist = {'id':marker.faceid,'imgurl':settings.FACE_IMG_REAL_ROOT_URL+marker.imgurl,'threshold':marker.c_threshold,}
                if i < len1:
                    marker_data['imgList'].append(newlist)
                else:
                    marker_data['personList'].append(newlist)
                break

        if newlist:
            print('same time')
        else:
            if i < len1:
                res.append({'time': marker.time, 'imgList':[{'id':marker.faceid,'imgurl':settings.FACE_IMG_REAL_ROOT_URL+marker.imgurl,'threshold':marker.c_threshold}],'personList':[],'width':"50%"})
            else:
                res.append({'time': marker.time, 'personList': [
                    {'id': marker.faceid, 'imgurl': settings.FACE_IMG_REAL_ROOT_URL + marker.imgurl,
                     'threshold': marker.c_threshold}], 'imgList': [], 'width': "50%"})
    # for marker in data1:
    #     newlist = {}
    #     for marker_data in res:
    #         if marker.time == marker_data['time']:
    #             newlist = {'id':marker.faceid,'imgurl':settings.FACE_IMG_CHECK_ROOT_URL+marker.imgurl,'threshold':marker.c_threshold,'flag':"1"}
    #             marker_data['imgList'].append(newlist)
    #             break
    #     # if newlist:
    #     #     print('same time')
    #     else:
    #         res.append({'time': marker.time, 'imgList':[{'id':marker.faceid,'imgurl':settings.FACE_IMG_CHECK_ROOT_URL+marker.imgurl,'threshold':marker.c_threshold,'flag':"1"}],
    #                         'width':"50%"})
    return res

def getfacemarkers(data,reiddata,fid):
    back = []
    facechecks = data.filter(faceid = fid)
    facereids =reiddata.filter(faceid = fid)
    # matchs = list(facechecks)+list(facereids)
    matchs = list(facechecks)
    mark = {}
    url = {}
    reback = {}
    style = '{"style":{"color":"#FF2D2D"},"label":"1s"}'
    for marker in matchs:
        newlist={}
        newlist['time'] = marker.time
        newlist['imgurl'] = settings.FACE_IMG_REAL_ROOT_URL+marker.imgurl
        newlist['threshold'] = marker.c_threshold
        time=marker.time
        time = [str(time),int(time)][int(time)==time]
        mark[time] = ''
        url[time] = settings.FACE_IMG_REAL_ROOT_URL+marker.imgurl
        back.append(newlist)
    #给列表back按照列表内字典的time来做升序
    reback['facetime'] = sorted(back, key=lambda back:back['time'], reverse=False)
    if len(facereids):
        reback['person_url'] = settings.FACE_IMG_REAL_ROOT_URL+facereids[0].imgurl
    else:
        reback['person_url'] = ''
    reback['marks'] = mark
    reback['url'] = url
    print(reback)
    return reback


class CheckTrack(APIView):

    def get(self,request,*args,**kwargs):
        msg_data = "成功"
        print("check track record get!")
        faces1 = list(CheckModel.objects.values('faceid').distinct())
        faces2 = list(PersonReidModel.objects.values('faceid').distinct())
        faces = faces1 + faces2
        # faces = list_dict_duplicate_removal(faces)
        # print(faces)
        #return JsonResponse(data={}, code="999999", msg="成功"
        #checks = list(checks)
        lists = []
        faceids = []
        cols = ["#a33038","#005195","#008998","#ae005f","#ba8b00","#c94d00","#009974","#C2C2C2","#CD00CD","#CD6600","#8fd400","#0095c3","#f5d312",]
        for face in faces:
            if face['faceid'] in faceids:
                continue
            faceids.append(face['faceid'])
            newlist = {}
            #locationlist = []
            #list['faceid'] = face['faceid']
            streamids1 = CheckModel.objects.filter(faceid = face['faceid']).values('streamid','timestap').distinct()
            streamids2 = PersonReidModel.objects.filter(faceid = face['faceid']).values('streamid','timestap').distinct()
            streamids = list(streamids1)+list(streamids2)
            # print(streamids)
            ##根据timestap做排序
            streamids.sort(key=lambda k: (int(k.get('timestap'))), reverse=False)
            # print(streamids)
            locations = []
            for i,value in enumerate(streamids):
                # location = StreamModel.objects.filter(id=value['streamid']).values('streamlat','streamlon')[0]
                stream = CameraStreamModel.objects.get(pk=int(value['streamid']))
                print(stream)
                location = stream.cameraId
                #print(location_id)
                #location = CameraModel.objects.get(pk=int(location_id))
                #return JsonResponse(data={}, code="999999", msg="")
                if i>0:
                    # if a == [float(location['streamlon']), float(location['streamlat'])]:
                    if a == [float(location.cameraLon), float(location.cameraLat)]:
                        continue
                    # b =getmovelocation(a,[float(location['streamlon']),float(location['streamlat'])])
                    b = getmovelocation(a, [float(location.cameraLon), float(location.cameraLat)])
                    #[locations[0][0],locations[0][1],location['streamlon'],location['streamlat']]
                    locations.append(b)
                    #locationlist.append(locations)
                    #locations = []
                else:
                    # a = [float(location['streamlon']), float(location['streamlat'])]
                    a = [float(location.cameraLon), float(location.cameraLat)]
                    locations.append(a)
                # a = [float(location['streamlon']), float(location['streamlat'])]
                a = [float(location.cameraLon), float(location.cameraLat)]
            if cols:
                col = random.choice(cols)
                newlist['color'] = col
                cols.remove(col)
                print(len(cols))
            else:
                msg_data ="已达到上限"
                break

            #newlist['location'] = locationlist if locationlist else [locations[0],[locations[0][0]+0.000001,locations[0][1],locations[0][0]+0.000002,locations[0][1]]]
            if int(face['faceid']) < 1000:
                face_msg = FaceModel.objects.get(pk = int(face['faceid']))
                face_img = FaceImgModel.objects.filter(userid=int(face['faceid'])).values("imgurl")[0]
                newlist['facename'] = face_msg.username
                newlist['faceimgurl'] = settings.FACE_IMG_CHECK_ROOT_URL+face_img['imgurl']
            else:
                try:
                    face_img = MatchUpModel.objects.get(faceid=str(face['faceid']))
                    newlist['faceimgurl'] = settings.FACE_IMG_CHECK_ROOT_URL+face_img.dec_img_url
                except:
                    face_img = StrangerModel.objects.filter(faceid=face['faceid']).values('id', 'imgurl')[0]
                    newlist['faceimgurl'] = settings.FACE_IMG_CHECK_ROOT_URL+face_img['imgurl']
                newlist['facename'] = '陌生人-'+str(face['faceid'])
            newlist['faceid'] = face['faceid']
            newlist['location'] = locations
            lists.append(newlist)
                # print("1111111111111111111111111111")
                # print(locations)
                # if i>0:
                #     break
            # for streamid in streamids:
            #     list['location'] = {}
            #     #print(streamid)
            #     location = StreamModel.objects.filter(id=streamid['streamid']).values('streamlat','streamlon')[0]
            #     print("11111111111111111")
            #     a = [location['streamlon'],location['streamlat']]
            #     locations.append(a)
                #list['location'].append([StreamModel.objects.get(pk=streamid)['streamlon'],])
        #做轨迹的Marker标记
        streams_check = CheckModel.objects.values("streamid").distinct()
        streams_personreid = PersonReidModel.objects.values("streamid").distinct()
        stream_all = list(streams_check)+list(streams_personreid)
        streamids = []
        cameras = []
        locations = []
        for stream in stream_all:
            if stream['streamid'] in streamids:
                continue
            streamids.append(stream['streamid'])
            camera = CameraStreamModel.objects.get(pk=stream['streamid']).cameraId
            if camera.id in cameras:
                continue
            cameras.append(camera.id)
            locations.append((camera.cameraLon,camera.cameraLat))
        return JsonResponse(data={'list':lists , 'Markers':locations}, code="999999", msg=msg_data)
        # return JsonResponse(data={}, code="999999", msg="成功")


# def list_dict_duplicate_removal(data_list):
#     run_function = lambda x, y: x if y in x else x + [y]
#     return reduce(run_function, [[], ] + data_list)

def getmovelocation(buf1,buf2):
    midlocation = [(buf1[0]+buf2[0])/2,(buf1[1]+buf2[1])/2]
    a = buf2[0]-buf1[0]
    b = buf2[1]-buf1[1]
    n = random.uniform(0.2,0.5)
    # print("11111111111111111")
    # print(n)
    # print("222222222222222222")
    rec = [midlocation[0]-n*b,midlocation[1]+n*a]
    #rec = [midlocation[0]+float(mov/100000),midlocation[1]+float(mov/100000)] if i else [midlocation[0]-float(mov/1000000),midlocation[1]-float(mov/1000000)]
    # rec = [buf1[0] + float(mov / 1000000), buf1[1] + float(mov / 1000000)] if i else [
    #     buf1[0] - float(mov / 1000000), buf1[1] - float(mov / 1000000)]
    rec = [rec[0],rec[1],buf2[0],buf2[1]]
    return rec

check_face = Check.as_view()
check_location = CheckLocations.as_view()
check_track = CheckTrack.as_view()
