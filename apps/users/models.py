from django.contrib.auth.models import User
from django.db import models

from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token

from django.contrib import admin

@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)

# Create your models here.
class UserProfile(models.Model):
    """
    用户
    """
    user = models.OneToOneField(User, on_delete=models.CASCADE, verbose_name='用户', related_name='user')
    phone = models.CharField(max_length=11, default='', blank=True, verbose_name='手机号')

    def __str__(self):
        return self.phone


class VerifyCode(models.Model):
    """
    短信验证码
    """
    code = models.CharField(max_length=10, verbose_name="验证码" )
    mobile = models.CharField(max_length=11, verbose_name="电话")

    class Meta:
        verbose_name = "短信验证码"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.code

class Face(models.Model):
    """
    人脸
    """
    NEW, UPDATE, DELETE = 0,1,2
    FLAG_CHOICE = (
            (0, 'new'),
            (1, 'update'),
            (2, 'delete'),
            )
    proprietor,temporary,slack,lost = 0,1,2,3
    FACE_FLAG = (
        (0,'proprietor'),
        (1,'temporary'),
        (2,'slack'),
        (3,'lost'),
    )

    username = models.CharField(max_length=255, verbose_name="用户名")
    mobile = models.CharField(max_length=11, verbose_name="手机号")
    gender = models.BooleanField()
    email = models.EmailField()
    flag = models.IntegerField(choices=FLAG_CHOICE, default=0)
    face_flag = models.IntegerField(choices=FACE_FLAG, default=0)
    createDate = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "人脸数据"
        verbose_name_plural = verbose_name

class FaceImg(models.Model):

    userid = models.ForeignKey('Face', on_delete=models.CASCADE)
    imgurl = models.URLField(verbose_name="照片地址", null=True)

    class Meta:
        verbose_name = "人脸图片地址"
        verbose_name_plural = verbose_name

class Stranger(models.Model):
    faceid  = models.CharField(max_length=10, verbose_name='人脸ID')
    c_gender = models.CharField(max_length=10, null=True, blank=True, verbose_name="检测性别")
    c_age = models.CharField(max_length=10, null=True, blank=True, verbose_name="检测年龄")
    imgurl = models.CharField(max_length=100, null=True, verbose_name="图片url")
    class Meta:
        verbose_name = "陌生人数据"
        verbose_name_plural = verbose_name


    class Meta:
        verbose_name="陌生人脸图片地址"
        verbose_name_plural = verbose_name

class Check(models.Model):

    # faceid = models.ForeignKey('Face', on_delete=models.CASCADE)
    # streamid = models.ForeignKey('Stream', on_delete=models.CASCADE)
    faceid = models.CharField(max_length=10, verbose_name='人脸ID')
    streamid = models.CharField(max_length=256, verbose_name='流ID')
    timestap = models.CharField(max_length=100, verbose_name="时间戳")
    time = models.FloatField(verbose_name="时间", null=True)
    c_x = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框x")
    c_y = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框y")
    c_w = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框w")
    c_h = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框h")
    c_ip = models.CharField(max_length=15, null=True, blank=True, verbose_name="ip")
    c_gender = models.CharField(max_length=10, null=True, blank=True, verbose_name="检测性别")
    c_age = models.CharField(max_length=10, null=True, blank=True, verbose_name="检测年龄")
    c_threshold = models.CharField(max_length=10, null=True, blank=True, verbose_name="检测阈值")
    url = models.CharField(max_length=100, null=True, verbose_name="流url")
    imgurl = models.CharField(max_length=100, null=True, verbose_name="图片url")

    class Meta:
        verbose_name = "匹配信息"
        verbose_name_plural = verbose_name

class Stream(models.Model):
    """
    流信息
    """
    NEW, UPDATE, DELETE = 0, 1, 2
    FLAG_CHOICE = (
        (0, 'new'),
        (1, 'update'),
        (2, 'delete'),
    )
    UNHANDLE, INHANDLE, HANDLEOK, HANDLEFALSE = 0, 1, 2, 3
    STATUS_CHOICE = (
        (0, 'unhandle'),
        (1, 'inhandle'),
        (2, 'handleok'),
        (3, 'handlefalse'),
    )
    streamname     = models.CharField(max_length=50, verbose_name="流名称", unique = True)
    streamlocation = models.CharField(max_length=100, verbose_name="流位置")
    streamurl      = models.CharField(max_length=256, verbose_name="流url")
    streamlat      = models.CharField(max_length = 24 , verbose_name= "纬度",blank=True)
    streamlon      = models.CharField(max_length = 24 , verbose_name= "经度",blank=True)
    flag = models.IntegerField(choices=FLAG_CHOICE, default=0)
    createDate     = models.DateTimeField(auto_now_add=True)
    streamtime = models.CharField(max_length=256, null=True, blank=True, verbose_name="流time")
    streamfps = models.CharField(max_length=256, null=True, blank=True, verbose_name="流fps")
    streamstatus = models.CharField(max_length=256, null=True, blank=True, verbose_name="流status")

    class Meta:
        verbose_name        = "流信息"
        verbose_name_plural = verbose_name




