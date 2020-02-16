from django.contrib.auth.models import User
from rest_framework import serializers
from rest_framework.authtoken.models import Token
from apps.users.models import Face
from apps.users.models import FaceImg
from apps.users.models import Check
from apps.users.models import Stream
from apps.users.models import WarningType,WarningEvent,WarningHistory
from apps.users.models import LoginRecord,OperationRecord
from apps.users.models import Camera,Stranger,CameraStream,PersonReid,PersonDetect,MatchUp,CameraRealtime,Pedestrian

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
        fields = ('id','faceid','c_gender','c_age','imgurl')


class CameraSerializer(serializers.ModelSerializer):
    """
    摄像头信息
    """
    class Meta:
        model = Camera
        fields = ('id','cameraName','cameraLocation','cameraLat','cameraLon','c_ip','c_username', 'c_password', 'c_token','c_detectStatus',"color")


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
        fields = ("cameraid","c_x","c_y","c_w","c_h","c_threshold","StreamUrl","imgurl","faceid","timestap")

class WarningTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = WarningType
        fields = ("id","warning_level","warning_type")

class WarningEventSerializer(serializers.ModelSerializer):
    class Meta:
        model = WarningEvent
        fields = ("id","warning_id","warning_name","warning_type_id","warning_people_max","warning_car_max","warning_target_people","warning_target_car","warning_target_camera","warning_event_flag","warning_event_time")

class WarningHistorySerializer(serializers.ModelSerializer):
    warning_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M:%S')
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



class PedestrianSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pedestrian
        fields = ('id','cameraName','c_threshold','imgurl','datetime','color','message')
