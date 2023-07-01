import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../domain/audio_player.dart';
import 'package:path/path.dart'; 

class SongListTile extends StatelessWidget {
  const SongListTile({
    Key? key, 
    required this.songs, 
    required this.currentSongIndex, 
  }) : super(key: key);

  final List<Song> songs; 
  final int currentSongIndex;  

  final double thumbnailSize = 60; 
  final double thumbnailBorderRadius = 5; 

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
    final List<Song> songs = context.watch<AllSongsState>().allSongs; 
    final Song currentSong = songs[currentSongIndex]; 
    return FutureBuilder(
      future: currentSong.getMetadata(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Metadata data = snapshot.data!; 
          return SongTile(
            onTap: () {
              Get.toNamed(
              '/AudioPlayer', 
              arguments: AudioPlayerArguments(
                songs: songs, 
                currentSongIndex: currentSongIndex
                )
              ); 
            },
            header: currentSong.name,
            subHeader: data.trackArtistNames?.join(", ") ?? "Unknown Artist", 
            thumbnail: _songAlbumArt(data), 
            thumbnailSize: thumbnailSize,
            thumbnailBorderRadius: thumbnailBorderRadius,
            containerHeight: 75,
          );
        } else {
          return SongTile(
            onTap: () {
              Get.toNamed(
              '/AudioPlayer', 
              arguments: AudioPlayerArguments(
                songs: songs, 
                currentSongIndex: currentSongIndex
                )
              ); 
            },
            header: "Null",
            subHeader: "Unknown Artist", 
            thumbnail: const Icon(
              Icons.hourglass_empty
            ), 
            thumbnailSize: thumbnailSize,
            thumbnailBorderRadius: thumbnailBorderRadius,
            containerHeight: 75,
          );
        }
      }
    );
  }
}




