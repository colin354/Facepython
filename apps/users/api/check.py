from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.serializers import CheckSerializer
from apps.users.models import Check as CheckModel
from apps.users.models import FaceImg as FaceImgModel
from django.conf import settings
from apps.users.models import Stream as StreamModel
from apps.users.models import Face as FaceModel
import ipdb
from collections import OrderedDict

class Check(APIView):

    def post(self, request, *args, **kwargs):
        print("check post test")
        print(request.data)
        tempUrl = request.data.get('url')
        streamid = StreamModel.objects.filter(streamurl=settings.FACE_IMG_CHECK_ROOT_URL + tempUrl).values("id")[0]
        print(streamid)
        request.data['streamid'] = streamid['id']
        print(request.data)
        serializer = CheckSerializer(data=request.data)
        if serializer.is_valid():
            # 这里可以解析post上传数据，再存储，目前做个简单的
            serializer.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        print(serializer.errors)
        return JsonResponse(data=serializer.errors, code="999999", msg="失败")
        # serializer = CheckSerializer(data=request.data)
        # if serializer.is_valid():
        #     #这里可以解析post上传数据，再存储，目前做个简单的
        #     serializer.save()
        #     return JsonResponse(data={}, code="999999", msg="成功")
        # print(serializer.errors)
        # return JsonResponse(data=serializer.errors, code="999999", msg="失败")

    def get(self, request, *args, **kwargs):
        # 获取所有人脸的信息
        faceid = request.GET.get('faceid')
        streamid = request.GET.get('streamid')
        faceid = str(faceid)
        streamid = str(streamid)
        # ipdb.set_trace()
        #如果只有streamid,没有faceid
        if (faceid =='None' or faceid == '') and (streamid != 'None' and streamid != ''):
            print("111111111111111111111")
            checks = CheckModel.objects.filter(streamid=streamid)
            checkids = checks.values('faceid').distinct()
            name = StreamModel.objects.get(pk=int(streamid)).streamname
            streamtime = float(StreamModel.objects.get(pk=int(streamid)).streamtime)
            ret = []
            for face in checkids:
                newlist = {}
                newlist1 = {}
                face_id = int(face["faceid"])
                print(face_id)
                newlist['facename'] = FaceModel.objects.get(pk=face_id).username
                newlist['faceurl']  = FaceImgModel.objects.filter(userid = face_id).values('imgurl')[0]['imgurl']
                newlist['facecount'] = len(checks.filter(faceid=face['faceid']))
                newlist1 = getfacemarkers(checks , face_id)
                print('111111111111111111111111111')
                newlist['facetime'] =  newlist1['facetime']
                newlist['marks']  = newlist1['marks']
                newlist['url'] = newlist1['url']
                ret.append(newlist)
            newlist = {}
            newlist['streamname'] = name
            newlist['streamtime'] = streamtime
            newlist['facematch'] = ret
            serializer =getmarkers(checks)
            return JsonResponse(data={'list': serializer, 'count': len(serializer) , 'info':newlist}, code='999999',
                                msg='success')
        #faceid和streamid都没有
        elif (faceid =='None' or faceid == '') and (streamid == 'None' or streamid == ''):
            checks = CheckModel.objects.values('faceid', 'streamid', 'url').distinct()
            checks = list(checks)
            imgs = []
            faceids = set()
            for ind, item in enumerate(checks):
                rets = []
                faceid = item['faceid']
                if faceid in faceids:
                    continue
                faceids.add(faceid)
                img = FaceImgModel.objects.filter(userid_id=faceid).values('userid_id', 'imgurl')
                # locs = CheckModel.objects.filter(faceid=faceid).values('streamid').distinct()
                # for loc in locs:
                #     ret2 = []
                #     ret1 =StreamModel.objects.get(pk=loc['streamid'])
                #     ret2.append(ret1.streamlon)
                #     ret2.append(ret1.streamlat)
                #     rets.append(ret2)
                if len(img) > 0:
                    username = FaceModel.objects.get(pk=faceid).username
                    img[0]['username'] = username
                    #img[0]['locations'] = rets
                    imgs.append(img[0])
            return JsonResponse(data={'list': checks, 'count': len(checks), 'imgList':imgs}, code='999999', msg='success')
        # 获取某一个具体人脸的信息，只有faceid，没有streamid
        elif ((faceid != 'None' and faceid != '') and (streamid == 'None' or streamid == '')):
            checks = CheckModel.objects.filter(faceid=faceid).values('faceid','streamid','url').distinct()
            imgs = FaceImgModel.objects.filter(userid_id=faceid).values('userid_id', 'imgurl')
            imgs = list(imgs)
            if len(checks) == 0:
                return JsonResponse(data={}, code='-1', msg='无效的faceid')
            return JsonResponse(data={'list': list(checks), 'count': len(checks), 'imgList':imgs}, code='999999', msg='success')
        #faceid和streamid都有
        elif ((faceid != 'None' and faceid != '') and (streamid != 'None' and streamid != '')):
            checks = CheckModel.objects.filter(faceid=faceid, streamid=streamid).values('faceid', 'time', 'imgurl','c_threshold')
            checks_list = list(checks)
            for ind, item in enumerate(checks_list):
                # imgs = FaceImgModel.objects.filter(userid_id=item['faceid']).values('userid_id', 'imgurl')
                # imgs = list(imgs)
                # print("~~~~~~~~~~~~~~~~~~~~~~")
                # print(imgs)
                # print("~~~~~~~~~~~~~~~~~~~~~~")
                # imgs.clear()
                # print("~~~~~~~~~~~~~~~~~~~~~~")
                # print(imgs)
                # print("~~~~~~~~~~~~~~~~~~~~~~")
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
    print('getmarkers!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
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

def getfacemarkers(data,fid):
    print("getfacemarkers")
    print(data)
    print(fid)
    back = []
    facechecks = data.filter(faceid = fid)
    mark = {}
    url = {}
    reback = {}
    i = 0
    print(len(facechecks))
    for marker in facechecks:
        i += 1
        print(i)
        print(marker.id)
        newlist={}
        newlist['time'] = marker.time
        print("22222222")
        print("333333333333")
        newlist['imgurl'] = settings.FACE_IMG_CHECK_ROOT_URL+marker.imgurl
        print("44444444444")
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


check_face = Check.as_view()
check_location = CheckLocations.as_view()
