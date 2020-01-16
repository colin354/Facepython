from rest_framework.authtoken.serializers import AuthTokenSerializer
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from rest_framework import serializers
from users.serializers import TokenSerializer
from users.serializers import RoleSerializer
from users.serializers import FunctionInterfaceSerializer
from users.serializers import UserSerializer
from users.serializers import UserExtraInfoSerializer
from users.serializers import InterfaceSerializer
from users.common.api_response import JsonResponse
from django.core.exceptions import ObjectDoesNotExist
from django.contrib.auth.models import User
from apps.users.models import UserExtraInfo
from apps.users.utility import TokenVerify
from apps.users.serializers import LoginRecordSerializer
from django.contrib.auth import password_validation
from apps.users.models import RoleUser
from apps.users.models import Role
from apps.users.models import Permission
from apps.users.models import Interface
from apps.users.models import Menu
from apps.users.models import Route
from apps.users.models import RoleUser
from collections import defaultdict
from rest_framework import status
import pdb
#import random

from captcha.models import CaptchaStore
from captcha.helpers import captcha_image_url
from captcha.models import CaptchaStore

#from django.http import HttpResponse

def captcha():
    hashkey = CaptchaStore.generate_key()   #验证码答案
    image_url = captcha_image_url(hashkey)  #验证码地址
    captcha_data = {'hashkey': hashkey, 'image_url': image_url}
    #local_imag_url = "http://127.0.0.1:8000"+image_url
    return(captcha_data)
    #return local_imag_url

def jarge_captcha(captchaStr, captchaHashkey):
    if captchaStr and captchaHashkey:
        try:
            # 获取根据hashkey获取数据库中的response值
            get_captcha = CaptchaStore.objects.get(hashkey=captchaHashkey)
            # 如果验证码匹配
            if get_captcha.response == captchaStr.lower():
                return True
        except:
            return False
    else:
        return False

class ObtainAuthToken(APIView):
    serializer_class = AuthTokenSerializer

    def get(self, request):
        return JsonResponse(data={}, code="999999", msg="成功")

    def post(self, request, *args, **kwargs):
        login_list = {}
        login_list['login_username'] = request.data['username']
        login_list['login_op'] = '登录'
        login_list['login_ip'] = request.META['REMOTE_ADDR']
        login_list['login_useragent'] = request.META['HTTP_USER_AGENT']
        uuid = request.data.get('uuid','')
        captcha = request.data.get('captcha','')
        captcha_up = captcha.upper()
        get_challenge = CaptchaStore.objects.get(hashkey = uuid['hashkey']).challenge
        if captcha_up != get_challenge:
            login_list['login_status'] = 0
            data = "error"
            login_serializer = LoginRecordSerializer(data=login_list)
            if login_serializer.is_valid():
                login_serializer.save()
            return JsonResponse(data=data, code="1", msg="验证码出错")

        login_list['login_status'] = 1
        login_serializer = LoginRecordSerializer(data=login_list)
        if login_serializer.is_valid():
            login_serializer.save()
        serializer = self.serializer_class(data=request.data,context={"request": request})
        ret = serializer.is_valid()
        if(ret == False):
            return JsonResponse(data={str(serializer.errors)+"用户名密码错误"}, code='999999', msg='失败', status=status.HTTP_400_BAD_REQUEST)
        user = serializer.validated_data["user"]
        data = TokenSerializer(Token.objects.get(user=user)).data
        # pdb.set_trace()
        return JsonResponse(data=data, code="999999", msg="成功")

class UserRoleApi(APIView):

    @TokenVerify
    def get(self, request, format=None):
        data = []
        roleusers = RoleUser.objects.all().order_by('user_id')
        for item in roleusers:
            user_data = UserSerializer(item.user).data
            role_data = RoleSerializer(item.role).data
            data.append({**user_data, **role_data})
        return JsonResponse(data={'list':data, 'count':len(data)}, code="999999", msg="成功")

    @TokenVerify
    def put(self, request):
        user_id = request.data.get('user_id')
        role_id = request.data.get('role_id')
        if(user_id is None or user_id == ""):
            return JsonResponse(data={}, code="999999", msg="失败 缺少user_id")
        if(role_id is None or role_id == ""):
            return JsonResponse(data={}, code="999999", msg="失败 缺少role_id")
        RoleUser.objects.create(user_id = user_id, role_id=role_id)
        return JsonResponse(data={}, code="999999", msg="成功")

    @TokenVerify
    def delete(self, request):
        user_id = request.data.get('user_id')
        role_id = request.data.get('role_id')
        if(user_id is None or user_id == ""):
            return JsonResponse(data={}, code="999999", msg="失败 缺少user_id")
        if(role_id is None or role_id == ""):
            return JsonResponse(data={}, code="999999", msg="失败 缺少role_id")
        RoleUser.objects.get(user_id = user_id, role_id=role_id).delete()
        return JsonResponse(data={}, code="999999", msg="成功")

