import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../domain/audio_player.dart';
import '../../../providers/providers.dart';
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
    // AudioPlayerProvider audioPlayerProvider = context.watch<AudioPlayerProvider>(); 
    // SongQueueProvider songQueueProvider = context.watch<SongQueueProvider>(); 
    SongPlaylistProvider songPlaylistProvider = context.watch<SongPlaylistProvider>(); 
    return SongTile(
      onPressed: () {
        Get.toNamed(
          "/SongsList/SongPlaylist", 
          arguments: SongPlaylistPageArguments(
            songPlaylist
          ), 
        );
      }, 
      onMoreButtonPressed: () {
        showDialog(
          context: context, 
          builder: (BuildContext context) {
            return SongTileDraggableScrollSheetOptions(
              header: SongTile( 
                onPressed: () {}, 
                thumbnail: const Icon(Icons.hourglass_empty), 
                containerHeight: containerHeight, 
                thumbnailSize: playlistThumbnailSize, 
                thumbnailBorderRadius: playlistThumbnailBorderRadius, 
                details: SongTileDetails(
                  header: songPlaylist.name, 
                  subHeader: "${songPlaylist.songs.length} songs",
                ), 
                reOrderable: false, 
                selectable: false, 
                showMoreButton: false, 
              ),
              children: [
                SongTileDraggableScrollSheetButton(
                  onPressed: () {
                      songPlaylist.play(context); 
                  }, 
                  icon: const Icon(Icons.play_arrow), 
                  leading: "Play Playlist",
                ), 
                SongTileDraggableScrollSheetButton(
                  onPressed: () {
                      
                  }, 
                  icon: const Icon(Icons.fast_forward), 
                  leading: "Play next in playing queue",
                ), 
                SongTileDraggableScrollSheetButton(
                  onPressed: () {
                    
                  }, 
                  icon: const Icon(Icons.add_to_queue), 
                  leading: "Add to the playing queue",
                ), 
                SongTileDraggableScrollSheetButton(
                  onPressed: () {
                      
                  }, 
                  icon: const Icon(Icons.playlist_add), 
                  leading: "Add to playlist",
                ), 
                SongTileDraggableScrollSheetButton(
                  onPressed: () {
                    
                  }, 
                  icon: const Icon(Icons.mobile_screen_share), 
                  leading: "Nearby Share",
                ), 
                SongTileDraggableScrollSheetButton(
                  onPressed: () {
                      
                  }, 
                  icon: const Icon(Icons.play_arrow), 
                  leading: "Add to home screen",
                ), 
                SongTileDraggableScrollSheetButton(
                  onPressed: () {
                      
                  }, 
                  icon: const Icon(Icons.play_arrow), 
                  leading: "Rename",
                ), 
                SongTileDraggableScrollSheetButton(
                  onPressed: () {
                      songPlaylist.promptEditPlaylistName(context); 
                  }, 
                  icon: const Icon(Icons.play_arrow), 
                  leading: "Delete playlist",
                ), 
              ], 
            ); 
          }
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
