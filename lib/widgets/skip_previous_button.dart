import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SkipPreviousButton extends StatelessWidget {
  const SkipPreviousButton({
    super.key,
    required this.audioPlayer,
    this.iconsSize,
  });

  final AudioPlayer audioPlayer;
  final double? iconsSize;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>( 
      stream: audioPlayer.sequenceStateStream,
      builder: (BuildContext context, index) {
        return IconButton(
          iconSize: iconsSize,
          onPressed:  audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null, 
          icon: const Icon(
            Icons.skip_previous, 
            color: Colors.white,
          )
        );
      } 
    );
  }
}
