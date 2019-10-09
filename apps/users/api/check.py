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
from collections import OrderedDict
from itertools import chain

import random

class Check(APIView):

    def post(self, request, *args, **kwargs):
        tempUrl = request.data.get('url')
        streamid = StreamModel.objects.filter(streamurl=settings.FACE_IMG_CHECK_ROOT_URL+tempUrl).values("id","streamfps")[0]
        buf = request.data.copy()
        buf['streamid'] = streamid['id']
        timebuf = float(buf['timestap'])/float(streamid['streamfps'])
        buf['time'] = str(round(timebuf,2))
        serializer = CheckSerializer(data=buf)
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
        #如果只有streamid,没有faceid
        if (faceid =='None' or faceid == '') and (streamid != 'None' and streamid != ''):
            checks = CheckModel.objects.filter(streamid=streamid)
            personreids = PersonReidModel.objects.filter(streamid = streamid)
            checkids1 = checks.values('faceid').distinct()
            checkids2 = personreids.values('faceid').distinct()
            checkids = list(checkids1)+list(checkids2)
            name = StreamModel.objects.get(pk=int(streamid)).streamname
            streamtime = float(StreamModel.objects.get(pk=int(streamid)).streamtime)
            ret = []
            i = 0
            faceids = []
            for face in checkids:
                if face['faceid'] in faceids:
                    continue
                faceids.append(face['faceid'])
                i+=1
                print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
                newlist = {}
                newlist1 = {}
                face_id = int(face["faceid"])
                print(face_id)
                if face_id < 1000:
                    newlist['facename'] = FaceModel.objects.get(pk=face_id).username
                    newlist['faceurl']  = FaceImgModel.objects.filter(userid = face_id).values('imgurl')[0]['imgurl']
                else:
                    newlist['facename'] = "陌生人"+face['faceid']
                    # print(CheckModel.objects.filter(faceid=face['faceid']).values('imgurl')[0]['imgurl'])
                    newlist['faceurl']  = settings.FACE_IMG_CHECK_ROOT_URL+CheckModel.objects.filter(faceid=face['faceid']).values('imgurl')[0]['imgurl']
                newlist['facecount'] = len(checks.filter(faceid=face['faceid']))+len(personreids.filter(faceid=face['faceid']))
                newlist1 = getfacemarkers(checks , personreids,face_id)
                newlist['facetime'] =  newlist1['facetime']
                newlist['marks']  = newlist1['marks']
                newlist['url'] = newlist1['url']
                ret.append(newlist)
                print(i)
            # print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
            newlist = {}
            newlist['streamname'] = name
            newlist['streamtime'] = streamtime
            newlist['facematch'] = ret
            serializer1 =getmarkers(checks)
            serializer2 = getmarkers(personreids)
            return JsonResponse(data={'list': serializer1, 'count': len(serializer1) , 'info':newlist,'list_reid':serializer2}, code='999999',
                                msg='success')
        #faceid和streamid都没有
        elif (faceid =='None' or faceid == '') and (streamid == 'None' or streamid == ''):
            print("here")
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
                stream = StreamModel.objects.get(pk=streamid)
                item['streamname'] = stream.streamlocation + '-' + stream.streamname
                print(int(faceid))
                if int(faceid) < 1000:
                    username = FaceModel.objects.get(pk=faceid).username
                    img = FaceImgModel.objects.filter(userid_id=faceid).values('userid_id', 'imgurl')
                    img[0]['username'] = username
                    img = img[0]
                    rets['facename'] = username
                else:
                    username = "陌生人"+'-'+faceid
                    strangers = StrangerModel.objects.filter(faceid = faceid).values('faceid','imgurl')
                    img = {"user_id":strangers[0]['faceid'],"imgurl":settings.FACE_IMG_CHECK_ROOT_URL+strangers[0]['imgurl']}
                    img['username'] = username
                    item['facename'] = username
                imgs.append(img)
                lists.append(rets)
                # if ind == 1:break

            print(list)
            print(imgs)
            return JsonResponse(data={'list': lists, 'count': len(checks), 'imgList':imgs}, code='999999', msg='success')
        # 获取某一个具体人脸的信息，只有faceid，没有streamid
        elif ((faceid != 'None' and faceid != '') and (streamid == 'None' or streamid == '')):
            print("只有faceid")
            print(faceid)
            checks = CheckModel.objects.filter(faceid=faceid).values('faceid','streamid','time','url').distinct()
            personreids =PersonReidModel.objects.filter(faceid = faceid).values("faceid","streamid","time",'url').distinct()
            imgs = []
            if int(faceid)< 1000:#集合陌生人
                imgs = FaceImgModel.objects.filter(userid_id=faceid).values('userid_id', 'imgurl')
            else:
                img = {'imgurl':settings.FACE_IMG_CHECK_ROOT_URL+CheckModel.objects.filter(faceid = faceid).values('imgurl')[0]['imgurl'],'userid_id':faceid}
                imgs.append(img)
            matchs = list(checks)+list(personreids)
            # print(matchs)
            matchs.sort(key=lambda k: (float(k.get('time'))), reverse=False)
            times = []
            locations = []
            front_location = []
            for match in matchs:
                if int(faceid)< 1000:
                    face = FaceModel.objects.get(pk=faceid)
                    match['facename'] = face.username
                else:
                    match['facename'] = "陌生人"+faceid
                stream = StreamModel.objects.get(pk=int(match['streamid']))
                match['streamname'] = stream.streamlocation + '-' + stream.streamname
                time = match['time']
                if time in times:
                    continue
                if not times:
                    front_location = [float(stream.streamlon),float(stream.streamlat)]
                    match_location = front_location
                else:
                    sencond_location = [float(stream.streamlon),float(stream.streamlat)]
                    match_location = getmovelocation(front_location,sencond_location)
                    front_location = sencond_location
                times.append(time)
                locations.append(match_location)
            imgs = list(imgs)
            # print(matchs)
            print(locations)
            return JsonResponse(data={'list': list(matchs), 'count': len(matchs), 'imgList':imgs,'location':list(locations)}, code='999999', msg='success')
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
                ret1 = StreamModel.objects.get(pk=check['streamid'])
                ret2 = []
                centerlon += float(ret1.streamlon)
                centerlat += float(ret1.streamlat)
                ret2.append(ret1.streamlon)
                ret2.append(ret1.streamlat)
                ret.append(ret2)
                i+= 1
            newlist['location'] = ret
            newlist['center'] = [centerlon/i,centerlat/i]
            return JsonResponse(data=newlist, code="999999", msg="成功")

