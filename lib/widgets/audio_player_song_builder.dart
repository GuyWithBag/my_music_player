import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_music_player/widgets/song_builder.dart';

import '../domain/domain.dart';

class AudioPlayerSongBuilder extends StatelessWidget {
  const AudioPlayerSongBuilder({
    super.key, 
    required this.audioPlayer, 
    required this.builder, 
  });

  final AudioPlayer audioPlayer; 
  final Widget Function(BuildContext, Song?, Metadata?) builder; 

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioPlayer.sequenceStateStream,
      builder: (BuildContext context, snapshot) {
        SequenceState? state = snapshot.data; 
        IndexedAudioSource? source; 
        Song? song; 
        if (snapshot.hasData) {
          source = state!.currentSource; 
          if (source != null) {
            song = source.tag; 
          }
        }
        return SongBuilder(
          song: song, 
          builder: (BuildContext context, Metadata? metadata) {
            return builder(context, song, metadata); 
          }, 
        );
      }
    );
  }
}

