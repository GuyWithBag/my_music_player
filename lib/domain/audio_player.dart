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
  late final String name; 
  @HiveField(2)
  bool favorite = false; 
  @HiveField(3)
  List<SongPlaylist> playlistsIn = []; 

  Song(this.url) {
    name = basenameWithoutExtension(url); 
  }

  Future<Metadata> getMetadata() async {
    File file = File(url); 
    if (!(await file.exists())) {
      print("File: $url does not exist"); 
    }
    Metadata metadata = await MetadataRetriever.fromFile(file); 
    return metadata; 
  }

  static String artistNamesToReadable(List<String>? trackArtistNames) {
    String artistNames = trackArtistNames?.join(", ") ?? "Unknown Artist"; 
    artistNames = trimTopic(artistNames); 
    return artistNames; 
  }

  static String nullSafeArtistNamesToReadable(Metadata? metadata) {
    return metadata != null ? artistNamesToReadable(metadata!.trackArtistNames) : "Unknown Artist"; 
  }

  static String trimTopic(String input) {
    return input.replaceAll(RegExp(r'\s?-\s?Topic'), '');
  }

  static String getNullSafeName(Song? song) {
    return song != null ? song.name : "Null"; 
  }

}

@HiveType(typeId: 1)
class SongPlaylist extends HiveObject  {

  @HiveField(0)
  List<Song> songs; 

  @HiveField(1)
  late String? name; 

  @HiveField(2)
  late String? thumbnail; 

  SongPlaylist({
    required this.songs, 
    this.name, 
    this.thumbnail, 
  }); 
}

@HiveType(typeId: 2)
class SongAlbum extends HiveObject {
  @HiveField(0)
  List<Song> songs; 

  @HiveField(1)
  late String name; 

  @HiveField(2)
  late String artistName; 

  @HiveField(3)
  late String? thumbnail; 

  SongAlbum({
    required this.songs, 
    required this.name, 
  }); 

}

// Box songsBox = Hive.box("allSongs"); 

