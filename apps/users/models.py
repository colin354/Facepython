from django.contrib.auth.models import User
from django.db import models

from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token


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
    code = models.CharField(max_length=10, verbose_name="验证码")
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
    imgurl = models.URLField(verbose_name="照片地址")
    gender = models.BooleanField()
    email = models.EmailField()
    flag = models.IntegerField(choices=FLAG_CHOICE, default=0)
    createDate = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "人脸数据"
        verbose_name_plural = verbose_name

