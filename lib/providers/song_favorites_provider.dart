import 'package:flutter/material.dart';
import '../domain/domain.dart';

class SongFavoritesProvider extends SongsProvider{ 

  void addFavoriteSong(Song song) { 
    if (songIsInFavorites(song)) {
      return; 
    }
    addSong(song); 
    notifyListeners(); 
  } 

  bool songIsInFavorites(Song? song) {
    return allSongs.contains(song); 
  }
}

