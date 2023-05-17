import 'package:flutter/material.dart';
import 'package:my_music_player/pages/song_list_page/widgets/song_list.dart';
import '../../../data/database.dart';
import '../../../domain/audio_player.dart'; 

class AllSongsPage extends StatelessWidget {
  const AllSongsPage({Key? key, required this.songs}) : super(key: key);

  final List<Song> songs; 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: SongList(songs: songs,)
    ); 
  }
}