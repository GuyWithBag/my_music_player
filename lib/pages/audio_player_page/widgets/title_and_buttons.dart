import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart'; 
import 'package:provider/provider.dart'; 

import '../../../domain/domain.dart';
import '../../../providers/providers.dart';
import '../../../widgets/widgets.dart';

class TitleAndButtons extends StatelessWidget {
  const TitleAndButtons({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer; 

  @override
  Widget build(BuildContext context) {
    TextStyle songNameStyle = Theme.of(context)
      .textTheme
      .titleLarge!.copyWith(
        fontWeight: FontWeight.bold, 
    ); 
    return AudioPlayerSongBuilder(
      audioPlayer: audioPlayer,
      builder: (BuildContext context, song, metadata) {
        SongFavoritesProvider songFavoritesProvider = context.watch<SongFavoritesProvider>(); 
        return Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            SizedBox(
              height: 20,
              child: InkWell(
                onTap: () {
                  if (song == null) {
                    return; 
                  }
                  if (songFavoritesProvider.items.contains(song)) {
                    songFavoritesProvider.removeItem(song); 
                    return; 
                  }
                  songFavoritesProvider.addFavorite(song); 
                }, 
                child: songFavoritesProvider.items.contains(song) ? 
                  const Icon(CupertinoIcons.heart_fill) 
                  : 
                  const Icon(CupertinoIcons.heart)
              ),
            ), 
            Expanded(
              child: SizedBox(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          AutomaticMarqueeText(
                            marquee: Marquee(
                              text: Song.getNullSafeName(song), 
                              style: songNameStyle, 
                              blankSpace: 40, 
                              startAfter: const Duration(seconds: 1), 
                              fadingEdgeStartFraction: 0.1,
                              fadingEdgeEndFraction: 0.1,
                            ),
                            context: context, 
                            text: Song.getNullSafeName(song), 
                            maxWidth: constraints.maxWidth, 
                            style: songNameStyle, 
                            maxLines: 1,
                            textAlign: TextAlign.center, 
                          ),
                          const SizedBox(height: 5), 
                          Text(
                            Song.nullSafeArtistNamesToReadable(metadata), 
                            maxLines: 1, 
                            overflow: TextOverflow.clip, 
                            style: Theme.of(context)
                              .textTheme
                              .labelSmall,
                          ),
                        ],
                      ),
                    );
                  }
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
      }
    );
  }
}