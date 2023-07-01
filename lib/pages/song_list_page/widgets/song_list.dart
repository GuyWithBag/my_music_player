import 'package:flutter/material.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import '../../../domain/domain.dart';

class SongList extends StatelessWidget {
  const SongList({
    super.key,
    required this.songs, 
  });

  final List<Song> songs; 

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            for (int i = 0; i < songs.length; i++) 
              SongListTile(
                songs: songs, 
                currentSongIndex: i,
              )
          ]
        ),
      ),
    );
  }
}

