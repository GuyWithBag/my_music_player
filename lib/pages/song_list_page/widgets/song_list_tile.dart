import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';

import '../../../domain/audio_player.dart';
import 'package:path/path.dart'; 

class SongListTile extends StatelessWidget {
  const SongListTile({
    Key? key, 
    required this.song, 
  }) : super(key: key);

  final Song song; 
  final double thumbnailSize = 60; 
  final double thumbnailBorderRadius = 8; 

  Widget _songAlbumArt(Metadata metadata) {
    Uint8List? albumArt = metadata.albumArt; 
    if (albumArt != null) {
      return Image.memory(
        albumArt
      ); 
    } else {
      return const Icon(
          Icons.hourglass_empty
      ); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: song.getMetadata(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Metadata data = snapshot.data!; 
          return SongTile(
            onTap: () {
              Get.toNamed('/AudioPlayer', arguments: song); 
            },
            header: basenameWithoutExtension(song.url),
            subHeader: data.authorName ?? "Unknown Artist", 
            thumbnail: _songAlbumArt(data), 
            thumbnailSize: thumbnailSize,
            thumbnailBorderRadius: thumbnailBorderRadius,
            containerHeight: 75,
          );
        } else {
          return const Placeholder();
        }
      }
    );
  }
}



