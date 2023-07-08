import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'domain.dart';

void onReOrderUpdateList(int oldIndex, int newIndex, Function(int) removeItemAt, Function insertItemAt) {
  if (oldIndex < newIndex) {
    newIndex--;
  }
  final song = removeItemAt(oldIndex); 
  insertItemAt(newIndex, song); 
}

Widget getSongAlbumArt(Metadata? metadata) {
  if ( metadata != null) {
    Uint8List? albumArt = metadata.albumArt; 
    if (albumArt == null) {
      return const Icon(Icons.music_note); 
    }
    return Image.memory(albumArt); 
  } else {
    return const Icon(Icons.music_note); 
  }
}

abstract class SongsProvider extends ChangeNotifier {
  List<Song> allSongs = []; 

  void addSongs(List<Song> songs) {
    allSongs.addAll(songs); 
    notifyListeners(); 
  }

  void setSongs(List<Song> songs) {
    allSongs = songs; 
    notifyListeners(); 
  }

  void addSong(Song song) {
    allSongs.add(song); 
    notifyListeners(); 
  }

  void clearSongs() {
    allSongs.clear(); 
    notifyListeners(); 
  }

  Song removeSongAt(int index) {
    Song song = allSongs.removeAt(index); 
    notifyListeners(); 
    return song; 
  }

  void insertSongAt(int index, Song song) {
    allSongs.insert(index, song); 
    notifyListeners(); 
  }

  List<Song> getSearchedSongs(String searchValue) {
    List<Song> songs = []; 
    if (searchValue.isEmpty) {
      return songs; 
    }
    for (Song song in allSongs) {
      if (song.name.contains(searchValue)) {
        songs.add(song); 
      }
    }
    return songs; 
  }

  void removeSong(Song song) {
    allSongs.remove(song); 
    notifyListeners(); 
  }

}