class UserProfile(APIView):

    @TokenVerify
    def get(self, request):
        token = request.META.get('HTTP_AUTHORIZATION')
        if(token is not None):
            user_id = Token.objects.get(key=token).user_id
            data = {}
            data = self.find_user(user_id)
            print("access menu", data['accessMenus'])
            return JsonResponse(data=data, code='999999', msg='成功')
        return JsonResponse(data={}, code='999999', msg='error')

    def find_user(self, user_id):
        username = User.objects.get(id=user_id).username
        isAdmin = User.objects.get(id=user_id).is_superuser
        try:
            RoleUser.objects.get(user_id=user_id, role_id = 1)
            isAdmin = True
        except Exception as e:
            isAdmin = False
        data = {}
        data['userName'] = username
        ### 处理userroles
        data['userRoles'] = []
        roleids = RoleUser.objects.filter(user_id=user_id)
        for item in roleids:
            data['userRoles'].append(item.role.code)
        ### 处理permissions
        data['userPermissions'] = []
        tmp = set()
        interface_ids = set()
        function_ids = set()
        for roleid in roleids:
            for item in Permission.objects.filter(role_id = roleid.role.id):
                tmp.add(item.function.name)
                interface_ids.add(item.function.interface_id)
                function_ids.add(item.function.id)
        data['userPermissions'] = list(tmp)
        ### 处理interfaces
        data['accessInterfaces'] = []
        interfaces = []
        for item in list(Interface.objects.in_bulk(interface_ids).values()):
            interfaces.append({"path":item.path, "method":item.method})
        data['accessInterfaces'] = interfaces
        ### 处理 Menus
        data['accessMenus'] = []
        tmp = []
        parent = defaultdict(dict)
        filter_menus = Menu.objects.filter(permission__in = list(function_ids))
        filter_menus = sorted(filter_menus, key=lambda x:x.sort*10+x.index)
        for item in filter_menus:
            if(item.sort == 1):
                tmp.append({"title":item.title, "path":item.path, "icon":item.icon})
                parent[str(item.id)] = tmp[-1]
            else:
                if(parent[str(item.parent_id)].get('children') is None):
                    parent[str(item.parent_id)]['children']=[]
                parent[str(item.parent_id)]["children"].append({"title":item.title, "path":item.path,"icon":item.icon})
                parent[str(item.id)] = parent[str(item.parent_id)]["children"][-1]
        data['accessMenus'] = tmp
        ### 处理accessRoutes
        tmp = []
        data["accessRoutes"] = []
        parent = defaultdict(dict)
        filter_routes = Route.objects.filter(permission__in=list(function_ids)).order_by('sort')
        for item in filter_routes:
            if(item.sort == 1):
                tmp.append({"name":item.name, \
                        "path":item.path, \
                        "component":item.component,\
                        "componentPath":item.componentPath,\
                        "meta":{"title":item.title, "cache":True},\
                        })
                parent[str(item.id)] = tmp[-1]
            else:
                if(parent[str(item.parent_id)].get('children') is None):
                    parent[str(item.parent_id)]['children']=[]
                parent[str(item.parent_id)]['children'].append({"name":item.name,\
                        "path":item.path,\
                        "component":item.component,\
                        "componentPath":item.componentPath,\
                        "meta":{"title":item.title, "cache":True},\
                        "children":[]})
                parent[str(item.id)] = parent[str(item.parent_id)]['children'][-1]
        data['accessRoutes'] = tmp
        data['isAdmin'] = isAdmin
        return data

# 用户管理

