import 'package:flutter/material.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import '../../../domain/domain.dart';

class SongPlaylistList extends StatelessWidget {
  const SongPlaylistList({
    super.key,
    required this.songPlaylists,
  });

  final List<SongPlaylist> songPlaylists;
  final double playlistThumbnailSize = 70;
  final double playlistThumbnailBorderRadius = 8;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (SongPlaylist songPlaylist in songPlaylists) 
            SongPlaylistTile(songPlaylist: songPlaylist)
        ],
      ),
    );
  }
}