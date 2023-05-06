import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_music_player/domain/file_picker.dart';
import '../../domain/audio_player.dart'; 
import 'dart:io'; 
import 'package:flutter_media_metadata/flutter_media_metadata.dart'; 
import 'package:path/path.dart'; 

class SongsPage extends StatefulWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  String? songsPath; 

  List<FileSystemEntity> files = []; 
  List<Song> songs = []; 
  
  void pickFolderAndAddSongs() async {
    addSongs(getSongsFromDirectory(await pickFolderDirectory())); 
  }

  void addSongs(List<Song> newSongs) async {
    songs.addAll(newSongs); 
    for (Song song in newSongs) { 
      Metadata metadata = await song.getMetadata(); 
      print(metadata.trackName); 
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
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (Song song in songs)
                    ListTile(
                      leading: const Icon(Icons.house), 
                      title: FutureBuilder(
                        future: song.getMetadata(),
                        builder: (context, snapshot) {
                          return Text(
                            basenameWithoutExtension(song.file.path),
                            style: const TextStyle(color: Colors.white),
                          );
                        }
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}