class Camera(models.Model):
    """
        本地摄像头库
    """
    cameraName     = models.CharField(max_length=50, verbose_name="摄像头名称")
    cameraLocation = models.CharField(max_length=50, verbose_name="摄像头位置")
    cameraLat      = models.CharField(max_length=24, verbose_name="纬度")
    cameraLon      = models.CharField(max_length=24, verbose_name="经度")
    c_ip           = models.CharField(max_length=24, null = True ,verbose_name="摄像头ip地址")
    c_username     = models.CharField(max_length=24, null = True ,verbose_name="摄像头用户名")
    c_password     = models.CharField(max_length=24, null = True ,verbose_name="摄像头密码")
    c_token        = models.CharField(max_length=24, null = True ,verbose_name="摄像头token")

    class Meta:
        verbose_name = "摄像头信息"
        verbose_name_plural = verbose_name

class CameraStream(models.Model):
    streamUrl = models.URLField(verbose_name="视频地址", null=True)
    streamTime = models.CharField(max_length=256, null=True, blank=True, verbose_name="流time")
    streamFps = models.CharField(max_length=256, null=True, blank=True, verbose_name="流fps")
    streamStatus = models.CharField(max_length=256, null=True, blank=True, verbose_name="流status")
    startTime = models.DateTimeField()
    cameraId = models.ForeignKey('Camera', on_delete=models.CASCADE)


    class Meta:
        verbose_name = "录像信息"
        verbose_name_plural = verbose_name


# class FaceRecord(models.Model):
#
#     # faceid = models.ForeignKey('Face', on_delete=models.CASCADE)
#     # streamid = models.ForeignKey('Stream', on_delete=models.CASCADE)
#     faceid = models.CharField(max_length=10, verbose_name='人脸ID')
#     streamid = models.CharField(max_length=256, verbose_name='视频流ID')
#     timestap = models.CharField(max_length=100, verbose_name="时间戳")
#     c_x = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框x")
#     c_y = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框y")
#     c_w = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框w")
#     c_h = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框h")
#     c_ip = models.CharField(max_length=15, null=True, blank=True, verbose_name="ip")
#     c_threshold = models.CharField(max_length=10, null=True, blank=True, verbose_name="检测阈值")
#     url = models.CharField(max_length=100, null=True, verbose_name="流url")
#     imgurl = models.CharField(max_length=100, null=True, verbose_name="图片url")
#     c_gender = models.CharField(max_length=10, null=True, blank=True, verbose_name="检测性别")
#     c_age = models.CharField(max_length=10, null=True, blank=True, verbose_name="检测年龄")
#     createDate = models.DateTimeField(auto_now_add=True)
#
#     class Meta:
#         verbose_name = "人脸识别记录信息"
#         verbose_name_plural = verbose_name


class PersonReid(models.Model):

    # faceid = models.ForeignKey('Face', on_delete=models.CASCADE)
    # streamid = models.ForeignKey('Stream', on_delete=models.CASCADE)
    faceid = models.CharField(max_length=10, verbose_name='人员ID')
    streamid = models.CharField(max_length=256, verbose_name='流ID')
    # dec_imgurl = models.CharField(max_length=100, verbose_name="检测图片地址")
    # vedio_url = models.CharField(max_length=100, verbose_name="检测视频地址")
    query_imgurl = models.CharField(max_length=100, verbose_name="检测图片地址")
    timestap = models.CharField(max_length=20, verbose_name="时间戳")
    c_threshold = models.CharField(max_length=10, verbose_name="置信度")
    imgurl = models.CharField(max_length=100, verbose_name="top图片地址")
    url = models.CharField(max_length=100, null=True, verbose_name="流url")
    time = models.FloatField(verbose_name="时间", null=True)
    c_x = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框x")
    c_y = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框y")
    c_w = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框w")
    c_h = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框h")

    class Meta:
        verbose_name = "行人重识别"
        verbose_name_plural = verbose_name

# class PersonTop(models.Model):
#     faceid  = models.ForeignKey('PersonReid', on_delete=models.CASCADE)
#     timestap = models.CharField(max_length=20, verbose_name="时间戳")
#     confidence = models.CharField(max_length=10, verbose_name="置信度")
#     imgurl = models.CharField(max_length=100, verbose_name="top图片地址")
#     c_x = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框x")
#     c_y = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框y")
#     c_w = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框w")
#     c_h = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框h")
#
#     class Meta:
#         verbose_name = "行人重识别TOP5图片"
#         verbose_name_plural = verbose_name

class PersonDetect(models.Model):
    person_id = models.CharField(max_length=24, null=True, blank=True, verbose_name="流time")
    c_x = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框x")
    c_y = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框y")
    c_w = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框w")
    c_h = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框h")
    c_threshold = models.CharField(max_length=10, null=True, blank=True, verbose_name="置信度")
    url = models.CharField(max_length=100, verbose_name="流url")
    timestap = models.CharField(max_length=100, verbose_name="时间戳")
    dec_img_url = models.CharField(max_length=100, verbose_name="检测图片地址")


    class Meta:
        verbose_name = "行人检测信息"
        verbose_name_plural = verbose_name

class MatchUp(models.Model):
    person_id = models.CharField(max_length=24, null=True, blank=True, verbose_name="行人ID")
    faceid = models.CharField(max_length=10,primary_key=True ,verbose_name='人脸ID')
    c_threshold = models.CharField(max_length=10, verbose_name="置信度")
    dec_img_url = models.CharField(max_length=100, verbose_name="检测图片地址")

    class Meta:
        verbose_name="对应关系表"
        verbose_name_plural=verbose_name
