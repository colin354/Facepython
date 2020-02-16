from django.contrib import admin

# Register your models here.
from apps.users.models import Stream,Camera
admin.site.register(Camera)
