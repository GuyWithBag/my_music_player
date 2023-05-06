import 'dart:io';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class Song {
  final FileSystemEntity file; 
  late final Future<Metadata> metadata; 
  late final String url; 

  Song(this.file,) {
    url = file.path; 
  }

  Future<Metadata> getMetadata() async {
    Metadata metadata = await MetadataRetriever.fromFile(File(url)); 
    return metadata; 
  }
}
