from __future__ import absolute_import
# -*- coding: utf-8 -*-
__author__ = 'Colin'
from Facepython.celery import app
from celery import shared_task
from apps.users.models import WarningType,WarningEvent
from apps.users.serializers import WarningTypeSerializer,WarningEventSerializer

@app.task
def add(x, y):
    return x + y

@app.task
def hello_world():
    with open("/home/lc/output.txt","a") as f:
        f.write("hello world")
        f.write("\n")
        print('hello world!!!!!')

@app.task
def start(warningevent):
    print(warningevent)
    return warningevent.warning_target_camera

@app.task
def stop(warningevent):
    print(warningevent)
    return warningevent.warning_target_camera

