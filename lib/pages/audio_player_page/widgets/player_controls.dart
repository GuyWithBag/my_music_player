import 'package:flutter/material.dart'; 
import 'package:just_audio/just_audio.dart';
import '../../../widgets/widgets.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer; 
  final double? iconsSize = 44; 
  final double? adjustedIconSize = 30; 
  final double? playerButtonIconSize = 67; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: playerButtonIconSize, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              
            },
            iconSize: adjustedIconSize,
            icon: const Icon(
              Icons.loop, 
              color: Colors.white, 
            ),
          ), 
          const Spacer(), 
          SkipPreviousButton(
            audioPlayer: audioPlayer, 
            iconsSize: iconsSize
          ),
          const Spacer(), 
          PlayerButton(
            audioPlayer: audioPlayer, 
            playerButtonIconSize: playerButtonIconSize, 
            proccesingStateIcon: const CircularProgressIndicator(), 
            playingIcon: const Icon( 
              Icons.play_circle, 
              color: Colors.white, 
            ),
            pauseIcon: const Icon(
              Icons.pause_circle, 
              color: Colors.white, 
            ), 
            completedIcon: const Icon(
              Icons.pause_circle, 
              color: Colors.white, 
            ), 
            seekIcon: const Icon(
              Icons.replay_circle_filled_outlined, 
              color: Colors.white,
            ),
          ), 
          const Spacer(), 
          SkipNextButton(
            audioPlayer: audioPlayer, 
            iconsSize: iconsSize
          ),
          const Spacer(), 
          IconButton(
            iconSize: adjustedIconSize, 
            onPressed: () {
              
            }, 
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

