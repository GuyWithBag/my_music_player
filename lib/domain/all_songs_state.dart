import 'package:flutter/material.dart';
import 'dart:io';
import 'package:collection/collection.dart';
import 'domain.dart'; 

// Implevent Hive here
class AllSongsState extends SongsState{

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
    if (const DeepCollectionEquality.unordered().equals(allSongs, newSongs) == false) {
      setSongs(newSongs); 
      return; 
    }
  }
}







