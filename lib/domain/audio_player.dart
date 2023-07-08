import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:hive/hive.dart';
import 'package:my_music_player/domain/domain.dart'; 
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
    return metadata != null ? artistNamesToReadable(metadata.trackArtistNames) : "Unknown Artist"; 
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
  late String? thumbnailPath; 

  SongPlaylist({
    required this.songs, 
    this.name, 
    this.thumbnailPath, 
  }); 

  void setName(String value) {
    name = value; 
  }

  static String getNullSafeName(SongPlaylist? playlist) {
    return playlist != null ? playlist.name! : "Null"; 
  }

  // TODO: Implement it so that shit works visually. 
  void pickImageAndSetAsThumbnail() async {
    FilePickerResult? results = await pickImageFile(); 
    if (results == null) {
      return; 
    }
    PlatformFile image = results.files[0]; 
    thumbnailPath = image.path; 
  }

}

@HiveType(typeId: 2)
class SongAlbum extends HiveObject {
  @HiveField(0)
  List<Song> songs = []; 

  @HiveField(1)
  late String name; 

  @HiveField(2)
  late String artistName; 

  @HiveField(3)
  late String? thumbnailPath; 

  SongAlbum({
    required this.name, 
  }); 
}

// Box songsBox = Hive.box("allSongs"); 

