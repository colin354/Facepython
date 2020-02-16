import urllib3
import time
from random import choice

http = urllib3.PoolManager()
i = 1
data_array = [
    {'c_ip': '172.16.3.131', 
     'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
     'c_threshold':'1.0000',
     'imgurl':'/media_9010/face_image/frame_207654_1065.jpg', 
     'url':'rtsp://192.168.10.95/34020000001320000104',
     'datetime':'20191230_12_53_15'
    },
    {'c_ip': '172.16.3.132', 
     'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
     'c_threshold':'1.0000',
     'imgurl':'/media_9010/face_image/frame_207654_1065.jpg', 
     'url':'rtsp://192.168.10.98/34020000001320000104',
     'datetime':'20200111_12_53_40'
    },
    {'c_ip': '172.16.3.133', 
     'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18',
     'c_threshold':'1.0000',
     'imgurl':'/media_9010/face_image/frame_207654_1065.jpg', 
     'url':'rtsp://192.168.10.92/34020000001320000104',
     'datetime':'20200215_12_53_15'
    },
] 

while True:
    i += 1
    data = choice(data_array)
    print(data)
    r = http.request('POST','http://127.0.0.1:8888/sys/camera_pedestrian_ws',fields=data)
    print(r.data)
    time.sleep(3)

print(r.data)
