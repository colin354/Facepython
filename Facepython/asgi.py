import os
import django
import sys
from channels.routing import get_default_application
 
#sys.append('/home/lc/temporary')
#sys.append('/home/lc/temporary/temporary')
os.environ.setdefault("DJANGO_SETTINGS_MODULE","Facepython.settings")
django.setup()
application = get_default_application()

