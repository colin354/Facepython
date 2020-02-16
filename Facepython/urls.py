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
from users.api import user,face,stream,facerecord,camera,warning,log
#from users.api import face
from django.views.generic import TemplateView
from django.conf.urls.static import static
from django.conf import settings
from users.api import check,person,match,detect_ctl,screen_data
urlpatterns = [
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^admin/', admin.site.urls),
    url(r'^api-token-auth', views.obtain_auth_token),
    url(r'^api/user/login',user.obtain_auth_token),
    url(r'^api/sys/user/info',user.user_profile),
    url(r'^api/user\/(?P<id>[0-9]+)/$',user.user_profile),
    url(r'^api/face/image',face.face_list),
    url(r'^api/face',face.faces),
    url(r'^img',face.face_img),
    url(r'^api/check', check.check_face),
    url(r'^sys/check/location', check.check_location),#可根据下面个的注释做修改
    url(r'^captcha',include('captcha.urls')),
    url(r'^captcha/code',user.verification_code),
    # url(r'api/user/login', user.obtain_auth_token),
    url(r'^sys/stream/page',stream.stream_list), #获取数据库信息URL
    url(r'^sys/stream/check',stream.stream_check),#必须写在sys/stream上面 ，依次匹配每个URL模式，
                  # 在与请求的URL相匹配的第一个模式停下来。也就是说，url匹配是从上往下的短路操作，所以url在列表中的位置非常关键。
    url(r'^sys/stream',stream.stream_add),
    url(r'^sys/facerecord',facerecord.face_record),
    url(r'^sys/stranger',face.strangers),
    url(r'^sys/camerastream', camera.camera_stream),
    url(r'^sys/camerareal', camera.camera_real),
    url(r'^sys/cameraws', camera.camera_ws),
    url(r'^sys/camerarecord', camera.camera_record_for_cs),
    #新增小区隔离管控
    url(r'^sys/camera_pedestrian_ws',camera.camera_pedestrian),
    url(r'^sys/cameras',camera.cameras),
    url(r'^sys/check',check.check_track),
    url(r'^sys/detect_ctl',detect_ctl.detect),
    url(r'^sys/log/login/page',log.login_record),
    url(r'^sys/log/operation/page',log.operation_record),
    url(r'^api/screenData',screen_data.screen_info),
    url(r'^api/screenDevice',screen_data.screen_device),
    url(r'^api/screenRight/warning',screen_data.screen_warning),
    url(r'^api/warningType',warning.warning_type),
    url(r'^api/warningEvent',warning.warning_event),
    url(r'^api/warningHistory',warning.warning_history),
    url(r'^api/warningCtrl',warning.warning_event_ctrl),
    #url(r'^api/check/location', check.check_location),
    url(r'^api/person',person.person_detect),
    url(r'^api/match',match.match_up),
    url(r'^api/videoStruct',stream.video_structred),
    url(r'^', TemplateView.as_view(template_name="index.html"))] + static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT) + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
