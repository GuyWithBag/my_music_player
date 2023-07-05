import 'package:flutter/material.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../domain/domain.dart';

class SongList extends StatelessWidget {
  const SongList({
    super.key,
    required this.songs, 
  });

  final List<Song> songs; 



  @override
  Widget build(BuildContext context) {
    AllSongsState appState = context.watch<AllSongsState>(); 
    void updateSongList(int oldIndex, int newIndex) {
      if (oldIndex < newIndex) {
        newIndex--;
      }
      final song = appState.removeSongAt(oldIndex); 
      appState.insertSongAt(newIndex, song); 

    }
    return PrimaryScrollController(
      controller: scrollController,
      child: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) => updateSongList(oldIndex, newIndex),
        children: [
          for (int i = 0; i < songs.length; i++) 
            SongListTile(
              key: ValueKey(i),
              songs: songs, 
              currentSongIndex: i,
            ), 
        ]
      ),
    );
  }
}

