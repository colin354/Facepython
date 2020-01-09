from django.contrib.auth.models import User
from rest_framework import serializers
from rest_framework.authtoken.models import Token
from apps.users.models import Face
from apps.users.models import FaceImg
from apps.users.models import Check
from apps.users.models import Stream
from apps.users.models import Camera,Stranger,Role,CameraStream,PersonReid,PersonDetect,MatchUp,CameraRealtime,Permission, FunctionInterface,Interface, Track, Album
from apps.users.models import UserExtraInfo
# start test
class TrackSerializer(serializers.ModelSerializer):
    class Meta:
        model = Track
        fields = ['order', 'title', 'duration']

class AlbumSerializer(serializers.ModelSerializer):
    tracks = TrackSerializer(many=True, read_only=True)

    class Meta:
        model = Album
        fields = ['album_name', 'artist', 'tracks']
# end test

class UserExtraInfoSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserExtraInfo
        exclude = ['id']

class FunctionInterfaceSerializer(serializers.ModelSerializer):

    class Meta:
        model = FunctionInterface
        fields = '__all__'

class InterfaceSerializer(serializers.ModelSerializer):

    class Meta:
        model = Interface
        fields = '__all__'

class PermissionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Permission
        fields = '__all__'


class RoleSerializer(serializers.ModelSerializer):
    '''
    角色序列化
    '''
    class Meta:
        model = Role
        fields = '__all__'


class TokenSerializer(serializers.ModelSerializer):
    """
    用户信息序列化
    """
    first_name = serializers.CharField(source="user.first_name")
    last_name = serializers.CharField(source="user.last_name")
    email = serializers.CharField(source="user.email")
    date_joined = serializers.CharField(source="user.date_joined")

    class Meta:
        model = Token
        fields = ('first_name', 'last_name', 'email', 'key', 'date_joined')

class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        exclude = ['password', 'is_superuser']


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
        fields = ('id','cameraName','cameraLocation','cameraLat','cameraLon','c_ip','c_username', 'c_password', 'c_token','c_detectStatus')


class CameraStreamSerializer(serializers.ModelSerializer):
    """
    视频流信息
    """
    class Meta:
        model = CameraStream
        fields = ('id','cameraId','streamUrl','streamTime','streamFps','streamStatus','startTime','label')


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
        fields = ('person_id','c_x','c_y','c_w','c_h','url','timestap','dec_img_url','c_threshold')


class MatchUpSerializer(serializers.ModelSerializer):
    """
    对应关系表
    """
    class Meta:
        model = MatchUp
        fields = ("person_id","faceid",'c_threshold','dec_img_url')

class CameraRealtimeSerializer(serializers.ModelSerializer):
    class Meta:
        model = CameraRealtime
        fields = ("cameraid","c_x","c_y","c_w","c_h","c_threshold","imgurl","faceid")
