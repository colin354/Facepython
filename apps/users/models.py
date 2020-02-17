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
    imgurl = models.CharField(max_length=200, null=True, verbose_name="图片url")
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
    cameraName     = models.CharField(max_length=100, verbose_name="摄像头名称")
    cameraLocation = models.CharField(max_length=256, verbose_name="摄像头位置")
    cameraLat      = models.CharField(max_length=24, null=True,verbose_name="纬度")
    cameraLon      = models.CharField(max_length=24, null=True,verbose_name="经度")
    c_ip           = models.CharField(max_length=24, null = True ,verbose_name="摄像头ip地址")
    c_username     = models.CharField(max_length=100, null = True ,verbose_name="摄像头用户名")
    c_password     = models.CharField(max_length=100, null = True ,verbose_name="摄像头密码")
    c_token        = models.CharField(max_length=24, null = True ,verbose_name="摄像头token")
    c_detectStatus = models.IntegerField(choices=DETECT_CHOICE, default=0 ,verbose_name="摄像头检测状态")
    warning_event  = models.CharField(max_length=256,null=True,verbose_name='预警事件编号')
    color = models.IntegerField(null=True,verbose_name="分级")
    class Meta:
        verbose_name = "摄像头信息"
        verbose_name_plural = verbose_name

class CameraStream(models.Model):
    streamUrl = models.URLField(verbose_name="视频地址", null=True, unique=True)
    streamTime = models.CharField(max_length=256, null=True, blank=True, verbose_name="流time")
    streamFps = models.CharField(max_length=256, null=True, blank=True, verbose_name="流fps")
    streamStatus = models.CharField(max_length=256, null=True, blank=True, verbose_name="流status")
    startTime = models.CharField(max_length=256, null=True, blank=True, verbose_name="流time")
    endTime = models.CharField(max_length=256, null=True, blank=True, verbose_name="结束time")
    cameraId = models.ForeignKey('Camera', on_delete=models.CASCADE)
    label = models.CharField(max_length=256, null=True, blank=True, verbose_name="时间")
    faceNum   = models.IntegerField(default=0,null=True, blank=True, verbose_name='人脸识别数')
    personNum   = models.IntegerField(default=0,null=True, blank=True, verbose_name='行人识别数')

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
    StreamUrl = models.CharField(max_length=200,null=True,blank=True,verbose_name="视频名称")
    imgurl = models.CharField(max_length=200, null=True, verbose_name="图片url")
    faceid = models.CharField(max_length=10, verbose_name='人员ID')
    #c_token = models.CharField(max_length=24, null=True, verbose_name="摄像头token")
    timestap = models.CharField(max_length=10, null=True, blank=True, verbose_name="时间戳")

    class Meta:
        verbose_name="实时监控数据"
        verbose_name_plural = verbose_name

class WarningType(models.Model):
    WARNING_LEVEL = (
        (0, 'Ⅰ 级'),
        (1, 'Ⅱ 级'),
        (2, 'Ⅲ 级'),
        (3, 'Ⅳ 级'),
        (4, 'Ⅴ 级'),
    )
    warning_level = models.IntegerField(choices=WARNING_LEVEL, default=0 ,verbose_name='预警级别')
    warning_type  = models.CharField(max_length=10, null=True, blank=True, verbose_name='预警事件类型')
 
    class Meta:
        verbose_name="预警事件类型"
        verbose_name_plural = verbose_name
 
class WarningEvent(models.Model):
    WARNING_FLAG = (
        (0,'停止'),
        (1,'启动')
    )
    warning_id            = models.CharField(max_length=100, null=True, blank=True, verbose_name='预警事件编号')
    warning_name          = models.CharField(max_length=100, null=True, blank=True, verbose_name='预警事件名称')
    warning_type_id       = models.ForeignKey('WarningType', on_delete=models.CASCADE)
    warning_people_max    = models.CharField(max_length=100, null=True, blank=True, verbose_name='行人数量上限')
    warning_car_max       = models.CharField(max_length=100, null=True, blank=True, verbose_name='车辆数量上限')
    warning_target_people = models.CharField(max_length=100, null=True, blank=True, verbose_name='目标行人')
    warning_target_car    = models.CharField(max_length=100, null=True, blank=True, verbose_name='目标车辆')
    warning_target_camera = models.CharField(max_length=100, null=True, blank=True, verbose_name='目标摄像头')
    warning_event_flag    = models.IntegerField(blank=True,null=True, default=0,verbose_name='预警是否启动')
    warning_event_time    = models.DateTimeField(auto_now_add=True,verbose_name='事件启动时间')

    class Meta:
        verbose_name="预警事件"
        verbose_name_plural = verbose_name
  
