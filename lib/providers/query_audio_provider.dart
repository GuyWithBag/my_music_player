
import 'package:my_music_player/providers/providers.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../domain/domain.dart';

class QueryAudioProvider extends ItemListProvider<Song> { 

  bool searchingForSongs = false; 

  void querySongs() async {
    searchingForSongs = true; 
    notifyListeners(); 
    List<SongModel> queriedSongs = await OnAudioQuery().querySongs(); 
    List<Song> songs = []; 
    
    for (SongModel queriedSong in queriedSongs) { 
      // print(queriedSong.data); 
      Song song = Song(queriedSong.data); 
      song.duration = Duration(milliseconds: queriedSong.duration!); 
      songs.add(song); 
    } 
    items.addAll(songs); 
    searchingForSongs = false; 
    notifyListeners(); 
    
  }

}
