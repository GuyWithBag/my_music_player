import 'package:flutter/material.dart';
import '../../domain/domain.dart'; 
import 'dart:io'; 
import 'widgets/widgets.dart';
import 'package:collection/collection.dart'; 

class SongListPage extends StatefulWidget {
  const SongListPage({Key? key}) : super(key: key);

  @override
  State<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  String? songsPath; 

  List<FileSystemEntity> files = []; 
  List<Song> songs = []; 


  void pickFolderAndAddSongs() async {
    Directory? dir = await pickFolderDirectory(); 
    if (dir == null) { 
      return; 
    }
    List<Song> newSongs = getSongsFromDirectory(dir); 
    if (const DeepCollectionEquality.unordered().equals(songs, newSongs) == false) {
      clearSongs(); 
      addSongs(newSongs); 
      return; 
    }
    addSongs(songs); 
  } 

  void addSongs(List<Song> newSongs) {
    songs.addAll(newSongs); 
    for (Song song in newSongs) {
      songsBox.put(song.file.path, song); 
    }
  }

  void addSong(Song song) {
    songs.add(song); 
  }

  void clearSongs() {
    songs.clear(); 
  }


  @override
  void initState() {
    super.initState();
    if (songsBox.isNotEmpty) {
      clearSongs(); 
      for (Song song in songsBox.values) {
        addSong(song); 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  pickFolderAndAddSongs(); 
                });
              }, 
              child: const Text("Open Folder"), 
            ), 
            SongList(songs: songs),
          ],
        ),
      ),
    );
  }
}



