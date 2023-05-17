import 'package:hive_flutter/hive_flutter.dart';
import '../domain/audio_player.dart';


class Database {
  
  List<Song> songs = []; 
  final Box<List> myBox = Hive.box("songsBox"); 

  void loadData() { 
    songs = myBox.get("allSongs", defaultValue: [])!.cast<Song>(); 
  }

  void updateDatabase() {
    myBox.put("allSongs", songs); 
  }
}

