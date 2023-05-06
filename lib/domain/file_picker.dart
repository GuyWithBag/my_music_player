import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import 'audio_player.dart';

Future<Directory> pickFolderDirectory() async {
  final String? path = await FilePicker.platform.getDirectoryPath(); 
  return Directory(path!); 
}

List<FileSystemEntity> getFilesFromDirectory(Directory directory) {
  final List<FileSystemEntity> files = directory.listSync(); 
  return files; 
}

List<Song> getSongsFromDirectory(Directory directory) {
  final List<FileSystemEntity> files = getFilesFromDirectory(directory); 
  List<Song> songs = []; 
  for (FileSystemEntity file in files) {
    String fileName = file.path.split("/").last; 
    if (!fileName.isAudioFileName) {
      print("Not audio"); 
      continue; 
    }
    songs.add(Song(file)); 
    // print(file.path); 
  }
  return songs; 
}

Future<FilePickerResult?> pickSongFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.audio
  );
  return result; 
}