class UserApi(APIView):
    #TOKEN = 'token'

    @TokenVerify
    def get(self, request, format=None):
        username = request.GET.get('username')
        data = []
        filter_users = []
        if(username is not None):
            filter_users = User.objects.filter(username__contains=username)
        else:
            filter_users = User.objects.all()
        for item in filter_users:
            temp = UserSerializer(item).data
            if(item.userextrainfo_set.count()==1):
                temp = {**temp, **(UserExtraInfoSerializer(item.userextrainfo_set.all()[0]).data)}
            else:
                temp['real_name'] = ""
                temp['gender'] = ""
                temp['phone'] = ""
            if(item.roleuser_set.count() == 1):
                temp['role_name'] = item.roleuser_set.all()[0].role.name
            else:
                temp['role_name'] = ""
            data.append(temp)
        return JsonResponse(data={'list':data, 'count':len(data)}, code='999999', msg='成功')

    @TokenVerify
    def delete(self, request):
        path = request.path
        user_id = -1
        try:
            user_id = int(path.split('/')[-1])
        except Exception as e:
            return JsonResponse(data={"url路径错误"}, code='999999', msg='失败')
        try:
            user = User.objects.get(pk=user_id)
            user.delete()
        except Exception as e:
            return JsonResponse(data={"user不存在"}, code='999999', msg='失败')
        return JsonResponse(data={}, code='999999', msg='成功')

    @TokenVerify
    def put(self, request):
        path = request.path
        user_id = -1
        try:
            user_id = int(path.split('/')[-1])
        except Exception as e:
            return JsonResponse(data={"url路径错误"}, code='999999', msg='失败')
        username = request.data.get('username')
        password = request.data.get('password')
        real_name = request.data.get('real_name')
        email = request.data.get('email')
        gender = request.data.get('gender')
        phone = request.data.get('phone')
        role_id = request.data.get('role_id')
        tstatus = request.data.get('is_active')
        try:
            print('-----------------')
            user = User.objects.get(pk=user_id)
            user_extra_info = user.userextrainfo_set.get(user_id=user_id)
            roleuser = user.roleuser_set.get(user_id=user_id)
            if(username is not None and username != ""):
                user.username = username
            if(email is not None and email != ""):
                user.email = email
            if(phone is not None and phone != ""):
                user_extra_info.phone = phone
            if(gender is not None and gender != ""):
                user_extra_info.gender = gender
            if(real_name is not None and real_name != ""):
                user_extra_info.real_name = real_name
            if(role_id is not None):
                roleuser.role_id = role_id
            user.save()
            print('-----------------cur')
            password_validation.password_changed(password, user=user)
            user_extra_info.save()
            roleuser.save()
        except Exception as e:
            return JsonResponse(data={"user不存在"}, code='999999', msg='失败', status=status.HTTP_400_BAD_REQUEST)
        return JsonResponse(data={}, code='999999', msg='成功')


    @TokenVerify
    def post(self, request, *args, **kwargs):
        username = request.data.get('username')
        password = request.data.get('password')
        real_name = request.data.get('real_name')
        email = request.data.get('email')
        gender = request.data.get('gender')
        phone = request.data.get('phone')
        role_id = request.data.get('role_id')
        tstatus = request.data.get('is_active')
        if(tstatus == None):
            tstatus = True
        try:
            # create_user
            user = User.objects.create_user(username=username, password=password, is_active=tstatus, email=email)
            # creat_extra
            UserExtraInfo.objects.create(user=user, real_name = real_name, phone=phone,gender=gender)
            if(role_id != None and role_id != []):
                # bind role
                for item in role_id:
                    RoleUser.objects.create(user=user,role_id=item)
            else:
                RoleUser.objects.create(user=user,role=Role.objects.get(name="普通用户"))
        except Exception as err:
            print(err)
            return JsonResponse(data={'失败'}, code='999999', msg='失败', status=status.HTTP_400_BAD_REQUEST)
        return JsonResponse(data={}, code='999999', msg='成功')

class verificationcode(APIView):
    def get(self ,request , *args,**kwargs):
        return JsonResponse(captcha() , code = '0', msg = '验证码' , content_type='application/json')

class UserOfRole(APIView):

    @TokenVerify
    def get(self, request):
        path = request.path
        user_id = -1
        try:
            user_id = int(path.split('/')[-1])
        except Exception as e:
            return JsonResponse(data={"url路径错误"}, code='999999', msg='失败')
        origin_data = {}
        if(user_id is not None and user_id != ""):
            filter_role = Role.objects.all()
            for item in filter_role:
                temp = {}
                temp = RoleSerializer(item).data
                temp['interface'] = []
                temp['interface'] = InterfaceSerializer(list(map(lambda x:x.function.interface, item.permission_set.all())), many=True).data
                temp['isAdd'] = False
                origin_data[item.id] = temp
            filter_user_role = RoleUser.objects.filter(user_id=user_id)
            for item in filter_user_role:
                origin_data[item.role_id]['isAdd'] = True
            data = origin_data.values()
            return JsonResponse(data=data, code='999999', msg='成功')
        data = RoleSerializer(Role.objects.all(), many=True).data
        return JsonResponse(data={'list':data, 'count':len(data)}, code='999999', msg='成功')

verification_code = verificationcode.as_view()
obtain_auth_token = ObtainAuthToken.as_view()
user_profile = UserProfile.as_view()
user_manage = UserApi.as_view()
user_role_manage = UserRoleApi.as_view()
user_of_role = UserOfRole.as_view()
