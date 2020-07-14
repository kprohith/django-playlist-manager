from rest_framework import serializers
from django.contrib import admin
from .models import Song, Artist, Album, PlayList


class SongSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Song
        fields = ('title', 'artists', 'album', 'id')
    
class ArtistSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Artist
        fields = ('name', 'id')
    

class AlbumSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Album
        fields = ('title', 'artist','id')

class PlayListSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = PlayList
        fields = ('name','creator', 'songs', 'date_created', 'last_modified', 'id')
    