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

  BoxDecoration? _isPlayingDecoration(BuildContext context, Song currentSong) {
    AudioPlayerProvider audioPlayerProvider = context.watch<AudioPlayerProvider>(); 
    if (audioPlayerProvider.currentSong == null) {
      return null; 
    }
    if (audioPlayerProvider.isPlaying(currentSong)) {
      return BoxDecoration(
        border: Border.all(
          width: 1, 
          color: Colors.white.withOpacity(0.3), 
        ),
        color: HSVColor.fromColor(
          Theme.of(context).primaryColor.withOpacity(0.3)
        )
        .withValue(0.6)
        .toColor(), 
      );
    }
    return null; 
  }

  @override 
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider = context.watch<AudioPlayerProvider>(); 
    SongQueueProvider songQueueProvider = context.watch<SongQueueProvider>(); 
    final Song currentSong = songs[songIndex]; 
    return SongBuilder(
      song: currentSong,
      builder: (BuildContext context, Metadata? metadata) {
        return SongTile(
          onPressed: () {
            audioPlayerProvider.startAndGoToAudioPlayer(context, songs, songIndex); 
          }, 
          decoration: _isPlayingDecoration(context, currentSong),
          onSelected: onSelected,
          onMoreButtonPressed: () {
            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return SongTileDraggableScrollSheetOptions(
                  header: SongTile( 
                    onPressed: () {}, 
                    thumbnail: getSongAlbumArt(metadata), 
                    containerHeight: 60, 
                    thumbnailSize: 75, 
                    thumbnailBorderRadius: thumbnailBorderRadius, 
                    details: SongTileDetails(
                      header: Song.getNullSafeName(currentSong),
                      subHeader: Song.nullSafeArtistNamesToReadable(metadata), 
                      useMarquee: true, 
                    ), 
                    reOrderable: false, 
                    selectable: false, 
                    showMoreButton: false, 
                  ),
                  children: [
                    SongTileDraggableScrollSheetButton(
                      onPressed: () {
                        audioPlayerProvider.startAndGoToAudioPlayer(context, songs, songIndex); 
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
            useMarquee: audioPlayerProvider.isPlaying(currentSong), 
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





