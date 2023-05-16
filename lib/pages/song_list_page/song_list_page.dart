import 'package:flutter/material.dart';
import '../../domain/domain.dart'; 
import 'dart:io'; 
import 'widgets/widgets.dart';
import 'package:collection/collection.dart'; 
import 'pages/pages.dart'; 

class SongListPage extends StatefulWidget {
  const SongListPage({Key? key}) : super(key: key);

  @override
  State<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  String? _songsPath; 

  final PageController _pageController = PageController(initialPage: 0); 
  int _activePage = 0; 

  List<FileSystemEntity> _files = []; 
  List<Song> _songs = []; 
  final List<Widget> _pages = const <Widget>[
    AllSongsPage(), 
    SongsPlaylistPage(), 
    AlbumsPage(), 
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
  //   if (songsBox.isNotEmpty) {
  //     clearSongs(); 
  //     for (Song song in songsBox.values) {
  //       addSong(song); 
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page; 
                print("hihi"); 
              });
            },
            children: _pages,
          )
        ]
      ),
    );
  }
}



