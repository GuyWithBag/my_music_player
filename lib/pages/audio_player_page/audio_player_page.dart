
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:my_music_player/pages/song_queue_page/song_queue_page.dart';
import 'package:my_music_player/theme/theme.dart';
import 'package:my_music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../domain/domain.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart; 
import 'package:path/path.dart'; 
import '../../providers/providers.dart'; 

import 'widgets/widgets.dart'; 

class AudioPlayerPage extends StatelessWidget {
  const AudioPlayerPage({
    Key? key
  }) : super(key: key);
  
  final double _mainGUIPadding = 30; 
  final double _appBarSize = 70; 
  final double _sheetSafeAreaOffset = 10; 

  @override
  Widget build(BuildContext context) {
    AllSongsState allSongsState = context.watch<AllSongsState>(); 
    AudioPlayerState audioPlayerState = context.watch<AudioPlayerState>();
    AudioPlayer audioPlayer = audioPlayerState.audioPlayer!; 
    final List<Song> songs = allSongsState.allSongs; 

    Stream<SeekBarData> seekBarDataStream = rxdart.Rx.combineLatest3<Duration, Duration, Duration?, SeekBarData>(
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

    return Scaffold(
      body: Container(
        decoration: backgroundDecoration,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: _mainGUIPadding, 
                right: _mainGUIPadding, 
                bottom: _mainGUIPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SafeArea(
                    child: SizedBox(
                      height: _appBarSize + _sheetSafeAreaOffset,
                    ),
                  ),
                  _MainGUI(
                    audioPlayer: audioPlayer, 
                    seekBarDataStream: seekBarDataStream, 
                    songs: songs
                  ),
                ],
              ),
            ), 
            _AudioPlayerAppBar(
              height: _appBarSize,
              sheetSafeAreaOffset: _sheetSafeAreaOffset,
              audioPlayer: audioPlayer,
              sheetContent: SongQueuePage(

              ),
              child: _SongsQueueButton(
                audioPlayer: audioPlayer, 
                height: _appBarSize,
              ),
            ),
          ],
        ),
      )
    );
  }
}

class _AudioPlayerAppBar extends StatelessWidget {
  const _AudioPlayerAppBar({
    Key? key, 
    required this.audioPlayer, 
    required this.height, 
    required this.sheetSafeAreaOffset, 
    required this.sheetContent, 
    required this.child,
  }) : super(key: key);

  final double height; 
  final AudioPlayer audioPlayer; 
  final double minChildSize = 0.11; 
  final double sheetSafeAreaOffset; 
  final Widget sheetContent; 
  final Widget child; 

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: Column(
        children: [
          Expanded(
            child: DraggableScrollableSheet(
              snap: true,
              initialChildSize: minChildSize,
              minChildSize: minChildSize,
              maxChildSize: 1,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Theme.of(context).primaryColor,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Column(
                        children: [
                          sheetContent, 
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 25, 
                              left: 8, 
                              right: 8, 
                            ),
                            child: Row(
                              children: [
                                const BackButton(), 
                                Expanded(
                                  child: child, 
                                ), 
                                SizedBox(
                                  width: 40,
                                  child: InkwellIcon(
                                    onTap: () {
                                
                                    },
                                    icon: const Icon(Icons.more_vert), 
                                  ),
                                ), 
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), 
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              color: Theme.of(context).primaryColor,
              height: sheetSafeAreaOffset,
            ),
          ),
        ],
      ),
    );
  }
}

class _SongsQueueButton extends StatelessWidget {
  const _SongsQueueButton({
    Key? key, 
    required this.audioPlayer, 
    required this.height, 
  }) : super(key: key);

  final AudioPlayer audioPlayer; 
  final double? height; 

  @override
  Widget build(BuildContext context) {
    final ConcatenatingAudioSource audioSource = (audioPlayer.audioSource as ConcatenatingAudioSource); 
    final List<AudioSource> songs = audioSource.children; 

    return InkWell(
      onTap: () {},
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor, 
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
}

class _MainGUI extends StatelessWidget {
  const _MainGUI({
    Key? key,
    required this.audioPlayer,
    required Stream<SeekBarData> seekBarDataStream,
    required this.songs,
  }) : _seekBarDataStream = seekBarDataStream, super(key: key);

  final AudioPlayer audioPlayer;
  final Stream<SeekBarData> _seekBarDataStream;
  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 15,), 
        _Controls(
          seekBarDataStream: _seekBarDataStream, 
          audioPlayer: audioPlayer, 
          songs: songs,
        )
      ],
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end, 
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleAndButtons(audioPlayer: audioPlayer),
        const SizedBox(height: 10), 
        SeekBar(
          seekBarDataStream: _seekBarDataStream, 
          audioPlayer: audioPlayer
        ), 
        PlayerButtons(audioPlayer: audioPlayer)
      ],
    );
  }
}

class TitleAndButtons extends StatelessWidget {
  const TitleAndButtons({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer; 

  Widget getAudioPlayerHeader({required String text, required double maxWidth, required BuildContext context, TextDirection textDirection = TextDirection.ltr}) {
    TextStyle style = Theme.of(context)
      .textTheme
      .titleLarge!.copyWith(
        fontWeight: FontWeight.bold, 
    ); 
    TextSpan textSpan = TextSpan(text: text, style: style); 
    double textWidth = getTextWidth(textSpan: textSpan); 
    if (textWidth >= maxWidth) {
      return SizedBox(
        height: 30,
        child: Marquee(
          text: text, 
          blankSpace: 40, 
          startAfter: const Duration(seconds: 1), 
          fadingEdgeStartFraction: 0.1,
          fadingEdgeEndFraction: 0.1,
          style: style, 
        ),
      ); 
    }
    return Text(
      text, 
      maxLines: 1, 
      style: style, 
      textAlign: TextAlign.center,
    ); 
  }

  double getTextWidth({required TextSpan textSpan, TextDirection textDirection = TextDirection.ltr}) {
    final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    tp.layout(); 
    return tp.width; 
  }

  @override
  Widget build(BuildContext context) {
    TextStyle songNameStyle = Theme.of(context)
      .textTheme
      .titleLarge!.copyWith(
        fontWeight: FontWeight.bold, 
    ); 
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
                      AutomaticMarqueeText(
                        marquee: Marquee(
                          text: song.name, 
                          style: songNameStyle, 
                          blankSpace: 40, 
                          startAfter: const Duration(seconds: 1), 
                          fadingEdgeStartFraction: 0.1,
                          fadingEdgeEndFraction: 0.1,
                        ),
                        context: context, 
                        text: song.name, 
                        maxWidth: MediaQuery.of(context).size.width, 
                        style: songNameStyle, 
                        maxLines: 1,
                        textAlign: TextAlign.center, 
                      ), 
                      const SizedBox(height: 5), 
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

