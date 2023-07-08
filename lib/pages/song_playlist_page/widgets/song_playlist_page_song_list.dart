import 'package:flutter/material.dart';
import '../../../controllers/controllers.dart';
import '../../../domain/domain.dart';
import 'widgets.dart';

class SongPlaylistPageSongList extends StatelessWidget {
  const SongPlaylistPageSongList({
    super.key,
    required this.songs, 
    required this.onReorder, 
  });

  final List<Song> songs; 
  final Function(int, int) onReorder; 

  @override
  Widget build(BuildContext context) {
    if (songs.isEmpty) {
      return Center(
        child: Text(
          "No songs here!\nTo add songs, click the plus icon!", 
          textAlign: TextAlign.center, 
          style: Theme.of(context)
              .textTheme
              .labelLarge,
        ),
      );
    }
    return PrimaryScrollController(
      controller: primaryScrollController,
      child: ReorderableListView(
        scrollController: primaryScrollController, 
        onReorder: onReorder,
        children: [
          for (int i = 0; i < songs.length; i++) 
            SongPlaylistPageSongTile(
              key: ValueKey(i), 
              songs: songs, 
              songIndex: i,
            ), 
        ]
      ),
    );
  }
}