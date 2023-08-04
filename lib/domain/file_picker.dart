import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_player.dart';

Future<Directory?> pickFolderDirectory() async {
  final String? path = await FilePicker.platform.getDirectoryPath(); 
  if (path == null) {
    return null; 
  }
  return Directory(path); 
}

List<FileSystemEntity> getFilesFromDirectory(Directory directory) {
  final List<FileSystemEntity> files = directory.listSync(); 
  return files; 
}

Future<List<Song>> getSongsFromDirectory(Directory directory) async {
  final List<FileSystemEntity> files = getFilesFromDirectory(directory); 
  List<Song> songs = []; 
  AudioPlayer audioPlayer = AudioPlayer(); 
  for (FileSystemEntity file in files) {
    String filePath = file.path; 
    String fileName = filePath.split("/").last; 
    if (!fileName.isAudioFileName) {
      // print("Database: $filePath is not an audio file."); 
      continue; 
    }
    Song song = Song(filePath); 
    song.duration = await audioPlayer.setUrl(filePath); 
    songs.add(song); 
    // print("Database: $filePath found as an audio file. "); 
  }
  return songs; 
}

Future<FilePickerResult?> pickSongFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.audio
  );
  return result; 
}

Future<FilePickerResult?> pickImageFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image
  );
  return result; 
}