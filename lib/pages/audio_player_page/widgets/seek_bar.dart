import 'dart:math';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SeekBarData {
  const SeekBarData(
    this.position, 
    this.bufferedPosition, 
    this.duration, 
  ); 
  final Duration position; 
  final Duration bufferedPosition; 
  final Duration duration; 
}

class SeekBar extends StatefulWidget {
  const SeekBar({
    Key? key, 
    this.onChanged, 
    this.onChangedEnd, 
    required this.seekBarDataStream, 
    required this.audioPlayer, 
  }) : super(key: key); 

  final ValueChanged<Duration>? onChanged; 
  final ValueChanged<Duration>? onChangedEnd; 

  final AudioPlayer audioPlayer; 
  final Stream<SeekBarData> seekBarDataStream; 
  

  @override 
  State<SeekBar> createState() => _SeekBarState(); 
}

class _SeekBarState extends State<SeekBar> {
  // String _formatDuration(Duration? duration) {
  //   if (duration == null) {
  //     return "--:--"; 
  //   } else {
  //     String minutes = duration.inMinutes.toString().padLeft(2, '0'); 
  //     String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0'); 
  //     return "$minutes:$seconds"; 
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SeekBarData>( 
      stream: widget.seekBarDataStream,
      builder: (BuildContext context, AsyncSnapshot<SeekBarData> snapshot) {
        final seekBarData = snapshot.data; 
        return ProgressBar(
          thumbColor: Theme.of(context).primaryColorLight, 
          progressBarColor: Theme.of(context).primaryColor,
          progress: seekBarData?.position ?? Duration.zero, 
          buffered: seekBarData?.bufferedPosition ?? Duration.zero, 
          total: seekBarData?.duration ?? Duration.zero,
          onSeek: widget.audioPlayer.seek,
        ); 

      }
    ); 
  }

}


