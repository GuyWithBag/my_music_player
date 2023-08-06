import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

import 'domain.dart';

void onReOrderUpdateList(int oldIndex, int newIndex, Function(int) removeItemAt, Function insertItemAt) {
  if (oldIndex < newIndex) {
    newIndex--;
  }
  final song = removeItemAt(oldIndex); 
  insertItemAt(newIndex, song); 
}

Widget? getSongAlbumArt(Song? song) {
  if ( song != null && song.metadata != null) {
    Uint8List? albumArt = song.metadata!.albumArt; 
    if (albumArt == null) {
      return null; 
    }
    return Image.memory(albumArt); 
  } else {
    return null; 
  }
}
