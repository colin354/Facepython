from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import Role
from apps.users.models import RoleUser
from apps.users.models import Menu
from apps.users.serializers import RoleSerializer
from apps.users.serializers import UserSerializer
from apps.users.serializers import UserExtraInfoSerializer
from apps.users.serializers import InterfaceSerializer
from apps.users.utility import TokenVerify
from rest_framework import status
from django.contrib.auth.models import User
import os, shutil
import ipdb

class MenuAPI(APIView):

    @TokenVerify
    def get(self, request):
        data = []
        tmp = []
        parent = {}
        all_menus = Menu.objects.all().order_by('sort', 'index')
        for item in all_menus:
            if(item.sort == 1):
                tmp.append({"id":item.id, "title":item.title, "path":item.path, "icon":item.icon, "parentId":-1, "type":item.mtype, "sort":item.sort})
                parent[str(item.id)] = tmp[-1]
            else:
                if(parent[str(item.parent_id)].get('children') is None):
                    parent[str(item.parent_id)]['children']=[]
                parent[str(item.parent_id)]["children"].append({"id":item.id,"title":item.title, "path":item.path, "icon":item.icon, "parentId":item.parent_id, "type":item.mtype, "sort":item.sort})
                parent[str(item.id)] = parent[str(item.parent_id)]["children"][-1]
        data = tmp
        return JsonResponse(data={'list':data, 'count':len(data)}, code='999999', msg='成功')
all_menus = MenuAPI.as_view()
