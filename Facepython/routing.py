from channels.auth import AuthMiddlewareStack
from channels.routing import ProtocolTypeRouter, URLRouter
import apps.users.routing

application = ProtocolTypeRouter({
    'websocket': AuthMiddlewareStack(
         URLRouter (
             apps.users.routing.websocket_urlpatterns
         )
)
})

