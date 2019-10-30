from asgiref.sync import async_to_sync
from channels.generic.websocket import WebsocketConsumer
from channels.layers import get_channel_layer
import json

channel_layer = get_channel_layer()

class ChatConsumer(WebsocketConsumer):
        def connect(self):
                #创建channels group， 命名为：用户名，并使用channel_layer写入到redis
                print('====create=====')
                print(self.scope)
                print(self.scope['url_route']['kwargs']['c_token'])
                print(self.channel_layer)
                print(self.channel_name)
                self.c_token = self.scope['url_route']['kwargs']['c_token']
                #self.channel_name = self.c_token
                print(self.channel_name)
                async_to_sync(self.channel_layer.group_add)(self.c_token, self.channel_name)
                self.accept()

        def disconnect(self, close_code):
                print("ddddddis connect!!!!!")
                print(self.scope)
                self.c_token = self.scope['url_route']['kwargs']['c_token']
                #self.channel_name = self.c_token
                print(self.channel_name)
                async_to_sync(self.channel_layer.group_discard)(self.c_token, self.channel_name)


        def receive(self, text_data):
                print('****************')
                async_to_sync(self.channel_layer.group_send)(
                    self.scope['url_route']['kwargs']['c_token'],
                    {
                        "type": "user.message",
                        "text": text_data,
                    },
                )

        def user_message(self, event):
                self.send(text_data=event["text"])
