import urllib3
import time

http = urllib3.PoolManager()
i = 1
while True:
    i += 1
    data = {'cameraid': '3', 'c_x': '1160', 'c_y':'440', 'c_w':'25','c_h':'18','c_threshold':'0.534427',
             'imgurl':'res_img/pxwcamera/frame_28730_0.jpg', 'faceid': 52}
    r = http.request('POST','http://127.0.0.1:9988/sys/cameraws',fields=data)
    print(r.data)
    time.sleep(3)

print(r.data)
