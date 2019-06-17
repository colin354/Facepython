from captcha.models import CaptchaStore
from captcha.helpers import captcha_image_url
from users.common.api_response import JsonResponse
from rest_framework.views import APIView
from django.shortcuts import redirect

import pdb

class Captcha(APIView):

    def get(self, request, *args, **kwargs):
        hashkey = CaptchaStore.generate_key()
        # hashkey = request.GET.get('uuid')
        img_url = captcha_image_url(hashkey)
        captcha = {'haskkey': hashkey, 'img_url': img_url}
        return JsonResponse(data={}, code='999999', msg="成功")


    def judge_captcha():
        return JsonResponse(data={}, code='999999', msg='成功')

captcha_view = Captcha.as_view()
