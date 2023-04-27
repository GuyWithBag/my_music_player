import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../domain/audio_player.dart'; 
import 'dart:io'; 

class SongsPage extends StatefulWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
    String? songsPath; 

    List<FileSystemEntity> files = []; 
    List<Song> songs = []; 
    
    void _pickFolder() async {
      songsPath = await FilePicker.platform.getDirectoryPath(); 
      files = Directory(songsPath!).listSync(); 
      for (FileSystemEntity file in files) {
        songs.add(Song(title: file.toString(), coverUrl: "", url: file.path, description: "test")); 
        print(file.path); 
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
                _pickFolder(); 
              }, 
              child: const Text("Open Folder"), 
            ), 
            // ListView(
            //   children: [
            //     for (Song song in songs)
            //       ListTile(
            //         leading: const Icon(Icons.house), 
            //         title: Text(song.title),
            //       )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}