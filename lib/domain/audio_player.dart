import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:hive/hive.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/providers/audio_player_provider.dart'; 
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart'; 

// part 'audio_player.g.dart'; 

@HiveType(typeId: 0)
class Song extends SongModel {
  @HiveField(9)
  final String url; 

  @HiveField(11)
  bool favorite = false; 

  @HiveField(12)
  List<SongPlaylist> playlistsIn = []; 

  @HiveField(7)
  int timesSkipped = 0; 

  @HiveField(8)
  int timesInterruptedWhilePlaying = 0; 

  Song(this.url) : super(name: basenameWithoutExtension(url)); 

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
class SongPlaylist extends SongList  {
  @HiveField(2)
  late String? thumbnailPath; 

  SongPlaylist({
    required super.songs, 
    this.thumbnailPath, 
    super.name, 
  }) : super(); 

  void setName(String value) {
    name = value; 
  }

  void promptEditPlaylistName(BuildContext context) {
    TextEditingController textEditingController = TextEditingController(); 
    Widget dialog = PlaylistRenameDialog(
      playlist: this, 
      textEditingController: textEditingController, 
    ); 
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return dialog; 
      }
    ); 
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
class SongAlbum extends SongList {
  @HiveField(10)
  late String artistName; 

  @HiveField(3)
  late String? thumbnailPath; 

  SongAlbum({
    super.name, 
  }); 
}

// Box songsBox = Hive.box("allSongs"); 

abstract class SongList extends SongModel {
  @HiveField(0)
  List<Song> songs; 

  SongList({
    super.name, 
    this.songs = const [], 
  }); 

  void play(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider = context.watch<AudioPlayerProvider>(); 
    audioPlayerProvider.startAndGoToAudioPlayer(context, songs, 0); 
  }

  void shuffle() {
    songs.shuffle(); 
  }

}

abstract class SongModel extends HasNameObject {

  @HiveField(4)
  int timesSelected = 0; 

  @HiveField(5) 
  int timesPlayed = 0; 

  @HiveField(6)
  Duration totalDurationPlayed = const Duration(); 

  SongModel({
    super.name 
  });
}

abstract class HasNameObject extends HiveObject {
  @HiveField(1)
  String name; 

  HasNameObject({
    this.name = "Null", 
  }); 

}

