import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:my_music_player/pages/song_queue_page/song_queue_page.dart';
import 'package:my_music_player/theme/theme.dart';
import 'package:my_music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../domain/domain.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart; 
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
    AllSongsProvider allSongsState = context.watch<AllSongsProvider>(); 
    AudioPlayerProvider audioPlayerState = context.watch<AudioPlayerProvider>();
    AudioPlayer audioPlayer = audioPlayerState.audioPlayer!; 
    final List<Song> songs = allSongsState.items; 

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
        child: ChangeNotifierProvider(
          create: (context) => AppBarController(), 
          child: Builder(
            builder: (context) {
              AppBarController appBarController = context.watch<AppBarController>(); 
              return Stack(
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
                    audioPlayer: audioPlayer,
                    controller: appBarController.controller, 
                    sheetContent: const SongQueuePage(), 
                    sheetSafeAreaOffset: null,
                    child: _SongsQueueButton(
                      audioPlayer: audioPlayer, 
                      height: _appBarSize, 
                      onTap: () {
                        final DraggableScrollableController controller = appBarController.controller; 
                        Duration duration = const Duration(milliseconds: 400); 
                        if (controller.size >= 1) {
                          controller.animateTo(
                            0, 
                            duration: duration, 
                            curve: Curves.fastEaseInToSlowEaseOut, 
                          ); 
                          return; 
                        }
                        controller.animateTo(
                          1, 
                          duration: duration, 
                          curve: Curves.decelerate, 
                        ); 
                      }, 
                    ),
                  ),
                ],
              );
            }
          ),
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
    required this.sheetContent, 
    required this.child,
    this.sheetSafeAreaOffset, 
    required this.controller, 
  }) : super(key: key);

  final double height; 
  final AudioPlayer audioPlayer; 
  final double minChildSize = 0.11; 
  final double? sheetSafeAreaOffset; 
  final Widget sheetContent; 
  final Widget child; 
  final DraggableScrollableController controller; 

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
              controller: controller, 
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
    this.onTap, 
  }) : super(key: key);

  final AudioPlayer audioPlayer; 
  final double? height; 
  final void Function()? onTap; 

  @override
  Widget build(BuildContext context) {
    final ConcatenatingAudioSource audioSource = (audioPlayer.audioSource as ConcatenatingAudioSource); 
    final List<AudioSource> songs = audioSource.children; 

    return InkWell(
      onTap: onTap,
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
                    return AlbumArt(
                      imageData: metadata!.albumArt, 
                      height: 300,
                    ); 
                  } else {
                    return const AlbumArt(
                      imageData: null, 
                      height: 300,
                    ); 
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
        PlayerControls(audioPlayer: audioPlayer)
      ],
    );
  }
}

class AppBarController extends ChangeNotifier {
  DraggableScrollableController controller = DraggableScrollableController(); 

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

