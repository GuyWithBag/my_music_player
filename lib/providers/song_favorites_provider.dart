import 'package:my_music_player/providers/providers.dart';

import '../domain/domain.dart';

class SongFavoritesProvider extends ItemListProvider<Song>{ 

  void addFavorite(Song song) { 
    if (items.contains(song)) {
      return; 
    }
    addItem(song); 
    notifyListeners(); 
  } 
}

