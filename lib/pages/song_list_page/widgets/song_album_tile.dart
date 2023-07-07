
import 'package:flutter/material.dart';
import '../../../domain/audio_player.dart';
import '../../../widgets/widgets.dart';


class SongAlbumTile extends StatelessWidget {
  const SongAlbumTile({
    Key? key,
    required this.songAlbum
  }) : super(key: key);

  final SongAlbum songAlbum; 
  final double thumbnailSize = 67;
  final double thumbnailBorderRadius = 8; 
  final double containerHeight = 80; 

  @override
  Widget build(BuildContext context) {
    return SongTile(
      onTap: () {
        
      },
      details: SongTileDetails(
        header: songAlbum.name, 
        subHeader: "${songAlbum.artistName} - ${songAlbum.songs.length} songs"
      ),
      containerHeight: containerHeight,
      thumbnail: const Icon(Icons.music_note),
      thumbnailSize: thumbnailSize, 
      thumbnailBorderRadius: thumbnailBorderRadius,
    );


  }
}