#按流查询后端数据处理过程
def getmarkers(data):
    res = []
    for marker in data:
        newlist = {}
        for marker_data in res:
            if marker.time == marker_data['time']:

                newlist = {'id':marker.faceid,'imgurl':settings.FACE_IMG_CHECK_ROOT_URL+marker.imgurl,'threshold':marker.c_threshold}
                marker_data['imgList'].append(newlist)
                break
        if newlist:
            print('same time')
        else:
            res.append({'time': marker.time, 'imgList':[{'id':marker.faceid,'imgurl':settings.FACE_IMG_CHECK_ROOT_URL+marker.imgurl,'threshold':marker.c_threshold}],
                            'width':"50%"})
    return res

def getfacemarkers(data,reiddata,fid):
    back = []
    facechecks = data.filter(faceid = fid)
    facereids =reiddata.filter(faceid = fid)
    matchs = list(facechecks)+list(facereids)
    mark = {}
    url = {}
    reback = {}
    for marker in matchs:
        newlist={}
        newlist['time'] = marker.time
        newlist['imgurl'] = settings.FACE_IMG_CHECK_ROOT_URL+marker.imgurl
        newlist['threshold'] = marker.c_threshold
        time=marker.time
        time = [str(time),int(time)][int(time)==time]
        mark[time] =""
        url[time] = settings.FACE_IMG_CHECK_ROOT_URL+marker.imgurl
        back.append(newlist)
    #给列表back按照列表内字典的time来做升序
    reback['facetime'] = sorted(back, key=lambda back:back['time'], reverse=False)
    reback['marks'] = mark
    reback['url'] = url
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
            streamids.sort(key=lambda k: (int(k.get('timestap'))), reverse=False)
            # print(streamids)
            locations = []
            for i,value in enumerate(streamids):
                location = StreamModel.objects.filter(id=value['streamid']).values('streamlat','streamlon')[0]
                if i>0:
                    if a == [float(location['streamlon']), float(location['streamlat'])]:
                        continue
                    b =getmovelocation(a,[float(location['streamlon']),float(location['streamlat'])])
                    #[locations[0][0],locations[0][1],location['streamlon'],location['streamlat']]
                    locations.append(b)
                    #locationlist.append(locations)
                    #locations = []
                else:
                    a = [float(location['streamlon']), float(location['streamlat'])]
                    locations.append(a)
                a = [float(location['streamlon']), float(location['streamlat'])]

            if cols:
                col = random.choice(cols)
                newlist['color'] = col
                cols.remove(col)
                print(len(cols))
            else:
                msg_data ="已达到上限"
                break

            #newlist['location'] = locationlist if locationlist else [locations[0],[locations[0][0]+0.000001,locations[0][1],locations[0][0]+0.000002,locations[0][1]]]
            face_msg = FaceModel.objects.get(pk = int(face['faceid']))
            face_img = FaceImgModel.objects.filter(userid=int(face['faceid'])).values("imgurl")[0]
            newlist['faceid'] = face['faceid']
            newlist['facename'] = face_msg.username
            newlist['faceimgurl'] = face_img['imgurl']
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

        return JsonResponse(data={'list':lists}, code="999999", msg=msg_data)
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
