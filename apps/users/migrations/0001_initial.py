# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Check',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('faceid', models.CharField(max_length=10, verbose_name='人脸ID')),
                ('streamid', models.CharField(max_length=256, verbose_name='流ID')),
                ('timestap', models.CharField(max_length=100, verbose_name='时间戳')),
                ('time', models.FloatField(null=True, verbose_name='时间')),
                ('c_x', models.CharField(blank=True, max_length=10, null=True, verbose_name='矩形框x')),
                ('c_y', models.CharField(blank=True, max_length=10, null=True, verbose_name='矩形框y')),
                ('c_w', models.CharField(blank=True, max_length=10, null=True, verbose_name='矩形框w')),
                ('c_h', models.CharField(blank=True, max_length=10, null=True, verbose_name='矩形框h')),
                ('c_ip', models.CharField(blank=True, max_length=15, null=True, verbose_name='ip')),
                ('c_gender', models.CharField(blank=True, max_length=10, null=True, verbose_name='检测性别')),
                ('c_age', models.CharField(blank=True, max_length=10, null=True, verbose_name='检测年龄')),
                ('c_threshold', models.CharField(blank=True, max_length=10, null=True, verbose_name='检测阈值')),
                ('url', models.CharField(max_length=100, null=True, verbose_name='流url')),
                ('imgurl', models.CharField(max_length=100, null=True, verbose_name='图片url')),
            ],
            options={
                'verbose_name_plural': '匹配信息',
                'verbose_name': '匹配信息',
            },
        ),
        migrations.CreateModel(
            name='Face',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=255, verbose_name='用户名')),
                ('mobile', models.CharField(max_length=11, verbose_name='手机号')),
                ('gender', models.BooleanField()),
                ('email', models.EmailField(max_length=254)),
                ('flag', models.IntegerField(choices=[(0, 'new'), (1, 'update'), (2, 'delete')], default=0)),
                ('createDate', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'verbose_name_plural': '人脸数据',
                'verbose_name': '人脸数据',
            },
        ),
        migrations.CreateModel(
            name='FaceImg',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('imgurl', models.URLField(null=True, verbose_name='照片地址')),
                ('userid', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='users.Face')),
            ],
            options={
                'verbose_name_plural': '人脸图片地址',
                'verbose_name': '人脸图片地址',
            },
        ),
        migrations.CreateModel(
            name='Stream',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('streamname', models.CharField(max_length=50, unique=True, verbose_name='流名称')),
                ('streamlocation', models.CharField(max_length=100, verbose_name='流位置')),
                ('streamurl', models.CharField(max_length=100, verbose_name='流url')),
                ('streamlat', models.CharField(blank=True, max_length=24, verbose_name='纬度')),
                ('streamlon', models.CharField(blank=True, max_length=24, verbose_name='经度')),
                ('flag', models.IntegerField(choices=[(0, 'new'), (1, 'update'), (2, 'delete')], default=0)),
                ('createDate', models.DateTimeField(auto_now_add=True)),
                ('streamtime', models.CharField(blank=True, max_length=256, null=True, verbose_name='流time')),
                ('streamfps', models.CharField(blank=True, max_length=256, null=True, verbose_name='流fps')),
                ('streamstatus', models.CharField(blank=True, max_length=256, null=True, verbose_name='流status')),
            ],
            options={
                'verbose_name_plural': '流信息',
                'verbose_name': '流信息',
            },
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('phone', models.CharField(blank=True, default='', max_length=11, verbose_name='手机号')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='auth_user', to=settings.AUTH_USER_MODEL, verbose_name='用户')),
            ],
        ),
        migrations.CreateModel(
            name='VerifyCode',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.CharField(max_length=10, verbose_name='验证码')),
                ('mobile', models.CharField(max_length=11, verbose_name='电话')),
            ],
            options={
                'verbose_name_plural': '短信验证码',
                'verbose_name': '短信验证码',
            },
        ),
    ]
