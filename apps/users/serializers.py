from django.contrib.auth.models import User
from rest_framework import serializers
from rest_framework.authtoken.models import Token
from apps.users.models import Face,FaceImg,Check,Stream
from apps.users.models import WarningType,WarningEvent,WarningHistory
from apps.users.models import LoginRecord,OperationRecord
from apps.users.models import Plate,PlateRealtime,PersonRealtime
from apps.users.models import Camera,Stranger,CameraStream,PersonReid,PersonDetect,MatchUp,CameraRealtime
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
        fields = ('timestap', 'c_x', 'c_y','time', 'c_w', 'c_h', 'c_ip', 'c_gender', 'c_age', 'c_threshold', 'streamid', 'faceid', 'id', 'url', 'imgurl','datetime')

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
        fields = ('id','faceid','c_gender','c_age','imgurl')


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
        fields = ('id','cameraId','streamUrl','streamTime','endTime','streamFps','streamStatus','startTime','label','personNum','faceNum')


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
        fields = ('faceid','streamid','imgurl','url','c_threshold','timestap','query_imgurl','c_x','c_y','c_w','c_h','time','datetime')


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
        fields = ("cameraid","c_x","c_y","c_w","c_h","c_threshold","StreamUrl","imgurl","faceid","timestap",'datetime')

class WarningTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = WarningType
        fields = ("id","warning_level","warning_type")

class WarningEventSerializer(serializers.ModelSerializer):
    class Meta:
        model = WarningEvent
        fields = ("id","warning_id","warning_name","warning_type_id","warning_people_max","warning_car_max","warning_target_people","warning_target_car","warning_target_camera","warning_event_flag","warning_event_time")

class WarningHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = WarningHistory
        fields = ("id","warning_camera_id","warning_video_url","warning_event_id","warning_message","warning_time","warning_capture_url","warning_target_url","warning_color")

class LoginRecordSerializer(serializers.ModelSerializer):
    class Meta:
        model = LoginRecord
        fields = ("id","login_username","login_op","login_status","login_ip","login_useragent","login_time")

class OperationRecordSerializer(serializers.ModelSerializer):
    class Meta:
        model = OperationRecord
        fields = ("id","operation_username","operation_op","operation_method","operation_params","operation_url","operation_status","operation_ip","operation_useragent","operation_time")

class PlateRealtimeSerializer(serializers.ModelSerializer):
    class Meta:
        model = PlateRealtime
        fields = ("id","cameraid","stream_url","plate_id","plate_url","timestap","c_threshold","c_x","c_y","c_h","c_w",'datetime')

class PlateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plate
        fields = ("id","plate_id","plate_url")

class PersonRealtimeSerializer(serializers.ModelSerializer):
    class Meta:
        model = PersonRealtime
        fields = ("cameraid","c_x","c_y","c_w","c_h","c_threshold","StreamUrl","imgurl","faceid","query_imgurl","timestap","datetime")
