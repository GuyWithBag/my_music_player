import 'package:flutter/material.dart';
import 'dart:io';
import 'package:collection/collection.dart'; 

import 'domain.dart'; 

// Implevent Hive here
class AllSongsState extends ChangeNotifier {
  List<Song> allSongs = []; 

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
    if (const DeepCollectionEquality.unordered().equals(allSongs, newSongs) == false) {
      clearSongs(); 
      addSongs(newSongs); 
      return; 
    }
  }

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

}