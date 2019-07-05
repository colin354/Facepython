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

    username = models.CharField(max_length=255, verbose_name="用户名")
    mobile = models.CharField(max_length=11, verbose_name="手机号")
    gender = models.BooleanField()
    email = models.EmailField()
    flag = models.IntegerField(choices=FLAG_CHOICE, default=0)
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
    streamname     = models.CharField(max_length=50, verbose_name="流名称", unique = True)
    streamlocation = models.CharField(max_length=100, verbose_name="流位置")
    streamurl      = models.CharField(max_length=100, verbose_name="流url")
    streamlat      = models.CharField(max_length = 24 , verbose_name= "纬度",blank=True)
    streamlon      = models.CharField(max_length = 24 , verbose_name= "经度",blank=True)
    flag = models.IntegerField(choices=FLAG_CHOICE, default=0)
    createDate     = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name        = "流信息"
        verbose_name_plural = verbose_name