class WarningHistory(models.Model):
    WARNING_LEVEL = (
        (0, 'Ⅰ 级'),
        (1, 'Ⅱ 级'),
        (2, 'Ⅲ 级'),
        (3, 'Ⅳ 级'),
        (4, 'Ⅴ 级'),
    )
    warning_color         = models.IntegerField(choices=WARNING_LEVEL, default=0 ,verbose_name='预警级别颜色')
    warning_camera_id     = models.CharField(max_length=100, null=True, blank=True, verbose_name='预警摄像头')
    warning_time          = models.DateTimeField(auto_now_add=True,verbose_name='预警发生时间')
    warning_video_url     = models.CharField(max_length=150, null=True, blank=True, verbose_name='预警视频url')
    warning_message       = models.CharField(max_length=250, null=True, blank=True, verbose_name='预警事件信息')
    warning_capture_url   = models.CharField(max_length=250, null=True, blank=True, verbose_name='预警抓拍图片')
    warning_target_url    = models.CharField(max_length=250, null=True, blank=True, verbose_name='匹配目标图片')
    warning_event_id      = models.ForeignKey('WarningEvent', on_delete=models.CASCADE)

    class Meta:
        verbose_name="预警事件历史"
        verbose_name_plural = verbose_name

class LoginRecord(models.Model):
    login_username     = models.CharField(max_length=100, null=True, blank=True, verbose_name='登录用户名')
    login_op       = models.CharField(max_length=100, null=True, blank=True, verbose_name='操作类型')
    login_status   = models.IntegerField(default=0,null=True, blank=True, verbose_name='状态')
    login_ip       = models.CharField(max_length=100, null=True, blank=True, verbose_name='操作ip')
    login_useragent= models.CharField(max_length=256, null=True, blank=True, verbose_name='用户代理')
    login_time     = models.DateTimeField(auto_now_add=True,verbose_name='登录时间')
    
    class Meta:
        verbose_name="登录日志"
        verbose_name_plural = verbose_name

class OperationRecord(models.Model):
    operation_username  = models.CharField(max_length=100, null=True, blank=True, verbose_name='登录用户名')
    operation_op        = models.CharField(max_length=100, null=True, blank=True, verbose_name='操作类型')
    operation_method    = models.CharField(max_length=100, null=True, blank=True, verbose_name='请求方法')
    operation_params    = models.CharField(max_length=200, null=True, blank=True, verbose_name='请求参数')
    operation_url       = models.CharField(max_length=100, null=True, blank=True, verbose_name='请求url')
    operation_status    = models.IntegerField(default=0,null=True, blank=True, verbose_name='状态')
    operation_ip        = models.CharField(max_length=100, null=True, blank=True, verbose_name='操作ip')
    operation_useragent= models.CharField(max_length=200, null=True, blank=True, verbose_name='用户代理')
    operation_time     = models.DateTimeField(auto_now_add=True,verbose_name='登录时间')

    class Meta:
        verbose_name="操作日志"
        verbose_name_plural = verbose_name

class Pedestrian(models.Model):
    cameraName = models.CharField(max_length=100,verbose_name="摄像头名称")
    c_threshold = models.CharField(max_length=10, null=True, blank=True, verbose_name="置信度")
    imgurl = models.CharField(max_length=150, null=True, blank=True, verbose_name="图片地址")
    datetime = models.CharField(max_length=20, null=True, blank=True, verbose_name="实时时间")
    color = models.IntegerField(null=True,blank=True, verbose_name="分级")
    message = models.CharField(max_length=100,null= True,blank = True,verbose_name="告警信息")
    class Meta:
        verbose_name="行人检测"
        verbose_name_plural = verbose_name
