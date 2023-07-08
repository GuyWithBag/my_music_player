import 'package:flutter/material.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import 'package:my_music_player/theme/theme.dart';
import 'package:my_music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../domain/domain.dart';
import '../../providers/providers.dart'; 

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
                SizedBox(
                  width: 250, 
                  child: TextFormField(
                    onChanged: (String value) { 
                      searchResultsProvider.searchSongs(context, value); 
                    }, 
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(), 
                      labelText: "Search here: "
                    ), 
                  ), 
                ), 
                Visibility(
                  visible: textEditingController.text.isNotEmpty,
                  child: IconButton(
                    onPressed: () {
                      searchResultsProvider.clearTextField(); 
                    },
                    icon: const Icon(Icons.cancel)
                  ),
                )
              ],
            ), 
            body: SizedBox.expand(
              child: Container(
                decoration: backgroundDecoration, 
                child: CategorizedResults(
                  title: "All Songs", 
                  songTileResults: [
                    for (int i = 0; i < searchResultsProvider.foundSongs.take(4).length; i++)
                      AllSongsTile(
                        songs: searchResultsProvider.foundSongs, 
                        songIndex: i, 
                        reOrderabble: false, 
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

class SearchResultsProvider extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController(); 
  List<Song> foundSongs = []; 

  void updateNotifier() {
    notifyListeners(); 
  }

  void searchSongs(BuildContext context, String value) {
    final AllSongsProvider allSongsProvider = context.read<AllSongsProvider>(); 
    foundSongs = allSongsProvider.getSearchedSongs(value); 
    notifyListeners(); 
  }

  void clearTextField() {
    textEditingController.clear(); 
    notifyListeners(); 
  }
}

class CategorizedResults extends StatelessWidget {
  const CategorizedResults({
    super.key, 
    required this.title, 
    required this.songTileResults, 
  });

  final String title; 
  final List<Widget> songTileResults; 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategorizedResultsHeader(
          title: title,
        ), 
        Expanded(
          child: ListView(
            children: songTileResults
          ),
        ),
      ], 
    );
  }
}

class CategorizedResultsHeader extends StatelessWidget {
  const CategorizedResultsHeader({
    super.key, 
    required this.title
  }); 
  final String title; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20, 
          vertical: 10
        ),
        child: Row(
          children: [
            Text(
              title, 
              style: Theme.of(context)
                          .textTheme
                          .titleMedium,
            ), 
            const Spacer(), 
            InkWell(
              onTap: () {
      
              },
              child: Text(
                "See More", 
                style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                            fontWeight: FontWeight.bold, 
                            color: Colors.lightBlue, 
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CatgeorizedResultsTile extends StatelessWidget {
  const CatgeorizedResultsTile({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

