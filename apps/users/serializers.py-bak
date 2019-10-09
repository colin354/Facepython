from django.contrib.auth.models import User
from rest_framework import serializers
from rest_framework.authtoken.models import Token
from apps.users.models import Face
from apps.users.models import FaceImg
from apps.users.models import Check
from apps.users.models import Stream

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
        fields = ('username', 'mobile', 'gender', 'email', 'flag', 'id', 'createDate')

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
