from rest_framework.views import APIView
from users.common.api_response import JsonResponse
from apps.users.models import Role
from apps.users.models import RoleUser
from apps.users.models import Menu
from apps.users.models import Permission
from apps.users.serializers import RoleSerializer
from apps.users.serializers import UserSerializer
from apps.users.serializers import UserExtraInfoSerializer
from apps.users.serializers import InterfaceSerializer
from apps.users.utility import TokenVerify
from rest_framework import status
from django.contrib.auth.models import User
import os, shutil
import ipdb

class RoleApi(APIView):

    @TokenVerify
    def get(self, request):
        # 根据角色名字模糊查询
        role_name = request.GET.get('role_name')
        filter_role = []
        data = []
        if(role_name is not None and role_name != ""):
            filter_role = Role.objects.filter(name__contains=role_name)
            for item in filter_role:
                temp = {}
                temp = RoleSerializer(item).data
                temp['interface'] = []
                temp['interface'] = InterfaceSerializer(list(map(lambda x:x.function.interface, item.permission_set.all())), many=True).data
                data.append(temp)
            return JsonResponse(data=data, code='999999', msg='成功')
        # 根据角色id查询
        role_id = request.GET.get('role_id')
        if(role_id is not None and role_id != ""):
            filter_role = Role.objects.filter(pk=role_id)
            for item in filter_role:
                temp = {}
                temp = RoleSerializer(item).data
                temp['interface'] = []
                temp['interface'] = InterfaceSerializer(list(map(lambda x:x.function.interface, item.permission_set.all())), many=True).data
                data.append(temp)
            return JsonResponse(data=data, code='999999', msg='成功')
        data = RoleSerializer(Role.objects.all(), many=True).data
        return JsonResponse(data={'list':data, 'count':len(data)}, code='999999', msg='成功')

    @TokenVerify
    def post(self, request):
        print(request.data)
        role_name = request.data.get('name')
        role_code = request.data.get('code')
        role_description = request.data.get('description')
        if(role_name is None or role_code is None or role_description is None):
            return JsonResponse(data={"字段为空"}, code='999999', msg = '失败')
        Role.objects.create(name=role_name, code = role_code, description=role_description)
        return JsonResponse(data={}, code='999999', msg='成功')

    @TokenVerify
    def put(self, request):
        print(request.data)
        role_id = request.data.get('id')
        role_name = request.data.get('name')
        role_code = request.data.get('code')
        role_description = request.data.get('description')
        if(role_id is None):
            return JsonResponse(data={"role_id字段为空"}, code='999999', msg = '失败',status=status.HTTP_400_BAD_REQUEST)
        role = Role.objects.get(pk=role_id)
        if(role is None):
            return JsonResponse(data={"没有此角色"}, code='999999', msg = '失败', status = status.HTTP_404_NOT_FOUND)
        if(role_name is not None):
            role.name = role_name
        if(role_code is not None):
            role.code = role_code
        if(role_description is not None):
            role.description = role_description
        role.save()
        return JsonResponse(data={}, code='999999', msg='成功')

    @TokenVerify
    def delete(self, request):
        print(request.data)
        path = request.path
        role_id = -1
        try:
            role_id = int(path.split('/')[-1])
        except Exception as e:
            return JsonResponse(data={"url路径错误, 缺少ID"}, code='999999', msg='失败', status=status.HTTP_400_BAD_REQUEST)
        role = Role.objects.get(pk=role_id)
        if(role is None):
            return JsonResponse(data={"没有此角色"}, code='999999', msg = '失败', status = status.HTTP_404_NOT_FOUND)
        role.delete()
        return JsonResponse(data={}, code='999999', msg='成功')

class RoleOfUser(APIView):

    @TokenVerify
    def get(self, request):
        path = request.path
        role_id = -1
        try:
            role_id = int(path.split('/')[-1])
        except Exception as e:
            return JsonResponse(data={"url路径错误, 缺少userID"}, code='999999', msg='失败', status=status.HTTP_400_BAD_REQUEST)
        data = []
        users = User.objects.all()
        for item in users:
            temp = UserSerializer(item).data
            if(item.userextrainfo_set.count()==1):
                temp = {**temp, **(UserExtraInfoSerializer(item.userextrainfo_set.all()[0]).data)}
            else:
                temp['real_name'] = ""
                temp['gender'] = ""
                temp['phone'] = ""
            temp['isAdd'] = False
            try:
                item.roleuser_set.get(role_id=role_id)
                temp['isAdd'] = True
            except Exception as e:
                pass
            data.append(temp)
        return JsonResponse(data={'list':data, 'count':len(data)}, code='999999', msg='成功')

class RoleOfMenu(APIView):

    @TokenVerify
    def get(self, request):
        print('role-of-menu')
        path = request.path
        role_id = -1
        try:
            role_id = int(path.split('/')[-1])
        except Exception as e:
            return JsonResponse(data={"url路径错误, 缺少userID"}, code='999999', msg='失败', status=status.HTTP_400_BAD_REQUEST)
        data = []
        function_ids = set()
        for item in Permission.objects.filter(role_id = role_id):
            function_ids.add(item.function.id)
        ### 处理 Menus
        print(role_id)
        print(function_ids)
        menus_id = Menu.objects.filter(permission__in = list(function_ids)).values('id')
        for item in menus_id:
            data.append(item['id'])
        return JsonResponse(data={'list':data, 'count':len(data)}, code='999999', msg='成功')

    @TokenVerify
    def post(self, request):
        print('post')
        role_id = request.data.get('role_id')
        menu_ids = request.data.get('menu_id')
        print(role_id)
        print(menu_ids)
        for item in Permission.objects.filter(role_id=role_id):
            item.delete()
        menus = Menu.objects.filter(id__in = list(menu_ids))
        for menu in menus:
            Permission.objects.create(role_id=role_id, function_id=menu.permission.id)
        return JsonResponse(data={}, code='999999', msg = '成功')

class RolePermission(APIView):

    @TokenVerify
    def post(self, request):
        role_id = request.data.get('role_id')
        menu_ids = request.data.get('menu_id')
        for item in Permission.objects.filter(role_id=role_id):
            item.delete()
        menus = Menu.objects.filter(id__in = list(menu_ids))
        for menu in menus:
            Permission.objects.create(role_id=role_id, function_id=menu.permission.id)
        return JsonResponse(data={}, code='999999', msg = '成功')


role_manage = RoleApi.as_view()
role_of_user = RoleOfUser.as_view()
role_of_menu = RoleOfMenu.as_view()
role_of_menu_save = RolePermission.as_view()

