"""Facepython URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
from rest_framework.authtoken import views
from users.api import user
from users.api import match

urlpatterns = [
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^admin/', admin.site.urls),
    url(r'api-token-auth', views.obtain_auth_token),
    url(r'api/user/login',user.obtain_auth_token),
    url(r'api/sys/user/info',user.obtain_user_info),
    url(r'sys/user',user.upload_face),
    url(r'api/face',user.upload_face),
    url(r'img/upload',user.upload_face),
    url(r'sys/stream/page',user.get_stream),
    url(r'sys/face/page',user.obtain_face_info),
    url(r'sys/face/delete',user.upload_face),
    url(r'sys/stream',user.upload_face),
    url(r'api/face/status', user.obtain_face_status),
    url(r'api/face_matching', match.face_match_info),
    url(r'captcha', include('captcha.urls')),
    url(r'refresh_captcha', user.obatin_captcha)
    # url(r'api/user/login', user.obtain_auth_token),
]
