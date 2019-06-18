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
from users.api import user,face,stream
#from users.api import face
from django.conf.urls.static import static
from django.conf import settings
from users.api import check
urlpatterns = [
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^admin/', admin.site.urls),
    url(r'^api-token-auth', views.obtain_auth_token),
    url(r'^api/user/login',user.obtain_auth_token),
    url(r'^api/sys/user/info',user.user_profile),
    url(r'^api/user\/(?P<id>[0-9]+)/$',user.user_profile),
    url(r'^api/face',face.faces),
    url(r'^api/stream',stream.stream),
    url(r'^img',face.face_img),
    url(r'^api/check', check.check_face),
    url(r'^captcha',include('captcha.urls')),
    url(r'^captcha/code',user.verification_code),
    # url(r'api/user/login', user.obtain_auth_token),
    url(r'^sys/stream/page',stream.stream_list),#获取数据库信息URL
    url(r'^sys/stream',stream.stream_add),#增删改URL
] + static(settings.MEDIA_URL, document_root = settings.BASE_DIR + settings.MEDIA_URL)
