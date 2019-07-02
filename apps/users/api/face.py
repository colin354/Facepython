from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from django.core.exceptions import ObjectDoesNotExist
from apps.users.models import Face
from django.conf import settings
from django.contrib.auth.models import User
from apps.users.serializers import FaceSerializer
from rest_framework.parsers import JSONParser
from apps.users.utility import TokenVerify
from apps.users.models import FaceImg as FaceImgModel
import os, shutil
import pdb

class FaceImg(APIView):

    TOKEN = 'token'

    @TokenVerify
    def post(self, request, *args, **kwargs):
        UUID = request.GET.get("uuid")
        if UUID == None:
            return JsonResponse(data={}, code="-1", msg="失败 缺少uuid")
        if request.FILES.get('file') != None:
            file_dir = settings.MEDIA_ROOT+'temp/'+UUID
            src = request.FILES['file']
            if os.path.exists(file_dir) == False:
                os.makedirs(file_dir)
            with open(settings.MEDIA_ROOT+'temp/'+UUID+'/'+src.name ,'wb+') as f:
                for chunk in src.chunks():
                    f.write(chunk)
                pass
        else:
            return JsonResponse(data={}, code='-1', msg="失败 不是图片")
        imgurl = settings.FACE_IMG_ROOT_URL + 'temp/'+UUID+'/'+src.name
        data = {'imgurl':imgurl}
        return JsonResponse(data=data, code="999999", msg="成功")

    @TokenVerify
    def delete(self, request, *args, **kwargs):
        UUID = request.GET.get("uuid")
        userid = request.GET.get("id")
        # 新增用户时删除上传头像
        if userid == None or userid == '':
            if UUID == None:
                return JsonResponse(data={}, code="-1", msg="失败 缺少uuid")
            # img/  删除所有uuid下的文件
            if len(request.path_info.strip('/').split('/')) == 1:
                file_dir = settings.MEDIA_ROOT+'temp/'+UUID
                def handleRmtree(func, path, exc_info):
                    print(path, exc_info)
                shutil.rmtree(file_dir, ignore_errors=False, onerror=handleRmtree)
                return JsonResponse(data={}, code='999999', msg="成功")
            # img/uuid/img.type 删除某一个文件
            else:
                img = request.path_info.strip('/').split('/')[-1]
                file_addr = settings.MEDIA_ROOT+'temp/'+ UUID + '/'+img
                os.remove(file_addr)
                return JsonResponse(data={}, code='999999', msg="成功")
        # 修改用户时删除头像
        if userid != None:
            img = request.path_info.strip('/').split('/')[-1]
            file_addr_in_temp = settings.MEDIA_ROOT+'temp/'+ UUID + '/'+img
            file_addr_not_in_temp = settings.MEDIA_ROOT+''+ userid + '/'+img
            if os.path.isfile(file_addr_in_temp):
                os.remove(file_addr_in_temp)
            if os.path.isfile(file_addr_not_in_temp):
                imgurl = settings.FACE_IMG_ROOT_URL + str(userid)+'/'+img
                FaceImgModel.objects.filter(imgurl__exact=imgurl).delete()
                os.remove(file_addr_not_in_temp)
            return JsonResponse(data={}, code='999999', msg="成功")

