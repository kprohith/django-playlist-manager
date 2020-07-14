from django.shortcuts import render
from .models import Song, Artist, Album, PlayList
from django.shortcuts import render, get_object_or_404
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.contrib.auth.models import User
from django.views.generic import (ListView,
                                  DetailView,
                                  CreateView,
                                  UpdateView,
                                  DeleteView
)
# songs = [
#     {
#         'artists': 'RKP',
#         'album': 'One',
#         'song_title': 'First',
#         'song_dest': '',
#         'metadata': '',
#         'date_published': 'August 27, 2020',
#         'track_number': '1',
#         'id': '1',
#         'duration': '2300',
#         'href': '',
#     },
#    {
#         'artists': 'RKP',
#         'album': 'One',
#         'song_title': 'Second',
#         'song_dest': '',
#         'metadata': '',
#         'date_published': 'August 27, 2020',
#         'track_number': '2',
#         'id': '2',
#         'duration': '1234',
#         'href': '',        
#     },
#     {
#         'artists': 'RKP',
#         'album': 'Two',
#         'song_title': 'Third',
#         'song_dest': '',
#         'metadata': '',
#         'date_published': 'August 30, 2020',
#         'track_number': '1',
#         'id': '3',
#         'duration': '2222',
#         'href': '',
#     },
#     {
#         'artists': 'RKP',
#         'album': 'Two',
#         'song_title': 'Fourth',
#         'song_dest': '',
#         'metadata': '',
#         'date_published': 'August 30, 2020',
#         'track_number': '2',
#         'id': '4',
#         'duration': '2123',
#         'href': '',
#     },
#     {
#         'artists': 'Jane Doe',
#         'album': 'Fire',
#         'song_title': 'Warmth',
#         'date_published': 'June 27, 2020',
#         'track_number': '1',
#         'id': '5',
#         'duration': '212',
#         'href': '',        
#     },
# ]
def home(request):
    context = {
        'songs': Song.objects.all()
    }
    return render(request, 'backend/home.html', context)

def about(request):
    return render(request, 'backend/about.html', {'title': 'About'})

# def create_playlist(request):


#     return render(request, 'backend/add-playlist.html', {'title': 'Create Playlist'})


# def manage_playlist(request):


#     return render(request, 'backend/manage-playlist.html', {'title': 'Manage Playlist'})

# def add_songs(request):
    
#     return render(request, 'backend/add-songs.html', {'title': 'Add Songs'})

class SongListView(ListView):
    model = Song
    template_name = 'backend/song-list.html'
    context_object_name = 'songs'
    paginate_by = 10

class PlayListListView(ListView):
    model = PlayList
    template_name = 'backend/playlist-list.html'
    context_object_name = 'playlists'
    paginate_by = 10

class UserPlayListListView(ListView):
    model = PlayList
    template_name = 'backend/user_playlist-list.html'
    context_object_name = 'playlists'
    ordering = ['-date_created']
    paginate_by = 10


    def get_queryset(self):
        user = get_object_or_404(User, username=self.kwargs.get('username'))
        
        return PlayList.objects.filter(creator=user).order_by('-date_created')

class SongAddView(LoginRequiredMixin, CreateView):
    model = Song
    fields = ['title', 'artists', 'album']

    def form_valid(self, form):
        form.instance.creator = self.request.user
        return super().form_valid(form)

class PlayListDetailView(DetailView):
    model = PlayList

class PlayListCreateView(LoginRequiredMixin, CreateView):
    model = PlayList
    fields = ['name', 'songs']

    def form_valid(self, form):
        form.instance.creator = self.request.user
        return super().form_valid(form)


class PlayListUpdateView(LoginRequiredMixin, UserPassesTestMixin, UpdateView):
    model = PlayList
    fields = ['name', 'songs']

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)
    
    def test_func(self):
        playlist = self.get_object()
        if self.request.user == playlist.creator:
            return True
        return False

class PlayListDeleteView(LoginRequiredMixin, UserPassesTestMixin, DeleteView):
    model = PlayList
    success_url = '/'

    def test_func(self):
        playlist = self.get_object()
        if self.request.user == playlist.author:
            return True
        return False