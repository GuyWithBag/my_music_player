
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

import 'audio_player.dart';


void sortSongsAlphabetically(List<Song> songs, {bool descending = false}) {
  songs.sort((Song a, Song b) {
    String nameA = trimNonAlphanumericCharacters(a.name); 
    String nameB = trimNonAlphanumericCharacters(b.name); 
    if (descending) {
      return stringAlphabeticalSort(nameB, nameA); 
    } else {
      return stringAlphabeticalSort(nameA, nameB); 
    }
  }); 
}

int stringAlphabeticalSort(String a, String b) {
  int result = a.toLowerCase().compareTo(b.toLowerCase());
  return result;
}

String trimNonAlphanumericCharacters(String value) {
  return value.replaceAll(RegExp("[\\W]|_"), "");
}

bool isEnglish(String value) {
  return RegExp(r'^[a-zA-Z0-9\s,.!?]*$').hasMatch(value);
}

double getTextWidth({required TextSpan textSpan, TextDirection textDirection = TextDirection.ltr}) {
  final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
  tp.layout(); 
  return tp.width; 
}

double getTextHeight({required TextSpan textSpan, TextDirection textDirection = TextDirection.ltr}) {
  final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
  tp.layout(); 
  return tp.height; 
}

// TODO: Put this into the SongAlbumList page
Future<List<SongAlbum>> getSongsSortedByAlbum(List<Song> songs) async {
  List<SongAlbum> albums = [
    SongAlbum(
      name: "No Album"
    )
  ]; 
  SongAlbum? getAlbumByAlbumName(String albumName) {
    for (SongAlbum album in albums) {
      if (albumName == album.name) {
        return album; 
      }
    }
    return null; 
  }

  for (Song song in songs) {
    Metadata metadata = await song.getMetadata(); 
    List<String> albumNames = []; 
    // This will put all the album names into a list so that we can check if an albumName is inside there. 
    for (SongAlbum album in albums) {
      albumNames.add(album.name); 
    }
    // If it doesn't contain an Album
    if (metadata.albumName == null) {
      SongAlbum songAlbum = getAlbumByAlbumName("No Album")!; 
      songAlbum.songs.add(song); 
    // If the album is not already in the albums
    } else if (!albumNames.contains(metadata.albumName)) {
      SongAlbum(
        name: metadata.albumName!, 
      ); 
    // If the album is already in the albums
    } else if (albumNames.contains(metadata.albumName)) {
      SongAlbum songAlbum = getAlbumByAlbumName(metadata.albumName!)!; 
      songAlbum.songs.add(song); 
    }
  }
  return albums; 
}

// int arrangeStringAlphabetically(Song a, Song b) {
//   return a.name.toLowerCase().compareTo(b.name.toLowerCase());
// }