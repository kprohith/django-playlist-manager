from django.shortcuts import render
from rest_framework import viewsets
from backend.serializers import SongSerializer, ArtistSerializer, AlbumSerializer, PlayListSerializer
from backend.models import Song, Artist, PlayList, Album

class SongViewSet(viewsets.ModelViewSet):
    queryset = Song.objects.all().order_by('title')
    serializer_class = SongSerializer

class ArtistViewSet(viewsets.ModelViewSet):
    queryset = Artist.objects.all().order_by('name')
    serializer_class = ArtistSerializer

class AlbumViewSet(viewsets.ModelViewSet):
    queryset = Album.objects.all().order_by('title')
    serializer_class = SongSerializer

class PlayListViewSet(viewsets.ModelViewSet):
    queryset = PlayList.objects.all().order_by('name')
    serializer_class = PlayListSerializer

def api_home(request):
    return render(request, 'baja_api/api_home.html', {'title': 'About'})