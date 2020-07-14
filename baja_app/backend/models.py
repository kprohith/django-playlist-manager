from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User
from django.urls import reverse


class Artist(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)

    def __str__(self):

        return self.name


class Album(models.Model):
    title = models.CharField(max_length=50)
    id = models.AutoField(primary_key=True)
    artist = models.ForeignKey(Artist, on_delete=models.CASCADE)


    def __str__(self):

        return self.title


class Song(models.Model):
    title = models.CharField(max_length=50)
    artists = models.ManyToManyField(Artist)
    album = models.ForeignKey(Album, on_delete=models.PROTECT)
    id = models.AutoField(primary_key=True)
   # year = models.DateTimeField(default=timezone.now)
   # duration = models.DurationField(default=0)

    def __str__(self):
        return self.title

    def get_year(self):
        return self.year.year




class PlayList(models.Model):
    name = models.CharField(max_length=50)
    id = models.AutoField(primary_key=True)
   # count = models.IntegerField(default=0)
   # duration = models.DurationField()
    songs = models.ManyToManyField(Song)
    date_created = models.DateTimeField(default=timezone.now)
    last_modified = models.DateTimeField(auto_now=True)
    creator = models.ForeignKey(User, on_delete=models.CASCADE)


    def __str__(self):

        return self.name