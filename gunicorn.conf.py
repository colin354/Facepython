import multiprocessing
debug = True
loglevel = 'debug'
bind = '127.0.0.1:8001'
pidfile = 'log/gunicorn.pid'
#workers = multiprocessing.cpu_count() + 1
workers = 4 
pythonpath='/home/yancheng/venv/lib/python3.5/site-packages'
