
import 'package:flutter/material.dart'; 
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart';

class SongPlaylistPageSongTile extends StatelessWidget {
  const SongPlaylistPageSongTile({
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
    final AudioPlayerProvider audioPlayerProvider = context.watch<AudioPlayerProvider>(); 
    final Song currentSong = songs[songIndex]; 
    return SongBuilder(
      song: currentSong,
      builder: (BuildContext context, Metadata? metadata) {
        return SongTile(
          details: _Details(
            song: currentSong, 
            metadata: metadata,
          ),
          onTap: () {
            audioPlayerProvider.startAndGoToAudioPlayer(context, songs, songIndex); 
          }, 
          thumbnail: getSongAlbumArt(metadata), 
          thumbnailSize: thumbnailSize, 
          thumbnailBorderRadius: 8, 
          containerHeight: 75, 
        );
      }
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({
    Key? key, 
    required this.song, 
    required this.metadata
  }) : super(key: key); 

  final Song song; 
  final Metadata? metadata; 


  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SongTileDetails(
          header: song.name, 
          subHeader: Song.nullSafeArtistNamesToReadable(metadata), 
        ),
        Text(
          song.playlistsIn.toString(), 
          maxLines: 1, 
          style: Theme.of(context)
              .textTheme
              .bodySmall, 
        )
      ],
    );
  }
}