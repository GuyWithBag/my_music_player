import 'package:hive_flutter/hive_flutter.dart';
import '../domain/audio_player.dart';


class Database {
  
  List<Song> allSongs = []; 
  
  final List<Song> placeholderSongs = [
    Song("assets/audio/03 - Taron Egerton - The Way I Feel Inside.mp3"),
    Song("assets/audio/03 - Taron Egerton - The Way I Feel Inside.mp3"),
    Song("assets/audio/03 - Taron Egerton - The Way I Feel Inside.mp3"),
    Song("assets/audio/03 - Taron Egerton - The Way I Feel Inside.mp3"),
    Song("assets/audio/03 - Taron Egerton - The Way I Feel Inside.mp3"),
    Song("assets/audio/03 - Taron Egerton - The Way I Feel Inside.mp3"),
    Song("assets/audio/03 - Taron Egerton - The Way I Feel Inside.mp3"),
    Song("assets/audio/03 - Taron Egerton - The Way I Feel Inside.mp3"),
    Song("assets/audio/03 - Taron Egerton - The Way I Feel Inside.mp3"),
  ]; 

  late final List<SongPlaylist> placeholderPlaylists = [
    SongPlaylist(songs: allSongs), 
    SongPlaylist(songs: allSongs), 
    SongPlaylist(songs: allSongs), 
    SongPlaylist(songs: allSongs), 
    SongPlaylist(songs: allSongs), 
  ]; 

  // final Box<List> myBox = Hive.box("songsBox"); 

  // void loadData() { 
  //   songs = myBox.get("allSongs", defaultValue: [])!.cast<Song>(); 
  // }

  // void updateDatabase() {
  //   myBox.put("allSongs", songs); 
  // }
}

