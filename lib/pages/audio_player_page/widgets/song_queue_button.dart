import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SongsQueueButton extends StatelessWidget {
  const SongsQueueButton({
    Key? key, 
    required this.audioPlayer, 
    required this.height, 
    this.onPressed, 
    this.color, 
  }) : super(key: key);

  final AudioPlayer audioPlayer; 
  final double? height; 
  final void Function()? onPressed; 
  final Color? color; 

  @override
  Widget build(BuildContext context) {
    final ConcatenatingAudioSource audioSource = (audioPlayer.audioSource as ConcatenatingAudioSource); 
    final List<AudioSource> songs = audioSource.children; 

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth; 
        return ElevatedButton(
           style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.transparent), 
            padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.zero), 
          ),
          onPressed: onPressed, 
          child: Container(
            height: height, 
            width: maxWidth, 
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).primaryColor, 
              border: Border.all(
                color: Theme.of(context).primaryColorLight, 
              width: 2, 
              )
            ),
            child: StreamBuilder(
              stream: audioPlayer.sequenceStateStream,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  final SequenceState? state = snapshot.data; 
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Text(
                        "Now Playing", 
                        style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold), 
                      ), 
                      Text(
                        "${(state!.currentIndex) + 1} / ${songs.length}"
                      ), 
                    ]
                  ); 
                }
                return Text(
                  "${(audioPlayer.currentIndex ?? -1) + 1} / ${songs.length}"
                ); 
              }
            ),
          ),
        );
      }
    );
  }
}