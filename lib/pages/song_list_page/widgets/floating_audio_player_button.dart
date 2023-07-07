import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/theme/theme.dart';
import 'package:my_music_player/widgets/widgets.dart';

class FloatingAudioPlayerButton extends StatelessWidget {
  const FloatingAudioPlayerButton({
    super.key, 
    required this.onTap, 
    required this.audioPlayer, 
    required this.active,
  });

  final Function() onTap; 
  final AudioPlayer? audioPlayer; 
  final bool active; 

  @override
  Widget build(BuildContext context) {
    if (audioPlayer == null) {
      return const SizedBox(); 
    }
    return InkWell( 
      onTap: onTap,
      child: AudioPlayerSongBuilder(
        audioPlayer: audioPlayer!, 
        builder: (BuildContext context, Song? song, Metadata? metadata) {
          return _Container(
            decoration: backgroundDecoration, 
            children: [
              SongThumbnail(
                thumbnail: getSongAlbumArt(metadata), 
                borderRadius: 8, 
                width: 50,
              ), 
              const SizedBox(width: 10), 
              Expanded(
                child: _Details(
                  metadata: metadata, 
                  song: song,
                ),
              ), 
              PlayerButton(
              audioPlayer: audioPlayer!, 
              proccesingStateIcon: const CircularProgressIndicator(), 
              playingIcon: const Icon( 
                Icons.play_arrow, 
                color: Colors.white, 
              ),
              pauseIcon: const Icon(
                Icons.pause, 
                color: Colors.white, 
              ), 
              completedIcon: const Icon(
                Icons.pause, 
                color: Colors.white, 
              ), 
              seekIcon: const Icon(
                Icons.replay, 
                color: Colors.white,
              ),
            )
            ],
          );
        }
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({
    Key? key,
    required this.metadata, 
    required this.song,
  }) : super(key: key);

  final Metadata? metadata; 
  final Song? song; 

  @override
  Widget build(BuildContext context) {
    final TextStyle? songHeaderStyle = Theme.of(context)
      .textTheme
      .labelMedium; 
    return SizedBox(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
                  AutomaticMarqueeText(
                    marquee: Marquee(
                      text: Song.getNullSafeName(song), 
                      style: songHeaderStyle, 
                      blankSpace: 40, 
                      startAfter: const Duration(seconds: 1), 
                      fadingEdgeStartFraction: 0.1,
                      fadingEdgeEndFraction: 0.1,
                    ), 
                    context: context, 
                    maxWidth: constraints.maxWidth,  //constraints.maxWidth - (), 
                    text: Song.getNullSafeName(song), 
                    style: songHeaderStyle, 
                    textAlign: TextAlign.left,
              ),
              Text(
                Song.nullSafeArtistNamesToReadable(metadata), 
                style: Theme.of(context)
                            .textTheme
                            .labelSmall,
                maxLines: 1,
              ), 
            ],
          );
        }
      ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    Key? key, 
    required this.children, 
    required this.decoration, 
  }) : super(key: key); 

  final List<Widget> children; 
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: decoration, 
        height: 70,
        width: MediaQuery.of(context).size.width - 15,
        child: Padding(
          padding: const EdgeInsets.all(8), 
          child: Row(
            children: children
          ),
        ),
      ),
    );
  }
}

