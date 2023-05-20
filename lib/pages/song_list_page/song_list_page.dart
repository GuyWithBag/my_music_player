import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../domain/domain.dart'; 
import 'dart:io'; 
import 'widgets/widgets.dart';
import 'package:collection/collection.dart'; 
import 'pages/pages.dart'; 
import '../../data/database.dart'; 
import '../../theme/theme.dart'; 

class SongListPage extends StatefulWidget {
  const SongListPage({Key? key}) : super(key: key);

  @override
  State<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  Database db = Database(); 
  late List<Song> placeholderSongs = db.placeholderSongs; 
  late List<SongPlaylist> placeholderPlaylists = db.placeholderPlaylists; 
  
  String? _songsPath; 

  final PageController _pageController = PageController(initialPage: 0); 
  int _activePage = 0; 

  List<FileSystemEntity> _files = []; 
  List<Song> _songs = []; 
  late final List<Widget> _pages = <Widget>[
    AllSongsPage(songs: placeholderSongs,), 
    SongsPlaylistPage(songPlaylists: placeholderPlaylists,), 
    const AlbumsPage(), 
  ]; 

  final List<String> _pagesTab = const <String>[
    "All Songs", 
    "Playlist", 
    "Albums", 
  ];
  
  void pickFolderAndAddSongs() async {
    Directory? dir = await pickFolderDirectory(); 
    if (dir == null) { 
      return; 
    }
    List<Song> newSongs = getSongsFromDirectory(dir); 
    if (const DeepCollectionEquality.unordered().equals(_songs, newSongs) == false) {
      clearSongs(); 
      addSongs(newSongs); 
      return; 
    }
    addSongs(_songs); 
  } 

  void addSongs(List<Song> newSongs) {
    _songs.addAll(newSongs); 
  }

  void addSong(Song song) {
    _songs.add(song); 
  }

  void clearSongs() {
    _songs.clear(); 
  }


  // @override
  // void initState() {
  //   super.initState();
  //   // if (songsBox.isNotEmpty) {
  //   //   clearSongs(); 
  //   //   for (Song song in songsBox.values) {
  //   //     addSong(song); 
  //   //   }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SongCategoryTabs(pages: _pages, pageController: _pageController, pagesTab: _pagesTab, activePage: _activePage), 
          Expanded(
            child: PageView(
              scrollBehavior: AppScrollBehavior(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _activePage = page; 
                });
              },
              children: _pages,
            ),
          ),
        ]
      ),
    );
  }
}

class _SongCategoryTabs extends StatelessWidget {
  const _SongCategoryTabs({
    Key? key,
    required List<Widget> pages,
    required PageController pageController,
    required List<String> pagesTab,
    required int activePage,
  }) : _pages = pages, _pageController = pageController, _pagesTab = pagesTab, _activePage = activePage, super(key: key);

  final List<Widget> _pages;
  final PageController _pageController;
  final List<String> _pagesTab;
  final int _activePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30, 
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColorLight
          )
        )
      ),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List<Widget>.generate(
              _pages.length, 
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    _pageController.animateToPage(
                      index, 
                      duration: const Duration(milliseconds: 300), 
                      curve: Curves.easeIn, 
                    ); 
                  },
                  child: Text(
                    _pagesTab[index], 
                    style: _activePage == index ? 
                      Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold) : 
                      Theme.of(context).textTheme.titleSmall
                    ,
                  ),
                ),
              )
            )
          ),
        ),
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}