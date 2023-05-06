import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import '../../domain/domain.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart; 

import 'widgets/widgets.dart'; 

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({Key? key}) : super(key: key);

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  AudioPlayer audioPlayer = AudioPlayer(); 
  Song song = Get.arguments; 
  late Future<Metadata> metadata = song.metadata; 

  @override
  void initState() {
    super.initState(); 

    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${song.url}')
          ),
        ],
      ),
    ); 
  }

  @override
  void dispose() {
    audioPlayer.dispose(); 
    super.dispose(); 
  }

  Stream<SeekBarData> get _seekBarDataStream => 
  rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
    audioPlayer.positionStream, 
    audioPlayer.durationStream, 
    (Duration position, Duration? duration) {
      return SeekBarData(position, duration ?? Duration.zero); 
    }
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
          FutureBuilder(
            future: metadata,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Metadata? data; 
                data = snapshot.data; 
                return AlbumArt(
                  imageData: data?.albumArt,
                );
              }
              return const Placeholder(); 
            },
          ), 
          const _BackgroundFilter(), 
          _AudioPlayer(
            song: song, 
            seekBarDataStream: _seekBarDataStream, 
            audioPlayer: audioPlayer
          )
        ],
      )
    );
  }
}

class _AudioPlayer extends StatelessWidget {
  const _AudioPlayer({
    Key? key, 
    required this.song, 
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
  }) : _seekBarDataStream = seekBarDataStream, 
        super(key: key);

  final Song song; 
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
            future: song.getMetadata(),
            builder: (context, snapshot) {
              Metadata? data = snapshot.data; 
              String albumArtistName = data!.albumArtistName ?? "Missing Name"; 
              return Text(
                 albumArtistName, 
                style: Theme.of(context)
                .textTheme
                .headlineSmall!.copyWith(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold, 
                ),
              );
            }
          ),
          const SizedBox(height: 30), 
          StreamBuilder(
            stream: _seekBarDataStream,
            builder: 
              (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  position: positionData?.position ?? Duration.zero, 
                  duration: positionData?.duration ?? Duration.zero, 
                  onChangedEnd: audioPlayer.seek,
                );
              },
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

