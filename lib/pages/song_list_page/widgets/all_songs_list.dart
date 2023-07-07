import 'package:flutter/material.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import '../../../domain/domain.dart';

class AllSongsList extends StatelessWidget {
  const AllSongsList({
    super.key,
    required this.songs, 
    required this.onReorder, 
  });

  final List<Song> songs; 
  final Function(int, int) onReorder; 

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: scrollController,
      child: ReorderableListView(
        scrollController: scrollController,
        onReorder: onReorder,
        children: [
          for (int i = 0; i < songs.length; i++) 
            AllSongsTile(
              key: ValueKey(i), 
              songs: songs, 
              songIndex: i,
            ), 
        ]
      ),
    );
  }
}

