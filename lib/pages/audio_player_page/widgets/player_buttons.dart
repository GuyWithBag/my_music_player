import 'package:flutter/material.dart'; 
import 'package:just_audio/just_audio.dart';
import 'package:my_music_player/widgets/inkwell_icon.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer; 
  final double? iconsSize = 45; 
  final double? adjustedIconSize = 30; 
  final double? playerButtonIconSize = 67; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: playerButtonIconSize, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkwellIcon(
            height: adjustedIconSize,
            width: adjustedIconSize,
            icon: const Icon(
              Icons.loop, 
              color: Colors.white, 
            ),
          ), 
          const Spacer(), 
          StreamBuilder<SequenceState?>( 
            stream: audioPlayer.sequenceStateStream,
            builder: (BuildContext context, index) {
              return InkwellIcon(
                height: iconsSize,
                width: iconsSize,
                onTap:  audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null, 
                icon: const Icon(
                  Icons.skip_previous, 
                  color: Colors.white,
                )
              );
            }
          ),
          const Spacer(), 
          PlayerButton(
            audioPlayer: audioPlayer, 
            playerButtonIconSize: playerButtonIconSize,
          ), 
          const Spacer(), 
          StreamBuilder<SequenceState?>(
            stream: audioPlayer.sequenceStateStream,
            builder: (BuildContext context, index) {
              return InkwellIcon(
                height: iconsSize, 
                width: iconsSize, 
                onTap: audioPlayer.hasNext ? audioPlayer.seekToNext : null, 
                icon: const Icon(
                  Icons.skip_next, 
                  color: Colors.white,
                )
              );
            }
          ),
          const Spacer(), 
          InkwellIcon(
            height: adjustedIconSize,
            width: adjustedIconSize,
            icon: const Icon(
              Icons.shuffle, 
              color: Colors.white, 
            ),
          ), 
        ],
      ),
    );
  }
}

class PlayerButton extends StatelessWidget {
  const PlayerButton({
    super.key,
    required this.audioPlayer, 
    this.playerButtonIconSize,
  });

  final AudioPlayer audioPlayer;
  final double? playerButtonIconSize;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          final playerState = snapshot.data;  
          final processingState = playerState!.processingState; 
    
          if (processingState == ProcessingState.loading || 
            processingState == ProcessingState.buffering) {
            return InkwellIcon(
              width: playerButtonIconSize,
              height: playerButtonIconSize, 
              icon: const CircularProgressIndicator(),
            );
          } else if (!audioPlayer.playing) {
            return InkwellIcon(
              height: playerButtonIconSize,
              width: playerButtonIconSize,
              onTap: audioPlayer.play, 
              icon: const Icon(
                Icons.play_circle, 
                color: Colors.white, 
              ),
            ); 
          } else if (processingState != ProcessingState.completed) {
            return InkwellIcon(
              height: playerButtonIconSize,
              width: playerButtonIconSize,
              onTap: audioPlayer.pause,
              icon: const Icon(
                Icons.pause_circle, 
                color: Colors.white, 
              ),
            ); 
          } else {
            return InkwellIcon(
              height: playerButtonIconSize,
              width: playerButtonIconSize,
              onTap: () => audioPlayer.seek(
                Duration.zero, 
                index: audioPlayer.effectiveIndices!.first, 
              ), 
              icon: const Icon(
                Icons.replay_circle_filled_outlined, 
                color: Colors.white,
              )
            ); 
          } 
        } else {
          return const CircularProgressIndicator();
        }
      }, 
    );
  }
}
