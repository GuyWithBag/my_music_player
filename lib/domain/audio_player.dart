import 'dart:io';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:hive/hive.dart'; 
import 'package:path/path.dart'; 

// part 'audio_player.g.dart'; 

@HiveType(typeId: 0)
class Song extends HiveObject {
  @HiveField(0)
  final String url; 
  @HiveField(1)
  late final String name = basenameWithoutExtension(url); 

  Song(this.url); 

  Future<Metadata> getMetadata() async {
    Metadata metadata = await MetadataRetriever.fromFile(File(url)); 
    return metadata; 
  }
}

@HiveType(typeId: 1)
class SongPlaylist extends HiveObject  {

  @HiveField(0)
  List<Song>? songs; 

  @HiveField(1)
  late String? name; 

  @HiveField(2)
  late String? thumbnail; 

  SongPlaylist({
    this.songs, 
    this.name, 
    this.thumbnail, 
  }); 

}

class AudioPlayerArguments {

  int indexToPlay = 0; 
  List<Song> songs = []; 

}

// Box songsBox = Hive.box("allSongs"); 

