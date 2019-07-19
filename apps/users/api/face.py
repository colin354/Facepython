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
from apps.users.models import Face as FaceModel
import os, shutil
import pdb

class FaceImg(APIView):

    TOKEN = 'token'

    @TokenVerify
    def post(self, request, *args, **kwargs):
        print("1111111111111111111111111111111111")
        UUID = request.GET.get("uuid")
        print(UUID)
        if UUID == None:
            return JsonResponse(data={}, code="-1", msg="失败 缺少uuid")
        if request.FILES.get('file') != None:
            file_dir = settings.MEDIA_ROOT+'temp/'+UUID
            src = request.FILES['file']
            print(src)
            print(src.name)
            if os.path.exists(file_dir) == False:
                os.makedirs(file_dir)
            with open(settings.MEDIA_ROOT+'temp/'+UUID+'/'+src.name ,'wb+') as f:
                for chunk in src.chunks():
                    f.write(chunk)
                pass
        else:
            return JsonResponse(data={}, code='-1', msg="失败 不是图片")
        imgurl = settings.FACE_IMG_ROOT_URL + 'temp/'+UUID+'/'+src.name
        print(imgurl)
        data = {'imgurl':imgurl}
        return JsonResponse(data=data, code="999999", msg="成功")

    @TokenVerify
    def delete(self, request, *args, **kwargs):
        UUID = request.GET.get("uuid")
        userid = request.GET.get("id")
        print(UUID)
        print(userid)
        # 新增用户时删除上传头像
        if userid == None or userid == '':
            print("now 新增删除")
            if UUID == None:
                return JsonResponse(data={}, code="-1", msg="失败 缺少uuid")
            #判断删除文件夹
            file_check_delete = settings.MEDIA_ROOT + '/'+UUID
            if os.path.isdir(file_check_delete) == True:
                shutil.rmtree(file_check_delete)
            # img/  删除所有uuid下的文件
            if len(request.path_info.strip('/').split('/')) == 1:
                # file_dir = settings.MEDIA_ROOT+'temp/'+UUID
                file_dir = settings.MEDIA_ROOT + 'temp/'
                def handleRmtree(func, path, exc_info):
                    print(path, exc_info)
                shutil.rmtree(file_dir, ignore_errors=False, onerror=handleRmtree)
                return JsonResponse(data={}, code='999999', msg="成功")
            # img/uuid/img.type 删除某一个文件
            else:
                img = request.path_info.strip('/').split('/')[-1]
                file_addr = settings.MEDIA_ROOT+'temp/'+ UUID + '/'+img
                if '/' not in img:
                    os.remove(file_addr)
                return JsonResponse(data={}, code='999999', msg="成功")
        # 修改用户时删除头像
        if userid != None:
            print("now 修改删除")
            img = request.path_info.strip('/').split('/')[-1]
            #file_addr_in_temp = settings.MEDIA_ROOT+'temp/'+ UUID + '/'+img
            # file_addr_not_in_temp = settings.MEDIA_ROOT+'/'+ userid + '/'+img
            file_addr_not_in_temp = settings.MEDIA_ROOT + '/image/' + userid + '/' + img
            print(userid)
            # print(file_addr_in_temp)
            print(file_addr_not_in_temp)
            # if os.path.isfile(file_addr_in_temp):
            #     print("11111111111111111")
            #     os.remove(file_addr_in_temp)
            if os.path.isfile(file_addr_not_in_temp):
                print("2222222222")
                # imgurl = settings.FACE_IMG_ROOT_URL + str(userid)+'/'+img
                # imgurl = settings.FACE_IMG_ROOT_URL + 'image/' + str(userid) + '/' + img
                # print(imgurl)
                # FaceImgModel.objects.filter(imgurl__exact=imgurl).delete()
                # os.remove(file_addr_not_in_temp)
                # 此处添加修改时删除图片后点取消，可以返回到之前的状态
                file_delete = settings.MEDIA_ROOT + '/'+UUID
                if os.path.exists(file_delete) == False:
                    os.makedirs(file_delete)
                shutil.copy(file_addr_not_in_temp, file_delete)
            return JsonResponse(data={}, code='999999', msg="成功")

