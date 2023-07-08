import 'package:flutter/material.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import '../../../domain/domain.dart';
import '../../../controllers/controllers.dart';

class SongPlaylistList extends StatelessWidget {
  const SongPlaylistList({
    super.key,
    required this.songPlaylists, 
    required this.onReorder,
  });

  final List<SongPlaylist> songPlaylists;
  final double playlistThumbnailSize = 70;
  final double playlistThumbnailBorderRadius = 8; 
  final Function(int, int) onReorder; 

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: primaryScrollController, 
      child: ReorderableListView(
        scrollController: primaryScrollController,
        onReorder: onReorder, 
        children: [
          for (int i = 0; i < songPlaylists.length; i++) 
            SongPlaylistTile(
              key: ValueKey(i),
              playlistIndex: i,
              songPlaylist: songPlaylists[i], 
            )
        ],
      ),
    );
  }
}