
import 'package:flutter/material.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import '../../../domain/audio_player.dart';


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
      onTap: () {},
      header: songAlbum.name,
      subHeader: "${songAlbum.artistName} - ${songAlbum.songs.length} songs",
      containerHeight: containerHeight,
      thumbnail: const Icon(Icons.hourglass_empty),
      thumbnailSize: thumbnailSize, 
      thumbnailBorderRadius: thumbnailBorderRadius,
    );


  }
}

