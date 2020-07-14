from django.urls import include, path
from rest_framework import routers
from . import views



song_router = routers.DefaultRouter()
song_router.register(r'songs', views.SongViewSet)

artist_router = routers.DefaultRouter()
artist_router.register(r'artists', views.ArtistViewSet)

album_router = routers.DefaultRouter()
album_router.register(r'albums', views.AlbumViewSet)

playlist_router = routers.DefaultRouter()
playlist_router.register(r'playlists', views.PlayListViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('songs/', include(song_router.urls)),
    path('api-home/', views.api_home, name='api-home'),
    path('artists/', include(artist_router.urls)),
    path('albums/', include(album_router.urls)),
    path('playlists/', include(playlist_router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]