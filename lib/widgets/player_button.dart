import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'widgets.dart';

class PlayerButton extends StatelessWidget {
  const PlayerButton({
    super.key,
    required this.audioPlayer, 
    this.playerButtonIconSize, 
    required this.proccesingStateIcon, 
    required this.playingIcon, 
    required this.completedIcon, 
    required this.pauseIcon, 
    required this.seekIcon,
  }); 

  final AudioPlayer audioPlayer;
  final double? playerButtonIconSize; 
  final Widget proccesingStateIcon; 
  final Widget playingIcon; 
  final Widget completedIcon; 
  final Widget pauseIcon; 
  final Widget seekIcon; 

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
              icon: proccesingStateIcon,  // CircularProgressIndicator(),
            );
          } else if (!audioPlayer.playing) {
            return InkwellIcon(
              height: playerButtonIconSize,
              width: playerButtonIconSize,
              onTap: () {
                audioPlayer.play(); 
                // TODO: Add code that increments the song's timesPlayed
              }, 
              icon: playingIcon, /* const Icon(
                Icons.play_circle, 
                color: Colors.white, 
              ), */
            ); 
          } else if (processingState != ProcessingState.completed) {
            return InkwellIcon(
              height: playerButtonIconSize,
              width: playerButtonIconSize,
              onTap: audioPlayer.pause,
              icon: pauseIcon/* const Icon(
                Icons.pause_circle, 
                color: Colors.white, 
              ), */
            ); 
          } else {
            return InkwellIcon(
              height: playerButtonIconSize,
              width: playerButtonIconSize,
              onTap: () => audioPlayer.seek(
                Duration.zero, 
                index: audioPlayer.effectiveIndices!.first, 
              ), 
              icon: seekIcon /* const Icon(
                Icons.replay_circle_filled_outlined, 
                color: Colors.white,
              ), */
            ); 
          } 
        } else {
          return proccesingStateIcon; // const CircularProgressIndicator();
        }
      }, 
    );
  }
}