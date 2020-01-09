# from django.contrib.auth.models import User
from django.db import models
from django.contrib.auth.models import AbstractUser

from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token

from django.contrib import admin

from django.db import models


class Interface(models.Model):

    name = models.CharField(max_length=32)
    path = models.CharField(max_length=128)
    method = models.CharField(max_length=32, null=True)
    description = models.CharField(max_length=32, null=True)

class FunctionInterface(models.Model):

    interface = models.ForeignKey(Interface, related_name = 'Interface',null=True)
    name = models.CharField(max_length=32, null=True)

class RoleUser(models.Model):

    role = models.ForeignKey("Role", null=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, null=True)

class Route(models.Model):

    title = models.CharField(max_length=32, unique=True)
    name = models.CharField(max_length=32, null=True)
    parent = models.ForeignKey("Route", null=True, blank=True)
    path = models.CharField(max_length=128,null=True)
    component = models.CharField(max_length=128, null = True)
    componentPath = models.CharField(max_length=128, null=True)
    icon = models.CharField(max_length=128, null =True)
    permission = models.ForeignKey("FunctionInterface", null=True, blank=True)
    mtype = models.IntegerField(default=0)
    sort = models.IntegerField(default=0)
    isLock = models.BooleanField(default=True)


class Menu(models.Model):
    """
    菜单
    """
    title = models.CharField(max_length=32, unique=True)
    parent = models.ForeignKey("Menu", null=True, blank=True)
    path = models.CharField(max_length=128)
    icon = models.CharField(max_length=128, null = True)
    permission = models.ForeignKey("FunctionInterface", null=True, blank=True)
    mtype = models.IntegerField(null=True)
    sort = models.IntegerField(null=True)
    isLock = models.BooleanField(default=False)
    index = models.IntegerField(null=True)
    # 定义菜单间的自引用关系
    # 权限url 在 菜单下；菜单可以有父级菜单；还要支持用户创建菜单，因此需要定义parent字段（parent_id）
    # blank=True 意味着在后台管理中填写可以为空，根菜单没有父级菜单

class Permission(models.Model):
    """
    权限
    """
    role = models.ForeignKey("Role", null=True)
    function = models.ForeignKey("FunctionInterface", null=True)

class Role(models.Model):
    """
    角色：绑定权限
    """
    name = models.CharField(max_length=32, unique=True)
    code = models.CharField(max_length=32, unique=True)
    description = models.CharField(max_length=512)

class UserExtraInfo(models.Model):

    user = models.ForeignKey(settings.AUTH_USER_MODEL, null=True)
    icon = models.CharField(max_length=128, null = True)
    gender = models.CharField(max_length=128, null = True)
    real_name = models.CharField(max_length=128, null = True)
    phone = models.CharField(max_length=128,null=True)

# class User(models.Model):
#     """
#     用户：划分角色
#     """
#     user = models.OneToOneField(to=settings.AUTH_USER_MODEL)

#     def __str__(self):
#         return self.username

''' 继承自带的用户表
settings.py:
AUTH_USER_MODEL = 'rbac.User'
from django.contrib.auth.models import AbstractUser
class User(AbstractUser):
    """
    用户：划分角色
    """
    username = models.CharField(verbose_name='用户', max_length=32, unique=True)
    roles = models.ManyToManyField(verbose_name='角色', to="Role")
    # 定义用户和角色的多对多关系
    def __str__(self):
        return self.username
'''




@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)


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
    DETECT_CHOICE = (
            (0, 'close'),
            (1, 'open'),
            )
    cameraName     = models.CharField(max_length=256, verbose_name="摄像头名称")
    cameraLocation = models.CharField(max_length=256, verbose_name="摄像头位置")
    cameraLat      = models.CharField(max_length=24, verbose_name="纬度")
    cameraLon      = models.CharField(max_length=24, verbose_name="经度")
    c_ip           = models.CharField(max_length=24, null = True ,verbose_name="摄像头ip地址")
    c_username     = models.CharField(max_length=100, null = True ,verbose_name="摄像头用户名")
    c_password     = models.CharField(max_length=100, null = True ,verbose_name="摄像头密码")
    c_token        = models.CharField(max_length=24, null = True ,verbose_name="摄像头token")
    c_detectStatus = models.IntegerField(choices=DETECT_CHOICE, default=0 ,verbose_name="摄像头检测状态")

    class Meta:
        verbose_name = "摄像头信息"
        verbose_name_plural = verbose_name

class CameraStream(models.Model):
    streamUrl = models.URLField(verbose_name="视频地址", null=True, unique=True)
    streamTime = models.CharField(max_length=256, null=True, blank=True, verbose_name="流time")
    streamFps = models.CharField(max_length=256, null=True, blank=True, verbose_name="流fps")
    streamStatus = models.CharField(max_length=256, null=True, blank=True, verbose_name="流status")
    startTime = models.CharField(max_length=256, null=True, blank=True, verbose_name="流time")
    cameraId = models.ForeignKey('Camera', on_delete=models.CASCADE)
    label = models.CharField(max_length=256, null=True, blank=True, verbose_name="时间")


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

class CameraRealtime(models.Model):
    cameraid  = models.CharField(max_length=10, verbose_name='摄像头ID')
    c_x = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框x")
    c_y = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框y")
    c_w = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框w")
    c_h = models.CharField(max_length=10, null=True, blank=True, verbose_name="矩形框h")
    c_threshold = models.CharField(max_length=10, null=True, blank=True, verbose_name="检测阈值")
    imgurl = models.CharField(max_length=100, null=True, verbose_name="图片url")
    faceid = models.CharField(max_length=10, verbose_name='人员ID')
    #c_token = models.CharField(max_length=24, null=True, verbose_name="摄像头token")
    #timestap = models.CharField(max_length=100, verbose_name="时间戳")

    class Meta:
        verbose_name="实时监控数据"
        verbose_name_plural = verbose_name


# test serializer
class Album(models.Model):
    album_name = models.CharField(max_length=100)
    artist = models.CharField(max_length=100)

class Track(models.Model):
    album = models.ForeignKey(Album, related_name='tracks', on_delete=models.CASCADE)
    order = models.IntegerField()
    title = models.CharField(max_length=100)
    duration = models.IntegerField()

    class Meta:
        unique_together = ['album', 'order']
        ordering = ['order']

    def __str__(self):
        return '%d: %s' % (self.order, self.title)
