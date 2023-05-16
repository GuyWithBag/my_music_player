import 'dart:io';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:hive/hive.dart'; 

part 'audio_player.g.dart'; 

@HiveType(typeId: 1)
class Song {
  @HiveField(0)
  final FileSystemEntity file; 
  @HiveField(1)
  late final Future<Metadata> metadata = getMetadata(); 

  Song(this.file,); 

  Future<Metadata> getMetadata() async {
    Metadata metadata = await MetadataRetriever.fromFile(File(file.path)); 
    return metadata; 
  }
}

Box songsBox = Hive.box("allSongs"); 

