from django.contrib import admin

# Register your models here.
from apps.users.models import Stream
admin.site.register(Stream)