class FaceView(APIView):
    TOKEN = 'token'

    @TokenVerify
    def post(self, request, *args, **kwargs):
        print("now post api face")
        serializer = FaceSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            UUID = request.GET.get("uuid")
            if UUID == None:
                return JsonResponse(data={}, code="-1", msg="失败 缺少uuid")
            # 重新命名文件夹
            src_file_dir = settings.MEDIA_ROOT+'temp/'+UUID
            des_file_dir = settings.MEDIA_ROOT+'/image/'+str(serializer.data['id'])
            #des_file_dir = settings.MEDIA_ROOT+'/'+ str(serializer.data['id'])
            os.renames(src_file_dir, des_file_dir)
            # 获取外键，图片url前缀
            uid = serializer.data['id']
            face = Face.objects.get(pk=uid)
            imgurlRoot = settings.FACE_IMG_ROOT_URL + 'image/' + str(uid)
            # 保存图片
            for name in os.listdir(des_file_dir):
                faceImgModel = FaceImgModel(userid=face, imgurl=imgurlRoot+'/'+name)
                faceImgModel.save()
            return JsonResponse(data={}, code="999999", msg="成功")
        return JsonResponse(data=serializer.errors, code="-1", msg="失败")

    @TokenVerify
    def get(self, request, *args, **kwargs):
        limit = request.GET.get('limit')
        page = request.GET.get('page')
        username = request.GET.get('username')
        #如果在url里带上了faceid
        if request.path_info.strip('/').split('/')[-1].isdigit() == True:
            # 获取某一个具体人脸的信息
            face_id = int(request.path_info.split('/')[-1])
            face = Face.objects.get(id=face_id)
            serializer = FaceSerializer(face)
            data = serializer.data
            imgurlRoot = settings.FACE_IMG_ROOT_URL + str(serializer.data['id'])
            data['imgdir'] = imgurlRoot
            data['imgurls'] = self.dealImgUrls(
                list(FaceImgModel.objects.filter(userid__exact=serializer.data['id']).values_list('imgurl')))
            return JsonResponse(data=data, code='999999', msg='success')
        #如果在pararms里只带上limit和page
        elif (limit != None and page !=None) and (username == None or username == ''):
            #分页显示信息
            a = int(limit)
            b = int(page)
            start = a * (b - 1)
            end = a * b
            facesall = Face.objects.all()
            faces = facesall[start:end]
            # print(faces)
            serializer = FaceSerializer(faces, many=True)
            imgs = []
            faceids = set()
            for i in range(len(serializer.data)):
                imgurlRoot = settings.FACE_IMG_ROOT_URL + str(serializer.data[i]['id'])
                faceid = str(serializer.data[i]['id'])
                serializer.data[i]['imgdir'] = imgurlRoot
                serializer.data[i]['imgurls'] = self.dealImgUrls(
                    list(FaceImgModel.objects.filter(userid__exact=serializer.data[i]['id']).values_list('imgurl')))
                if faceid in faceids:
                    continue
                faceids.add(faceid)
                img = FaceImgModel.objects.filter(userid_id=faceid).values('userid_id', 'imgurl')
                if len(img) > 0:
                    username = FaceModel.objects.get(pk=faceid).username
                    img[0]['username'] = username
                    imgs.append(img[0])
                # serializer.data[i]['imgurls'] = FaceImgModel.objects.filter(userid__exact=serializer.data[i]['id']).values('imgurl')
            return JsonResponse(data={'list': serializer.data, 'imgList':imgs, 'count': len(facesall)}, code='999999',
                                msg='success')
        #如果在pararms里带上了limit、page和username
        elif (limit != None and page !=None) and (username != None and username != ''):
            faces = Face.objects.filter(username = username)
            serializer = FaceSerializer(faces, many=True)
            for i in range(len(serializer.data)):
                imgurlRoot = settings.FACE_IMG_ROOT_URL + str(serializer.data[i]['id'])
                serializer.data[i]['imgdir'] = imgurlRoot
                serializer.data[i]['imgurls'] = self.dealImgUrls(
                    list(FaceImgModel.objects.filter(userid__exact=serializer.data[i]['id']).values_list('imgurl')))
            return JsonResponse(data={'list': serializer.data, 'count': len(serializer.data)}, code='999999',
                                msg='success')
        else:
            return JsonResponse(data={}, code='999999',msg='success')

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
        #判断是否有需要删除的图片
        src_file_dir = settings.MEDIA_ROOT+'/'+UUID
        des_file_dir = settings.MEDIA_ROOT+'/image/'+str(serializer.data['id'])
        if os.path.isdir(src_file_dir) == True:
            #循环获取文件夹下的图片
            for imgFile in os.listdir(src_file_dir):
                if imgFile in os.listdir(des_file_dir):
                    imgurl = settings.FACE_IMG_ROOT_URL + 'image/' + str(serializer.data['id']) + '/' + imgFile
                    FaceImgModel.objects.filter(imgurl__exact=imgurl).delete()
                    if '/' not in imgFile:
                        os.remove(des_file_dir+'/'+imgFile)
            shutil.rmtree(src_file_dir)
        # 移动UUID临时目录下的新上传的文件到具体保存地址
        src_file_dir = settings.MEDIA_ROOT+'temp/'+UUID
        print("put    put")
        print(src_file_dir)
        des_file_dir = settings.MEDIA_ROOT+'/image/'+str(serializer.data['id'])
        print(des_file_dir)
        # 先判断是否存在目的目录
        if os.path.isdir(des_file_dir) == False:
            os.makedirs(des_file_dir)
        # 先判断是否存在目录（是否上传了新文件）
        msg = "成功"
        if os.path.isdir(src_file_dir) == True:
            for imgFile in os.listdir(src_file_dir):
                #判断上传的新照片是否有同名的照片
                if imgFile not in os.listdir(des_file_dir):
                    shutil.move(src_file_dir+'/'+imgFile, des_file_dir)
                else:
                    msg = "图片已存在"
            shutil.rmtree(src_file_dir)

        # 保存额外上传的人脸图片
        # 获取外键，图片url前缀
        uid = serializer.data['id']
        des_file_dir = settings.MEDIA_ROOT+'/image/'+str(serializer.data['id'])
        face = Face.objects.get(pk=uid)
        imgurlRoot = settings.FACE_IMG_ROOT_URL + 'image/' + str(uid)
        # 保存图片 先判断是否存在目录（是否上传了新文件）
        for name in os.listdir(des_file_dir):
            # 已经有此图片
            if len(FaceImgModel.objects.filter(imgurl__exact=imgurlRoot+'/'+name)) > 0:
                continue
            # 没有在数据库保存，现在保存一下
            faceImgModel = FaceImgModel(userid=face, imgurl=imgurlRoot+'/'+name)
            faceImgModel.save()
        return JsonResponse(data={}, code="999999", msg=msg)

    @TokenVerify
    def delete(self, request, *args, **kwargs):
        ids = request.data
        for id in ids:
            face_img = FaceImgModel.objects.filter(userid_id=id).delete()
            face = Face.objects.get(id=id).delete()
        #face.flag = Face.DELETE
        #face.save()
        return JsonResponse(data={}, code='999999', msg='成功')


face_img = FaceImg.as_view()
faces = FaceView.as_view()