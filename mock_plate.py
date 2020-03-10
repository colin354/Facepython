#-*- coding: utf-8 -*-
import urllib3
import time
from random import choice

http = urllib3.PoolManager()
i = 1
data_array = [
    {'cameraid': '6', 
     'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
     'c_threshold':'1.0000',
     'plate_url':'/media_9010/face_image/frame_207654_1065.jpg', 
     'plate_id':'苏JJ150M', 
     'url':'rtsp://172.16.3.139/34020000001320000104',
     'stream_url':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4',
     'datetime':'20200227153200'
    },
    # {'cameraid': '6', 
    #  'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
    #  'c_threshold':'1.0000',
    #  'plate_url':'/media_9010/face_image/frame_26669_1096.jpg', 
    #  'plate_id': '皖A:88888',
    #  'url':'rtsp://172.16.3.139/34020000001320000104',
    #  'stream_url':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    # },
    # {'cameraid': '6', 
    #  'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
    #  'c_threshold':'1.0000',
    #  'plate_url':'/media_9010/face_image/frame_2479_1016.jpg', 
    #  'plate_id':'苏D:87720', 
    #  'url':'rtsp://172.16.3.139/34020000001320000104',
    #  'stream_url':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    # },
    # {'cameraid': '6', 
    #  'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
    #  'c_threshold':'0.6789',
    #  'plate_url':'/media_9010/face_image/frame_202767_1065.jpg', 
    #  'plate_id':'苏D:87720', 
    #  'url':'rtsp://172.16.3.139/34020000001320000104',
    #  'stream_url':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    # },
    # {'cameraid': '6', 
    #  'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
    #  'c_threshold':'0.6779',
    #  'plate_url':'/media_9010/face_image/frame_35278_1005.jpg', 
    #  'plate_id':'苏D:99920', 
    #  'url':'rtsp://172.16.3.139/34020000001320000104',
    #  'stream_url':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    # },
    # {'cameraid': '7', 
    #  'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
    #  'c_threshold':'0.6779',
    #  'plate_url':'/media_9010/face_image/frame_35278_1005.jpg', 
    #  'plate_id':'苏D:12345', 
    #  'url':'rtsp://172.16.3.131/34020000001320000101',
    #  'stream_url':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    # },
    # {'cameraid': '7', 
    #  'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
    #  'c_threshold':'1.000',
    #  'plate_url':'/media_9010/face_image/frame_35278_1005.jpg', 
    #  'plate_id':'苏D:PH521', 
    #  'url':'rtsp://172.16.3.131/34020000001320000101',
    #  'stream_url':'http://221.231.13.230:8888/record_video/media_9010/34020000001320000201/20191230_12_53_15.mp4'
    # },

] 

while True:
    i += 1
    data = choice(data_array)
    print(data)
    r = http.request('POST','http://127.0.0.1:9988/sys/cameraplatews',fields=data)
    print(r.data)
    time.sleep(3)

print(r.data)
