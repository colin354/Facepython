import urllib3
import time
from random import choice

http = urllib3.PoolManager()
i = 1
data_array = [
    {'cameraid': '6', 
     'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
     'c_threshold':'1.0000',
     'imgurl':'/media_9010/face_image/frame_207654_1065.jpg', 
     'datetime':'20200121_150727',
     'faceid': 1999,
     'url':'rtsp://172.16.3.139/34020000001320000104',
     'StreamUrl':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    },
    {'cameraid': '6', 
     'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
     'c_threshold':'1.0000',
     'datetime':'20200121_150727',
     'imgurl':'/media_9010/face_image/frame_26669_1096.jpg', 
     'faceid': 2001,
     'url':'rtsp://172.16.3.139/34020000001320000104',
     'StreamUrl':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    },
    {'cameraid': '6', 
     'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
     'c_threshold':'1.0000',
     'datetime':'20200121_150727',
     'imgurl':'/media_9010/face_image/frame_2479_1016.jpg', 
     'faceid': 2000,
     'url':'rtsp://172.16.3.139/34020000001320000104',
     'StreamUrl':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    },
    {'cameraid': '6', 
     'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
     'c_threshold':'0.6789',
     'imgurl':'/media_9010/face_image/frame_202767_1065.jpg', 
     'datetime':'20200121_150727',
     'faceid': 1999,
     'url':'rtsp://172.16.3.139/34020000001320000104',
     'StreamUrl':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    },
    {'cameraid': '6', 
     'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
     'c_threshold':'0.6779',
     'datetime':'20200121_150727',
     'imgurl':'/media_9010/face_image/frame_35278_1005.jpg', 
     'faceid': 1,
     'url':'rtsp://172.16.3.139/34020000001320000104',
     'StreamUrl':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    },
    {'cameraid': '7', 
     'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
     'c_threshold':'0.6779',
     'imgurl':'/media_9010/face_image/frame_35278_1005.jpg', 
     'datetime':'20200121_150727',
     'faceid': 2,
     'url':'rtsp://172.16.3.131/34020000001320000101',
     'StreamUrl':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    },
    {'cameraid': '7', 
     'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
     'c_threshold':'1.000',
     'datetime':'20200121_150727',
     'imgurl':'/media_9010/face_image/frame_35278_1005.jpg', 
     'faceid': 2001,
     'url':'rtsp://172.16.3.131/34020000001320000101',
     'StreamUrl':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    },

] 

while True:
    i += 1
    data = choice(data_array)
    print(data)
    r = http.request('POST','http://127.0.0.1:9988/sys/cameraws',fields=data)
    print(r.data)
    time.sleep(3)

print(r.data)