class FaceView(APIView):
    TOKEN = 'token'

    @TokenVerify
    def post(self, request, *args, **kwargs):

        serializer = FaceSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            UUID = request.GET.get("uuid")
            if UUID == None:
                return JsonResponse(data={}, code="-1", msg="失败 缺少uuid")
            # 重新命名文件夹
            src_file_dir = settings.MEDIA_ROOT+'temp/'+UUID
            des_file_dir = settings.MEDIA_ROOT+'/image/'+str(serializer.data['id'])
            os.renames(src_file_dir, des_file_dir)
            # 获取外键，图片url前缀
            uid = serializer.data['id']
            face = Face.objects.get(pk=uid)
            imgurlRoot = settings.FACE_IMG_ROOT_URL + str(uid)
            # 保存图片
            for name in os.listdir(des_file_dir):
                faceImgModel = FaceImgModel(userid=face, imgurl=imgurlRoot+'/'+name)
                faceImgModel.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="-1", msg="失败")

    @TokenVerify
    def get(self, request, *args, **kwargs):
        # 获取所有人脸的信息
        if request.path_info.strip('/').split('/')[-1].isdigit() == False:
            faces = Face.objects.all()
            #print(faces)
            serializer = FaceSerializer(faces, many=True)
            for i in range(len(serializer.data)):
                imgurlRoot = settings.FACE_IMG_ROOT_URL + str(serializer.data[i]['id'])
                serializer.data[i]['imgdir'] = imgurlRoot
                serializer.data[i]['imgurls'] = self.dealImgUrls(list(FaceImgModel.objects.filter(userid__exact=serializer.data[i]['id']).values_list('imgurl')))
            return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999', msg='success')
        # 获取某一个具体人脸的信息
        else:
            # 注意rest返回的serializer.data 是固定的，不会修改， 所以copy一下
            face_id = int(request.path_info.split('/')[-1])
            face = Face.objects.get(id=face_id)
            serializer = FaceSerializer(face)
            data = serializer.data
            imgurlRoot = settings.FACE_IMG_ROOT_URL + str(serializer.data['id'])
            data['imgdir'] = imgurlRoot
            data['imgurls'] = self.dealImgUrls(list(FaceImgModel.objects.filter(userid__exact=serializer.data['id']).values_list('imgurl')))
            return JsonResponse(data=data, code='999999', msg='success')

    def dealImgUrls(self, imgUrls):
        res = []
        for v in imgUrls:
            res.append({'name':v[0].split('/')[-1], 'url':v[0]})
        return res


    @TokenVerify
    def put(self, request, *args, **kwargs):
        UUID = request.GET.get("uuid")
        if UUID == None:
            return JsonResponse(data={}, code="-1", msg="失败 缺少uuid")
        # 人脸信息更新
        face = Face.objects.get(id=request.data['id'])
        request.data['flag'] = Face.UPDATE
        serializer = FaceSerializer(face, data=request.data)
        if serializer.is_valid():
            serializer.save()
        else:
            return JsonResponse(data=serializer.errors, code="-1", msg="失败")
        # 移动UUID临时目录下的新上传的文件到具体保存地址
        src_file_dir = settings.MEDIA_ROOT+'temp/'+UUID
        des_file_dir = settings.MEDIA_ROOT+'/image/'+str(serializer.data['id'])
        # 先判断是否存在目的目录
        if os.path.isdir(des_file_dir) == False:
            os.makedirs(des_file_dir)
        # 先判断是否存在目录（是否上传了新文件）
        if os.path.isdir(src_file_dir) == True:
            for imgFile in os.listdir(src_file_dir):
                shutil.move(src_file_dir+'/'+imgFile, des_file_dir)
            shutil.rmtree(src_file_dir)

        # 保存额外上传的人脸图片
        # 获取外键，图片url前缀
        uid = serializer.data['id']
        des_file_dir = settings.MEDIA_ROOT+'/image/'+str(serializer.data['id'])
        face = Face.objects.get(pk=uid)
        imgurlRoot = settings.FACE_IMG_ROOT_URL + str(uid)
        # 保存图片 先判断是否存在目录（是否上传了新文件）
        for name in os.listdir(des_file_dir):
            # 已经有此图片
            if len(FaceImgModel.objects.filter(imgurl__exact=imgurlRoot+'/'+name)) > 0:
                continue
            # 没有在数据库保存，现在保存一下
            faceImgModel = FaceImgModel(userid=face, imgurl=imgurlRoot+'/'+name)
            faceImgModel.save()
        return JsonResponse(data={}, code="999999", msg="成功")

    @TokenVerify
    def delete(self, request, *args, **kwargs):
        face = Face.objects.get(id=request.data[0])
        face.flag = Face.DELETE
        face.save()
        return JsonResponse(data={}, code='999999', msg='成功')


face_img = FaceImg.as_view()
faces = FaceView.as_view()

