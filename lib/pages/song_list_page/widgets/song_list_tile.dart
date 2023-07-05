import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../domain/audio_player.dart';
import 'package:path/path.dart'; 

// The purpose of this is to use the SongTile widget as just a gui and so that this can use FutureBuilder while allowing you to reuse SongTile for other widgets. 

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

  Widget _songAlbumArt(Metadata? metadata) {
    
    if ( metadata != null) {
      Uint8List? albumArt = metadata.albumArt; 
      if (albumArt == null) {
        return const Icon(Icons.music_note); 
      }
      return Image.memory(albumArt); 
    } else {
      return const Icon(Icons.music_note); 
    }
  }

  @override
  Widget build(BuildContext context) {
    AllSongsState allSongsState = context.watch<AllSongsState>(); 
    final List<Song> songs = allSongsState.allSongs; 
    final Song currentSong = songs[currentSongIndex]; 
    return FutureBuilder(
      future: currentSong.getMetadata(),
      builder: (context, snapshot) {
        Metadata? data; 
        if (snapshot.hasData) {
          data = snapshot.data!; 
        }
        return SongTile(
          onTap: () {
            allSongsState.startAudioPlayer(songs, currentSongIndex); 
            Get.toNamed( '/AudioPlayer'); 
          },
          header: snapshot.hasData ? currentSong.name : "Null",
          subHeader: data != null ? data.trackArtistNames?.join(", ") ?? "Unknown Artist" : "Unknown Artist", 
          thumbnail: _songAlbumArt(data), 
          index: currentSongIndex,
          thumbnailSize: thumbnailSize,
          thumbnailBorderRadius: thumbnailBorderRadius,
          containerHeight: 75,  
        );
      }
    );
  }
}




