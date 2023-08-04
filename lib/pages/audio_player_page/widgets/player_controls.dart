import 'package:flutter/material.dart'; 
import 'package:just_audio/just_audio.dart';
import 'package:my_music_player/providers/providers.dart';
import 'package:provider/provider.dart';
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
    SongQueueProvider songQueueProvider = context.watch<SongQueueProvider>();  
    return SizedBox(
      height: playerButtonIconSize, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepeatButton(
            audioPlayer: audioPlayer, 
            iconSize: adjustedIconSize
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
              songQueueProvider.shuffle(); 
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

class RepeatButton extends StatelessWidget {
  const RepeatButton({
    super.key,
    required this.audioPlayer,
    required this.iconSize,
  });

  final AudioPlayer audioPlayer;
  final double? iconSize; 

  Widget _whichIcon(AudioPlayer audioPlayer) {
    switch (audioPlayer.loopMode) {
      case LoopMode.off: 
        return const Icon(
          Icons.repeat, 
          color: Colors.grey,
        ); 
      case LoopMode.one: 
        return const Icon(Icons.repeat_one); 
      case LoopMode.all: 
        return const Icon(Icons.repeat); 
    }
  }

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider = context.watch<AudioPlayerProvider>(); 
    return IconButton(
      onPressed: () {
        switch (audioPlayer.loopMode) {
          case LoopMode.off: 
            audioPlayerProvider.setLoopMode(LoopMode.all); 
            break; 
          case LoopMode.one: 
            audioPlayerProvider.setLoopMode(LoopMode.off); 
            break; 
          case LoopMode.all: 
            audioPlayerProvider.setLoopMode(LoopMode.one); 
            break;
        }
        
      },
      iconSize: iconSize,
      icon: _whichIcon(audioPlayer),
    );
  }
}

