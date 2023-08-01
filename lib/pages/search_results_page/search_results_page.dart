import 'package:flutter/material.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import 'package:my_music_player/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchResultsProvider(),
      child: Builder(
        builder: (BuildContext context) {
          final SearchResultsProvider searchResultsProvider = context.watch<SearchResultsProvider>(); 
          final TextEditingController textEditingController = searchResultsProvider.textEditingController;
          return Scaffold(
            appBar: AppBar(
              actions: [
                MySearchBar(
                  textFormField: TextFormField(
                    onChanged: (String value) { 
                      searchResultsProvider.searchSongs(context, value); 
                      searchResultsProvider.searchPlaylists(context, value); 
                    }, 
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(), 
                      labelText: "Search here: "
                    ), 
                  ),
                  textEditingController: textEditingController, 
                  onClearAllPressed: () {
                    searchResultsProvider.clearTextField(); 
                  },
                ),
              ],
            ), 
            body: SizedBox.expand(
              child: Container(
                decoration: backgroundDecoration, 
                child: CategorizedResults(
                  children: [
                    Visibility(
                      visible: searchResultsProvider.foundSongs.isNotEmpty,
                      child: CategorizedResultsTile(
                        title: "All Songs", 
                        resultsData: searchResultsProvider.foundSongs,
                        songTileResults: [
                          for (int i = 0; i < searchResultsProvider.foundSongs.take(4).length; i++)
                            AllSongsTile(
                              songs: searchResultsProvider.foundSongs, 
                              songIndex: i, 
                              reOrderabble: false, 
                            ), 
                        ],
                      ),
                    ),
                    Visibility(
                      visible: searchResultsProvider.foundPlaylists.isNotEmpty,
                      child: CategorizedResultsTile(
                        title: "Playlists", 
                        resultsData: searchResultsProvider.foundPlaylists,
                        songTileResults: [
                          for (int i = 0; i < searchResultsProvider.foundPlaylists.take(4).length; i++)
                            SongPlaylistTile(
                              songPlaylist: searchResultsProvider.foundPlaylists[i], 
                              playlistIndex: i, 
                              reOrderabble: false, 
                            ), 
                        ],
                      ),
                    ),
                  ],
                )
              )
            ),
          );
        }
      ),
    );
  }
}









