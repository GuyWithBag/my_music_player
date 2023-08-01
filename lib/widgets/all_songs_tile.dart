import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../controllers/controllers.dart';
import '../../../providers/providers.dart';
import '../../../widgets/widgets.dart'; 

// The purpose of this is to use the SongTile widget as just a gui and so that this can use FutureBuilder while allowing you to reuse SongTile for other widgets. 

class AllSongsTile extends StatelessWidget {
  const AllSongsTile({
    Key? key, 
    required this.songs, 
    required this.songIndex, 
    this.reOrderabble = true, 
    this.onSelected, 
    this.selectable = false, 
    this.selected = false, 
  }) : super(key: key); 

  final List<Song> songs; 
  final int songIndex;  
  final bool reOrderabble; 
  final bool selectable; 
  final bool selected; 
  final void Function()? onSelected; 

  final double thumbnailSize = 60; 
  final double thumbnailBorderRadius = 5; 

  @override 
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerState = context.watch<AudioPlayerProvider>(); 
    SongQueueProvider songQueueProvider = context.watch<SongQueueProvider>(); 
    SongTileDraggableScrollSheetOptionsController songTileDraggableScrollSheetOptionsController = context.watch<SongTileDraggableScrollSheetOptionsController>();
    final Song currentSong = songs[songIndex]; 
    return SongBuilder(
      song: currentSong,
      builder: (BuildContext context, Metadata? metadata) {
        return SongTile(
          onTap: () {
            audioPlayerState.startAndGoToAudioPlayer(context, songs, songIndex); 
          }, 
          onSelected: onSelected,
          onMoreButtonPressed: () {
            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return SongTileDraggableScrollSheetOptions(
                  visible: songTileDraggableScrollSheetOptionsController.visible, 
                  children: [
                    SongTileDraggableScrollSheetButton(
                      onPressed: () {
                        audioPlayerState.startAndGoToAudioPlayer(context, songs, songIndex); 
                      }, 
                      icon: const Icon(Icons.play_arrow), 
                      leading: "Play Song",
                    ), 
                    SongTileDraggableScrollSheetButton(
                      onPressed: () {
                        songQueueProvider.insertItemAt(songIndex, currentSong);  
                      }, 
                      icon: const Icon(Icons.fast_forward), 
                      leading: "Play Next",
                    ), 
                    SongTileDraggableScrollSheetButton(
                      onPressed: () {
                        songQueueProvider.addItem(currentSong); 
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
                         
                      }, 
                      icon: const Icon(Icons.play_arrow), 
                      leading: "Delete the song file",
                    ), 
                  ], 
                );
              }
            ); 
          },
          details: SongTileDetails(
            header: Song.getNullSafeName(currentSong),
            subHeader: Song.nullSafeArtistNamesToReadable(metadata),
          ), 
          thumbnail: getSongAlbumArt(metadata), 
          index: songIndex,
          thumbnailSize: thumbnailSize,
          thumbnailBorderRadius: thumbnailBorderRadius,
          containerHeight: 75,  
          reOrderable: reOrderabble, 
          selectable: selectable, 
          selected: selected, 
        );
      }
    );
  }
}





