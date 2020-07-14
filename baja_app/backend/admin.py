from django.contrib import admin
from .models import Song, Artist, Album, PlayList


admin.site.register(Artist)
admin.site.register(Album)
admin.site.register(Song)
admin.site.register(PlayList)
