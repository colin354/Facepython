from django.contrib.auth.models import User
from rest_framework import serializers
from rest_framework.authtoken.models import Token
from apps.users.models import Face
from apps.users.models import FaceImg
from apps.users.models import Check
from apps.users.models import Stream
from apps.users.models import Camera,Stranger,CameraUrl,PersonReid,PersonDetect

class TokenSerializer(serializers.ModelSerializer):
    """
    用户信息序列化
    """
    first_name = serializers.CharField(source="user.first_name")
    last_name = serializers.CharField(source="user.last_name")
    phone = serializers.CharField(source="user.user.phone")
    email = serializers.CharField(source="user.email")
    date_joined = serializers.CharField(source="user.date_joined")

    class Meta:
        model = Token
        fields = ('first_name', 'last_name', 'phone', 'email', 'key', 'date_joined')

class UserSerializer(serializers.ModelSerializer):


    class Meta:
        model = User
        fields = ('id', 'username', 'first_name')

class FaceSerializer(serializers.ModelSerializer):
    """
    人脸信息
    """

    class Meta:
        model = Face
        fields = ('username', 'mobile', 'gender', 'email', 'flag', 'id', 'createDate','face_flag')

class CheckSerializer(serializers.ModelSerializer):

    class Meta:
        model = Check
        fields = ('timestap', 'c_x', 'c_y','time', 'c_w', 'c_h', 'c_ip', 'c_gender', 'c_age', 'c_threshold', 'streamid', 'faceid', 'id', 'url', 'imgurl')

class FaceImgSerializer(serializers.ModelSerializer):
    """
    人脸图片信息
    """
    class Meta:
        model = FaceImg
        fields = ('userid', 'imgurl')
class StreamSerializer(serializers.ModelSerializer):
    """
    流信息
    """
    class Meta:
        model = Stream
        fields = ('id','streamname','streamlocation','streamurl','streamlat','streamlon','createDate', 'streamtime', 'streamstatus', 'streamfps')


class StrangerSerializer(serializers.ModelSerializer):
    """
    陌生人信息
    """
    class Meta:
        model = Stranger
        fields = ('faceid','c_gender','c_age','imgurl')


class CameraSerializer(serializers.ModelSerializer):
    """
    摄像头信息
    """
    class Meta:
        model = Camera
        fields = ('id','cameraname','cameralocation','cameralat','cameralon','c_ip','c_username', 'c_password', 'createDate')


class CameraUrlSerializer(serializers.ModelSerializer):
    """
    视频流信息
    """
    class Meta:
        model = CameraUrl
        fields = ('id','cameraid','streamurl','streamtime','streamfps','streamstatus')


# class FaceRecordSerializer(serializers.ModelSerializer):
#     """
#     摄像头信息
#     """
#     class Meta:
#         model = FaceRecord
#         fields = ('id','faceid','cameraid','c_x','c_y','c_w','c_h', 'c_ip', 'createDate','c_threshold','url','imgurl')

class PersonReidSerializer(serializers.ModelSerializer):
    """
    行人重识别
    """
    class Meta:
        model = PersonReid
        fields = ('faceid','streamid','imgurl','url','c_threshold','timestap','query_imgurl','c_x','c_y','c_w','c_h','time')


# class PersonTopSerializer(serializers.ModelSerializer):
#     """
#     行人重识别top5
#     """
#
#     class Meta:
#         model = PersonTop
#         fields = ('personreid','reid_imgurl','timestap','confidence')
class PersonDetcetSerializer(serializers.ModelSerializer):

    """
    行人重识别检测
    """
    class Meta:
        model = PersonDetect
        fields = ('person_id','c_x','c_y','c_w','c_h','url','timestap','dec_img_url')
