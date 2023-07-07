import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../providers/providers.dart';
import '../../../widgets/widgets.dart'; 

// The purpose of this is to use the SongTile widget as just a gui and so that this can use FutureBuilder while allowing you to reuse SongTile for other widgets. 

class AllSongsTile extends StatelessWidget {
  const AllSongsTile({
    Key? key, 
    required this.songs, 
    required this.songIndex, 
  }) : super(key: key); 

  final List<Song> songs; 
  final int songIndex;  

  final double thumbnailSize = 60; 
  final double thumbnailBorderRadius = 5; 

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerState = context.watch<AudioPlayerProvider>(); 
    final Song currentSong = songs[songIndex]; 
    
    return SongBuilder(
      song: currentSong,
      builder: (BuildContext context, Metadata? metadata) {
        return SongTile(
          onTap: () {
            audioPlayerState.startAndGoToAudioPlayer(context, songs, songIndex); 
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
        );
      }
    );
  }
}





