import 'package:hive_flutter/hive_flutter.dart';
import '../domain/audio_player.dart';


class Database {
  
  List<Song> songs = []; 
  final List<Song> placeholderSongs = [
    Song("E:/CODE STUFF/Flutter/my_music_player/assets/audio/03 - Taron Egerton - The Way I Feel Inside"),
    Song("E:/CODE STUFF/Flutter/my_music_player/assets/audio/03 - Taron Egerton - The Way I Feel Inside"),
    Song("E:/CODE STUFF/Flutter/my_music_player/assets/audio/03 - Taron Egerton - The Way I Feel Inside"),
    Song("E:/CODE STUFF/Flutter/my_music_player/assets/audio/03 - Taron Egerton - The Way I Feel Inside"),
    Song("E:/CODE STUFF/Flutter/my_music_player/assets/audio/03 - Taron Egerton - The Way I Feel Inside"),
    Song("E:/CODE STUFF/Flutter/my_music_player/assets/audio/03 - Taron Egerton - The Way I Feel Inside"),
  ]; 

  // final Box<List> myBox = Hive.box("songsBox"); 

  // void loadData() { 
  //   songs = myBox.get("allSongs", defaultValue: [])!.cast<Song>(); 
  // }

  // void updateDatabase() {
  //   myBox.put("allSongs", songs); 
  // }
}

