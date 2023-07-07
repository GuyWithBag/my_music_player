import 'package:flutter/material.dart'; 
import 'package:just_audio/just_audio.dart';
import '../../../widgets/widgets.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({
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


