import multiprocessing
debug = True
loglevel = 'debug'
bind = '127.0.0.1:8000'
pidfile = 'log/gunicorn.pid'
logfile = 'log/debug.log'
workers = multiprocessing.cpu_count() + 1
pythonpath='/home/dr/.virtualenvs/django1.11/lib/python3.5/site-packages'
