from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from rest_framework import serializers
from apps.users.utility import TokenVerify
from apps.users.models import MatchUp as MatchUpModel
from apps.users.models import PersonDetect as PersonDetectModel
from apps.users.models import Check as CheckModel
from apps.users.serializers import PersonDetcetSerializer,CheckSerializer,MatchUpSerializer
import numpy as np

class matchUp(APIView):

    # @TokenVerify
    def post(self,request,*args,**kwargs):
        print("match up  post!!!!!!!!!!!")
        checks = CheckModel.objects.all().values("url","timestap","c_x","c_y","c_w","c_h","c_threshold","faceid")
        #persondetect = PersonDetectModel.objects.all().values("url","timestap","c_x","c_y","c_w","c_h","c_threshold")
        for check in checks:
            # print("1111111111111111111111111111111")
            # print(check['url'])
            persondetects = PersonDetectModel.objects.filter(url=check['url'])
            # print(persondetects)
            if len(persondetects) == 0:
                continue
            # print(check['timestap'])
            persondetects = persondetects.filter(timestap = check['timestap']).values("url", "timestap", "c_x", "c_y", "c_w", "c_h", "c_threshold","person_id",'dec_img_url')
            # print(persondetects)
            if len(persondetects) == 0:
                continue
            # pesondetects = persondetects.values("url", "timestap", "c_x", "c_y", "c_w", "c_h", "c_threshold","person_id")
            for persondetect in persondetects:
                arr = []
                arr1 = [int(check['c_x']),int(check['c_y']),int(check['c_x'])+int(check['c_w']),int(check['c_y'])+int(check['c_h']),float(check['c_threshold'])]
                # print(arr1)
                arr.append(arr1)
                # print("1111111111111111111111111111111")
                # print(persondetect['c_x'])
                arr2 = [int(persondetect['c_x']),int(persondetect['c_y']),int(persondetect['c_x'])+int(persondetect['c_w']),int(persondetect['c_y'])+int(persondetect['c_h']),float(persondetect['c_threshold'])]
                arr.append(arr2)
                # print(arr2)
                arr = np.array(arr)
                rcv = py_cpu_nms(arr)
                # print(rcv)
                if len(rcv)>1:
                    try:
                        matchup = MatchUpModel.objects.get(faceid=check['faceid'])
                        if float(matchup.c_threshold)< float(check['c_threshold']):
                            matchup.person_id= persondetect['person_id']
                            matchup.c_threshold = check['c_threshold']
                            matchup.dec_img_url = persondetect['dec_img_url']
                            matchup.save()
                    except:
                        matchup = MatchUpModel(person_id=persondetect['person_id'], faceid=check["faceid"],
                                               c_threshold=check['c_threshold'],dec_img_url=persondetect['dec_img_url'])
                        matchup.save()
                    # if len(matchups) == 0:
                    #     matchup= MatchUpModel(person_id= persondetect['person_id'],faceid=check["faceid"],c_threshold = check['c_threshold'])
                    #     matchup.save()
                    # else:
                    #     print("22222222222222222222222222")
                    #     matchup = matchups[0]
                    #     print(matchup['faceid'])
                    #     if float(matchup['c_threshold'])< float(check['c_threshold']):
                    #         # list = {}
                    #         # list['faceid'] = check['faceid']
                    #         # list['c_threshold'] = check['c_threshold']
                    #         # list['person_id'] = persondetect['person_id']
                    #         # serializer = MatchUpSerializer(matchup,data=list)
                    #         # if serializer.is_valid():
                    #         #     serializer.save()
                    #         print('333333333333333333333333333333')
                    #         matchup['c_threshold'] = check['c_threshold']
                    #         matchup['person_id'] = persondetect['person_id']
                    #         matchup.save()
        return JsonResponse(data={}, code='999999', msg='成功')

def py_cpu_nms(dets):
    """Pure Python NMS baseline."""

    thresh = 0.0001
    x1 = dets[:, 0]  # xmin
    y1 = dets[:, 1]  # ymin
    x2 = dets[:, 2]  # xmax
    y2 = dets[:, 3]  # ymax
    scores = dets[:, 4]

    areas = (x2 - x1 + 1) * (y2 - y1 + 1)
    number = dets.shape[0]
    keep = []
    order = np.array([i for i in range(number)])
    order = np.argsort(-scores)
    while len(order) > 0:
        i = order[0]
        keep.append(i)
        xx1 = np.maximum(x1[i], x1[order[1:]])
        yy1 = np.maximum(y1[i], y1[order[1:]])
        xx2 = np.minimum(x2[i], x2[order[1:]])
        yy2 = np.minimum(y2[i], y2[order[1:]])
        w = np.maximum(0.0, xx2 - xx1 + 1)
        h = np.maximum(0.0, yy2 - yy1 + 1)
        inter = w * h
        ovr = inter / areas[i]
        # print("11111111111111111111111")
        # print(ovr)
        # print("111111111111111111111111")
        inds = np.where(ovr >= thresh)[0]

        inds = inds + 1
        order = order[inds]

    return keep

match_up=matchUp.as_view()
