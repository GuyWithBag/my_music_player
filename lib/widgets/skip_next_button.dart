import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SkipNextButton extends StatelessWidget {
  const SkipNextButton({
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
          onPressed: audioPlayer.hasNext ? audioPlayer.seekToNext : null, 
          icon: const Icon(
            Icons.skip_next, 
            color: Colors.white,
          )
        );
      }
    );
  }
}