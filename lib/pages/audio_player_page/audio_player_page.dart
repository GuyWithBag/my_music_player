import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:my_music_player/theme/theme.dart';
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
  AudioPlayerArguments getArguments = Get.arguments; 
  late List<Song> songs = getArguments.songs; 
  late int currentSongIndex = getArguments.currentSongIndex;  

  @override
  void initState() {
    super.initState(); 
    _init(); 
  }

  Future<void> _init() async {
    await audioPlayer.setLoopMode(LoopMode.all); 
    await audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          for (Song song in songs)
            AudioSource.file(
              song.url, 
              tag: song
            ),
        ],
      ), 
      initialIndex: currentSongIndex, 
    );
  }

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
        elevation: 0, 
      ),
      body: Container(
        decoration: backgroundDecoration,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            StreamBuilder(
              stream: audioPlayer.sequenceStateStream,
              builder: (BuildContext context, snapshot) {
                final SequenceState? state = snapshot.data; 
                if (snapshot.hasData) {
                  Song song = state!.currentSource!.tag; 
                  return FutureBuilder(
                    future: song.getMetadata(),
                    builder: (BuildContext context, AsyncSnapshot<Metadata> snapshot) {
                      Metadata? metadata = snapshot.data; 
                      if (snapshot.hasData) {
                        return AlbumArt(imageData: metadata!.albumArt); 
                      } else {
                        return const AlbumArt(imageData: null); 
                      }
                    },
                  ); 
                } else {
                 return const AlbumArt(imageData: null,); 
                }
              }
            ), 
            _Controls(
              seekBarDataStream: _seekBarDataStream, 
              audioPlayer: audioPlayer, 
              songs: songs,
            )
          ],
        ),
      )
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({
    Key? key, 
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
    required this.songs, 
  }) : _seekBarDataStream = seekBarDataStream, 
        super(key: key);

  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;
  final List<Song> songs; 

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
          TitleAndButtons(audioPlayer: audioPlayer),
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

class TitleAndButtons extends StatelessWidget {
  const TitleAndButtons({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: audioPlayer.sequenceStateStream,
      builder: (BuildContext context, AsyncSnapshot<SequenceState?> snapshot) {
        if (snapshot.hasData) {
          final SequenceState? state = snapshot.data; 
          Song song = state!.currentSource!.tag; 
          return Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              SizedBox(
                height: 20,
                child: InkWell(
                  onTap: () {

                  }, 
                  child: const Icon(CupertinoIcons.heart)
                ),
              ), 
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Text(
                        song.name, 
                        maxLines: 1, 
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                        .textTheme
                        .headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold, 
                        ), 
                      ), 
                      FutureBuilder(
                        future: song.getMetadata(), 
                        builder: (BuildContext context, AsyncSnapshot<Metadata> snapshot) {
                          Metadata? metadata = snapshot.data; 
                          if (snapshot.hasData) {
                            return Text(
                              Song.artistNamesToReadable(metadata!.trackArtistNames), 
                              maxLines: 1, 
                              overflow: TextOverflow.clip, 
                              style: Theme.of(context)
                                .textTheme
                                .labelSmall,
                            );
                          } else {
                            return const Text(
                              "Unknown Artist"
                            );
                          }
                        }
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                child: InkWell(
                  onTap: () {

                  }, 
                  child: const Icon(Icons.share)
                ),
              ), 
            ],
          );
        } else {
          return const Placeholder(); 
        }
      }
    );
  }
}

// class _BackgroundFilter extends StatelessWidget {
//   const _BackgroundFilter({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (rect) {
//         return LinearGradient(
//           begin: Alignment.topCenter, 
//           end: Alignment.bottomCenter, 
//           colors: [
//             Colors.white, 
//             Colors.white.withOpacity(0.5), 
//             Colors.white.withOpacity(0.0), 
//           ], 
//           stops: const [
//               0.0, 
//               0.4, 
//               0.6
//             ]
//         ).createShader(rect);
//       },
//       blendMode: BlendMode.dstOut,
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter, 
//             end: Alignment.bottomCenter, 
//             colors: [
//               Colors.deepPurple.shade200, 
//               Colors.deepPurple.shade800,
//             ]
//           )
//         ),
//       ),
//     );
//   }
// }

