import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../domain/domain.dart';
import '../../../widgets/widgets.dart';

class AudioPlayerAppBar extends StatelessWidget {
  const AudioPlayerAppBar({
    Key? key, 
    required this.audioPlayer, 
    required this.sheetContent, 
    required this.child,
    this.sheetSafeAreaOffset, 
    required this.controller, 
    this.color, 
  }) : super(key: key);

  final AudioPlayer audioPlayer; 
  final double minChildSize = 0.11; 
  final double? sheetSafeAreaOffset; 
  final Widget sheetContent; 
  final Widget child; 
  final DraggableScrollableController controller; 
  final Color? color; 

  @override
  Widget build(BuildContext context) {
    return AudioPlayerSongBuilder(
      audioPlayer: audioPlayer, 
      builder: (BuildContext context, Song? song) {
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
                    return Stack(
                      children: [
                        ...getFilteredSongAlbumArt(
                          song, 
                          filter: ImageFilter.blur(sigmaX: 450, sigmaY: 100), 
                        ), 
                        Container(
                          color: color ?? Theme.of(context).primaryColor, 
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
                                          child: IconButton(
                                            onPressed: () {
                                        
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
                        ),
                      ],
                    );
                  },
                ),
              ),
              SafeArea(
                child: Container(
                  height: sheetSafeAreaOffset,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}