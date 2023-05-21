import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import '../../domain/domain.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart; 
import 'package:path/path.dart'; 

import 'widgets/widgets.dart'; 

// TODO: continue this:  https://youtu.be/DIqB8qEZW1U?t=214
// TODO: Implement getting metadata for title and suchs

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({Key? key}) : super(key: key);

  @override
  State<AudioPlayerPage> createState() => _ControlsPageState();
}

class _ControlsPageState extends State<AudioPlayerPage> {
  AudioPlayer audioPlayer = AudioPlayer(); 
  dynamic getArguments = Get.arguments; 
  late List<Song> songs = getArguments; 

  @override
  void initState() {
    super.initState(); 
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          for (Song song in songs)
            AudioSource.file(
              song.url, 
              tag: song.getMetadata()
            ),
        ],
      ),
    );
    // _init(); 
  }

  // Future<void> _init() async {
  //   await audioPlayer.setLoopMode(LoopMode.all); 
  //   await audioPlayer.setAudioSource(source); 
  // }

  @override
  void dispose() {
    audioPlayer.dispose(); 
    super.dispose(); 
  }

  Stream<SeekBarData> get _seekBarDataStream => 
    rxdart.Rx.combineLatest3<Duration, Duration, Duration?, SeekBarData>(
      audioPlayer.positionStream, 
      audioPlayer.bufferedPositionStream, 
      audioPlayer.durationStream, 
      (Duration position, Duration bufferedPosition, Duration? duration) {
        return SeekBarData(
          position, 
          bufferedPosition, 
          duration ?? Duration.zero); 
      }, 
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand, 
        children: [
          // Gets the Metadata of the current song. 
          StreamBuilder<SequenceState?>(
            stream: audioPlayer.sequenceStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final SequenceState? state = snapshot.data; 
                if (state?.sequence.isEmpty ?? true) {
                  return const AlbumArt(imageData: null); 
                }
                final Metadata metadata = state!.currentSource!.tag as Metadata; 
                return AlbumArt(
                  imageData: metadata.albumArt,
                );
              }
              return const Placeholder(); 
            },
          ), 
          const _BackgroundFilter(), 
          _Controls(
            seekBarDataStream: _seekBarDataStream, 
            audioPlayer: audioPlayer
          )
        ],
      )
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({
    Key? key, 
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
  }) : _seekBarDataStream = seekBarDataStream, 
        super(key: key);

  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0, 
        vertical: 40.0
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end, 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: song == null ? null : song!.getMetadata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String? fileName = basenameWithoutExtension(song!.url); 
                return Text(
                  fileName, 
                  style: Theme.of(context)
                  .textTheme
                  .headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold, 
                  ),
                );
              } else {
                return const Placeholder(); 
              }
            }
          ),
          const SizedBox(height: 30), 
          SeekBar(
            seekBarDataStream: _seekBarDataStream, 
            audioPlayer: audioPlayer
          ), 
          PlayerButtons(audioPlayer: audioPlayer)
        ],
      ),
    );
  }
}



class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter, 
          colors: [
            Colors.white, 
            Colors.white.withOpacity(0.5), 
            Colors.white.withOpacity(0.0), 
          ],
          stops: const [
              0.0, 
              0.4, 
              0.6
            ]
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter, 
            colors: [
              Colors.deepPurple.shade200, 
              Colors.deepPurple.shade800,
            ]
          )
        ),
      ),
    );
  }
}

