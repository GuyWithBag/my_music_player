import 'dart:ui';

import 'package:flutter/material.dart';
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
  final double _songQueueButtonSize = 70; 
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
      body: AudioPlayerSongBuilder(
        audioPlayer: audioPlayer,
        builder: (context, Song? song) {
          return Container(
            decoration: backgroundDecoration, 
            child: ChangeNotifierProvider(
              create: (context) => AppBarController(), 
              child: Builder(
                builder: (context) {
                  AppBarController appBarController = context.watch<AppBarController>(); 
                  return Stack(
                    fit: StackFit.expand, 
                    children: [
                      ...getFilteredSongAlbumArt(
                        song, 
                        filter: ImageFilter.blur(sigmaX: 450, sigmaY: 100), 
                      ), 
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
                                height: _songQueueButtonSize + _sheetSafeAreaOffset,
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
                      AudioPlayerAppBar(
                        audioPlayer: audioPlayer,
                        controller: appBarController.controller, 
                        color: song == null || song.metadata.albumArt == null ? null : Colors.transparent, 
                        sheetContent: SizedBox(
                          height: MediaQuery.of(context).size.height - (_songQueueButtonSize * 2), 
                          child: const SongQueuePage(), 
                        ), 
                        sheetSafeAreaOffset: null,
                        child: SongsQueueButton(
                          audioPlayer: audioPlayer, 
                          height: _songQueueButtonSize, 
                          color: song == null || song.metadata.albumArt == null ? null : Colors.transparent, 
                          onPressed: () {
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
          );
        }
      )
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
        AudioPlayerSongBuilder(
          audioPlayer: audioPlayer,
          builder: (BuildContext context, Song? song) {
            if (song != null) {
              return AlbumArt(
                    imageData: song.metadata.albumArt, 
                    height: 300,
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

