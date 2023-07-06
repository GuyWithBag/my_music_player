import 'package:flutter/material.dart';
import 'domain.dart';

void onReOrderUpdateList(int oldIndex, int newIndex, Function(int) removeItemAt, Function insertItemAt) {
  if (oldIndex < newIndex) {
    newIndex--;
  }
  final song = removeItemAt(oldIndex); 
  insertItemAt(newIndex, song); 
}

abstract class SongsState extends ChangeNotifier {
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
}