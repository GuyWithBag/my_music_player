import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import 'package:my_music_player/theme/theme_constants.dart';
import 'package:provider/provider.dart';

import '../../../widgets/widgets.dart';

class SearchResultsSeeMorePage extends StatelessWidget {
  const SearchResultsSeeMorePage({
    super.key
  }); 

  Widget _whichTile(List<HasNameObject> object, {int? index}) {
    index ??= 0; 
    switch (object.runtimeType) { 
      case const (List<SongPlaylist>): 
        return SongPlaylistTile(
          songPlaylist: (object as List<SongPlaylist>)[index], 
          playlistIndex: index,
        );
      case const (List<Song>): 
        return AllSongsTile(
          songs: (object as List<Song>), 
          songIndex: index, 
        ); 
    }
    return const SizedBox(); 
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( 
      create: (_) => LocalProvider(),
      child: Builder(
        builder: (context) {
          LocalProvider localProvider = context.watch<LocalProvider>(); 
          final List<HasNameObject> results = localProvider.arguments.results;  
          return Scaffold(
            appBar: AppBar(
              title: Text(results.length > 1 ? "${results.length} results found" : "1 result found"),
            ), 
            body: SizedBox.expand(
              child: Container(
                decoration: backgroundDecoration, 
                child: ListView(
                  children: [
                    for (HasNameObject object in results) 
                      _whichTile(
                        results, 
                        index: results.indexOf(object), 
                      )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class LocalProvider extends ChangeNotifier {
  SearchResultsSeeMoreArguments arguments = SearchResultsSeeMoreArguments([]); 

  LocalProvider() {
    arguments = Get.arguments; 
    notifyListeners(); 
  }

}