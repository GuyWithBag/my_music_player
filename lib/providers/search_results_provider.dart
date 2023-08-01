
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/audio_player.dart';
import 'providers.dart';

class SearchResultsProvider extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController(); 
  List<Song> foundSongs = []; 
  List<SongPlaylist> foundPlaylists = []; 

  void updateNotifier() {
    notifyListeners(); 
  }

  void searchSongs(BuildContext context, String value) {
    final AllSongsProvider allSongsProvider = context.read<AllSongsProvider>(); 
    foundSongs = allSongsProvider.getSearchedItemsByName(value); 
    notifyListeners(); 
  }

  void searchPlaylists(BuildContext context, String value) {
    final SongPlaylistProvider songPlaylistProvider = context.read<SongPlaylistProvider>(); 
    foundPlaylists = songPlaylistProvider.getSearchedItemsByName(value); 
    notifyListeners(); 
  }

  void clearTextField() {
    textEditingController.clear(); 
    notifyListeners(); 
  }
}