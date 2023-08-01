import 'dart:io';
import 'package:collection/collection.dart';
import 'package:my_music_player/providers/providers.dart';
import '../domain/domain.dart'; 

// All the songs that the app has found are stored here. 
// All the songs that will be played will be in SongQueuState 
// AudioPlayerProvider is where the songs should be played. 
class AllSongsProvider extends ItemListProvider<Song> with SearchItem<Song> {
  static final List<Song> placeholderSongs = [
    for (int i = 0; i < 5; i++ ) Song("assets/audio/thewayifeel.mp3"),
  ]; 

  static final List<SongPlaylist> placeholderPlaylists = [
    for (int i = 0; i < 5; i++ ) SongPlaylist(songs: placeholderSongs), 
  ]; 

  void pickFolderAndAddSongs() async {
    Directory? dir = await pickFolderDirectory(); 
    if (dir == null) { 
      return; 
    }
    List<Song> newSongs = getSongsFromDirectory(dir); 
    // TEST
    sortSongsAlphabetically(newSongs); 
    if (const DeepCollectionEquality.unordered().equals(items, newSongs) == false) {
      setItems(newSongs); 
      return; 
    }
  }
}








