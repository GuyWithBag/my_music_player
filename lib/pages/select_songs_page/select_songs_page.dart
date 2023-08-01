import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music_player/providers/providers.dart';
import 'package:my_music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../domain/domain.dart';

class SelectSongsPage extends StatelessWidget {
  const SelectSongsPage({
    super.key
  }); 

  final double subHeaderGap = 7;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchResultsProvider()), 
        ChangeNotifierProvider(create: (context) => SelectedSongsProvider()), 
        ChangeNotifierProvider(create: (context) => LocalProvider()), 
      ], 
      child: Builder(
        builder: (context) {
          SelectedSongsProvider selectedSongsProvider = context.watch<SelectedSongsProvider>(); 
          SearchResultsProvider searchResultsProvider = context.watch<SearchResultsProvider>(); 
          TextEditingController textEditingController = searchResultsProvider.textEditingController; 
          return Scaffold(
            appBar: AppBar(
              title: const Text("Choose tracks"), 
            ),
            body: BackgroundContainer(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                      ScrollableSubHeader(
                        children: <Widget>[
                          _SubHeaderButton(
                            onPressed: () {

                            }, 
                            leading: "Recently played",
                          ), 
                          SizedBox(width: subHeaderGap), 
                          _SubHeaderButton(
                            onPressed: () {

                            }, 
                            leading: "All",
                          ), 
                          SizedBox(width: subHeaderGap), 
                          _SubHeaderButton(
                            onPressed: () {

                            }, 
                            leading: "Most Played",
                          ), 
                          SizedBox(width: subHeaderGap), 
                          _SubHeaderButton(
                            onPressed: () {

                            }, 
                            leading: "Favorite",
                          ), 
                        ],
                      ), 
                      Expanded( 
                        child: ListView(
                          children: [
                            for (int i = 0; i < searchResultsProvider.foundSongs.length; i++)
                              AllSongsTile(
                                songs: searchResultsProvider.foundSongs, 
                                songIndex: i, 
                                reOrderabble: false, 
                                selectable: true, 
                                selected: selectedSongsProvider.items.contains(searchResultsProvider.foundSongs[i]), 
                                onSelected: () {
                                  Song song = searchResultsProvider.foundSongs[i]; 
                                  if (selectedSongsProvider.items.contains(song)) {
                                    selectedSongsProvider.removeItem(song); 
                                    return; 
                                  }
                                  selectedSongsProvider.addItem(song); 
                                },
                              ), 
                          ],
                        ),
                      )
                    ],
                  ), 
                  Visibility( 
                    visible: selectedSongsProvider.items.isNotEmpty, 
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AddSongsOption(selectedSongsProvider: selectedSongsProvider),
                    ),
                  )
                ],
              )
            ), 
          );
        }
      ),
    );
  }
}

class ScrollableSubHeader extends StatelessWidget {
  const ScrollableSubHeader({
    super.key, 
    required this.children,
  });

  final List<Widget> children; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, 
      height: 50, 
      child: Padding(
        padding: const EdgeInsets.all(11),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: children, 
        ),
      ),
    );
  }
}

class AddSongsOption extends StatelessWidget {
  const AddSongsOption({
    super.key,
    required this.selectedSongsProvider, 
  });

  final SelectedSongsProvider selectedSongsProvider; 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor, 
      width: MediaQuery.of(context).size.width, 
      height: 80, 
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4), 
                borderRadius: BorderRadius.circular(10), 
              ),
              width: 50,
              child: Center(
                child: Text(
                  "${selectedSongsProvider.items.length}", 
                  style: Theme.of(context)
                              .textTheme
                              .labelLarge,
                )
              ), 
            ), 
            const SizedBox(width: 20), 
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  SongPlaylist songPlaylist = (Get.arguments as SelectSongsPageArguments).songPlaylist; 
                  songPlaylist.songs.addAll(selectedSongsProvider.items); 
                  selectedSongsProvider.clearItems(); 
                  Get.toNamed(
                    "/SongsList/SongPlaylist", 
                    arguments: SongPlaylistPageArguments(songPlaylist)
                  ); 
                }, 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.5))
                ),
                child: Center(
                  child: Text(
                    selectedSongsProvider.items.length > 1 ? "Add Songs" : "Add Song", 
                    style: Theme.of(context)
                                .textTheme
                                .labelLarge, 
                  )
                ), 
              ),
            ), 
          ],
        ),
      ),
    );
  }
}

class _SubHeaderButton extends StatelessWidget {
  const _SubHeaderButton({
    Key? key, 
    required this.onPressed, 
    required this.leading, 
  }) : super(key: key); 

  final void Function()? onPressed; 
  final String leading; 

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed, 
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.5)), 
      ),
      child: Text(
        leading, 
        // style: Theme.of(context)
        //             .textTheme
        //             .labelMedium!
        //             .copyWith(
        //               color: Colors.white
        //             ),
      )
    );
  }
}


class LocalProvider extends ChangeNotifier {
  List<SongList> nonSongsSelect = []; 
}