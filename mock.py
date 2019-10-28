#!/home/xiaoxiao/anaconda3/bin/python3.7
import urllib3
import time

http = urllib3.PoolManager()
i = 1
while True:
    i += 1
    data = {'name': '塞亚猫', 'skill': '卖萌', 'num': i}
    r = http.request('POST','http://10.2.155.139:9988/sys/cameraws',fields=data)
    print(r.data)
    time.sleep(3)

print(r.data)
