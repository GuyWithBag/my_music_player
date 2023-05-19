import 'package:flutter/material.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import '../../../domain/audio_player.dart'; 


class SongPlaylistTile extends StatelessWidget {
  const SongPlaylistTile({
    super.key,
    required this.songPlaylist,
  });

  final double playlistThumbnailSize = 67;
  final double playlistThumbnailBorderRadius = 8; 
  final double containerHeight = 80; 
  final SongPlaylist songPlaylist;

  @override
  Widget build(BuildContext context) {
    return SongTile(
      onTap: () {}, 
      header: songPlaylist.name ?? "Playlist", 
      subHeader: "${songPlaylist.songs?.length} songs", 
      thumbnail: const Icon(Icons.hourglass_empty),
      thumbnailSize: playlistThumbnailSize,
      thumbnailBorderRadius: playlistThumbnailBorderRadius, 
      containerHeight: 80,
    ); 
  }
}