import 'package:flutter/material.dart';
import 'package:my_music_player/widgets/widgets.dart';
import '../../../data/database.dart';
import '../../../domain/audio_player.dart'; 
import '../../../theme/theme.dart';
import '../widgets/widgets.dart'; 

class AllSongsPage extends StatelessWidget {
  const AllSongsPage({
    Key? key, required this.songs
  }) : super(key: key);

  final List<Song> songs; 

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration,
      child: Column(
        children: [
          SubHeader(
            header: Text("${songs.length} songs"), 
            actions: [
              SubHeaderAction(
                onTap: () {},
                icon: const Icon(
                  Icons.sort, 
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 25), 
              SubHeaderAction(
                onTap: () {},
                icon: const Icon(
                  Icons.list, 
                  color: Colors.white,
                ),
              ), 
            ],
          ), 
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 10), 
              child: SongList(songs: songs)
            ),
          )
        ],
      )
    ); 
  }
}




