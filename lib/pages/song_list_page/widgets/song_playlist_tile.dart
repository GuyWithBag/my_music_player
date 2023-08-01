import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import '../../../domain/audio_player.dart';
import '../../../widgets/widgets.dart'; 


class SongPlaylistTile extends StatelessWidget {
  const SongPlaylistTile({
    super.key,
    required this.songPlaylist, 
    required this.playlistIndex, 
    this.reOrderabble = true, 
  });

  final double playlistThumbnailSize = 67;
  final double playlistThumbnailBorderRadius = 8; 
  final double containerHeight = 80; 
  final int playlistIndex; 
  
  final SongPlaylist songPlaylist;
  final bool reOrderabble; 

  @override
  Widget build(BuildContext context) {
    return SongTile(
      onTap: () {
        Get.toNamed(
          "/SongsList/SongPlaylist", 
          arguments: SongPlaylistPageArguments(
            songPlaylist
          ), 
        );
      }, 
      details: SongTileDetails(
        header: songPlaylist.name, 
        subHeader: "${songPlaylist.songs.length} songs",
      ),
      thumbnail: const Icon(Icons.hourglass_empty),
      thumbnailSize: playlistThumbnailSize,
      thumbnailBorderRadius: playlistThumbnailBorderRadius, 
      containerHeight: containerHeight,
      index: playlistIndex, 
      reOrderable: reOrderabble,
    ); 
  }
}
