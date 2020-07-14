from django.urls import path
from . import views
from .views import SongAddView, PlayListListView, PlayListDetailView, PlayListCreateView, PlayListUpdateView, PlayListDeleteView, UserPlayListListView

urlpatterns = [
    path('', views.home, name='backend-home'),
    path('about/', views.about, name='backend-about'),
    path('user/<str:username>', UserPlayListListView.as_view(), name='user-playlists'),
    path('playlist/<int:pk>/', PlayListDetailView.as_view(), name='playlist-detail'),
    path('playlist/new/', PlayListCreateView.as_view(), name='backend-create-playlist'),
    path('playlist/<int:pk>/update', PlayListUpdateView.as_view(), name='backend-update-playlist'),
    path('song/new', SongAddView.as_view(), name='add-song'),
]
