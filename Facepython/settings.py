"""
Django settings for Facepython project.

Generated by 'django-admin startproject' using Django 1.11.3.

For more information on this file, see
https://docs.djangoproject.com/en/1.11/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.11/ref/settings/
"""

import os
import sys
from celery.schedules import crontab
from celery.schedules import timedelta
# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
print(BASE_DIR)
sys.path.insert(0,BASE_DIR)
sys.path.insert(0,os.path.join(BASE_DIR,'apps'))
sys.path.insert(0,os.path.join(BASE_DIR,'extra_apps'))

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.11/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '6+2ro69sh_^2=(g@xlm@!=jc#j@fj!^&t=-rq0$kyf75_e8%zl'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

#ALLOWED_HOSTS = ['localhost', '127.0.0.1', '192.17.1.*', '192.17.1.150']
#ALLOWED_HOSTS = ['localhost', '127.0.0.1', '192.168.1.14', '192.168.1.*']
ALLOWED_HOSTS = ['localhost','127.0.0.1', '*']
AUTH_PROFILE_MODEL = 'users.UserProfile'

#FACE_IMG_CHECK_ROOT_URL = 'http://10.2.151.139:8888'
#FACE_IMG_ROOT_URL = "http://10.2.151.139:8888/media/"
# Application definition
##FACE_IMG_CHECK_ROOT_URL = 'http://10.2.155.139:8888'
##FACE_IMG_ROOT_URL = "http://10.2.155.139:8888/media/"

#FACE_IMG_CHECK_ROOT_URL = 'http://172.16.3.101:8888'
#FACE_IMG_ROOT_URL = "http://172.16.3.101:8888/media/"

#FACE_IMG_CHECK_ROOT_URL = 'http://10.2.155.139:8888'
#FACE_IMG_ROOT_URL = "http://10.2.155.139:8888/media/"
#RECORD_ROOT_URL = 'http://10.2.155.139:8888/record_media/'
CONF_FILE = '/home/face_detect/base.conf'
CAMERA_RECORD_BASE_URL = '/opt/h5ss/www/mediastore/record/'



#FACE_IMG_CHECK_ROOT_URL = 'http://172.14.40.60:8888'
#FACE_IMG_ROOT_URL = "http://172.14.40.60:8888/media/"
#RECORD_ROOT_URL = 'http://172.14.40.60:8888/record_media/'
#CENTOS_IP_ROOT = 'http://172.14.40.60:8888'

FACE_IMG_CHECK_ROOT_URL = 'http://221.231.13.230:8888'
FACE_IMG_ROOT_URL = "http://221.231.13.230:8888/media/"
FACE_IMG_REAL_ROOT_URL = "http://221.231.13.230:8888/record_video"
RECORD_ROOT_URL = 'http://221.231.13.230:8888/record_media/'
LOCAL_VIDEO_URL = "/mnt/public/media"
CENTOS_IP_ROOT = 'http://172.16.3.101:8888'

#隔离管控
RECORD_IMG = "http://172.16.3.109:8888/static/person"
LOCAL_IMG = '/home/images'
# Application definition
INSTALLED_APPS = [
    'channels',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'djcelery',
    'users.apps.UsersConfig',
    'corsheaders',
    'rest_framework',
    'apps',
    'rest_framework.authtoken',
    'captcha'
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
   # 'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'Facepython.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'dist')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'Facepython.wsgi.application'
ASGI_APPLICATION = 'Facepython.routing.application'

CHANNEL_LAYERS = {
        'default': {
                'BACKEND': 'channels_redis.core.RedisChannelLayer',
                'CONFIG': {
                        "hosts": [('127.0.0.1', 6379)], #需修改
                },
        },
}

# redis配置
CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379/3",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
            "CONNECTION_POOL_KWARGS": {"max_connections": 300}
            # "PASSWORD": "123",
        }
    }
}

# Database
# https://docs.djangoproject.com/en/1.11/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'talent',
        'USER': 'root',
        'PASSWORD': '123cpucpu',
        'HOST': '127.0.0.1',
        'PORT': '3306',
        'OPTIONS': { 'init_command': 'SET default_storage_engine=INNODB; SET sql_mode= STRICT_TRANS_TABLES; ' }
    }
}

# Password validation
# https://docs.djangoproject.com/en/1.11/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/1.11/topics/i18n/

#LANGUAGE_CODE = 'en-us'
LANGUAGE_CODE = 'zh-Hans'

#TIME_ZONE = 'UTC'
TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

#USE_TZ = True
#解决数据库时间与网页时间不一致的问题
USE_TZ = False


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.11/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = '/var/www/smartcore/static/'
MEDIA_ROOT = '/var/www/smartcore/media/'
MEDIA_URL = '/media/'

STATICFILES_DIRS = [
    os.path.join(BASE_DIR, "dist/static"),
    os.path.join(BASE_DIR, "dist/"),
]

# 跨域忽略
CORS_ALLOW_CREDENTIALS = True
CORS_ORIGIN_ALLOW_ALL = True
CORS_ORIGIN_WHITELIST = ( '*' )

CORS_ALLOW_METHODS = (
    'DELETE',
    'GET',
    'OPTIONS',
    'PATCH',
    'POST',
    'PUT',
    'VIEW',
)

CORS_ALLOW_HEADERS = (
    'XMLHttpRequest',
    'X_FILENAME',
    'accept-encoding',
    'authorization',
    'content-type',
    'dnt',
    'origin',
    'user-agent',
    'x-csrftoken',
    'x-requested-with',
    'Pragma',
)

REST_FRAMEWORK = {
    'DEFAULT_PERMISSION_CLASSES': (
        #'rest_framework.permissions.IsAuthenticated',
    ),
    'DEFAULT_AUTHENTICATION_CLASSES': (
        #'rest_framework_jwt.authentication.JSONWebTokenAuthentication',
        'rest_framework.authentication.TokenAuthentication',
    ),
    'DEFAULT_PAGINATION_CLASS': (
        'rest_framework.pagination.PageNumberPagination',
    ),
    'EXCEPTION_HANDLER': (
        #'api_test.common.common.custom_exception_handler'
        # 'EXCEPTION_HANDLER': 'my_project.my_app.utils.custom_exception_handler'
    )
}

# 字母验证码
CAPTCHA_IMAGE_SIZE = (126, 38)  # 设置 captcha 图片大小
CAPTCHA_LENGTH = 4  # 字符个数
CAPTCHA_TIMEOUT = 1  # 超时(minutes)
CAPTCHA_FONT_SIZE = 30 #设置字母字体大小

CAPTCHA_BACKGROUND_COLOR = '#FFFAFA'#验证码背景颜色
CAPTCHA_FOREGROUND_COLOR = '#0000FF'#验证码字体颜色

import djcelery
djcelery.setup_loader()
CELERYBEAT_SCHEDULER = 'djcelery.schedulers.DatabaseScheduler'
BROKER_URL = 'redis://127.0.0.1:6379/'
CELERY_IMPORTS= ('apps.users.tasks')
CELERYD_CONCURRENCY = 5
CELERY_TIMEZONE = 'Asia/Shanghai'

CELERYBEAT_SCHEDULE = { #定时器策略
    'celery_test': {
        "task":"apps.users.tasks.hello_world",
        "schedule": timedelta(seconds=30),
        "args":(),
    },
}
