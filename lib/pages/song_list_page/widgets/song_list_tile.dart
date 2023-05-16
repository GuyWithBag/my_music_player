import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';

import '../../../domain/audio_player.dart';
import 'package:path/path.dart'; 

class SongListTile extends StatelessWidget {
  final Song song; 
  const SongListTile({
    Key? key, 
    required this.song, 
  }) : super(key: key); 

  Widget _songAlbumArt(Metadata metadata) {
    Uint8List? albumArt = metadata.albumArt; 
    if (albumArt != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          albumArt
        ),
      ); 
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.grey, 
          alignment: Alignment.center,
          child: const Icon(
            Icons.hourglass_empty
          )
        ),
      ); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/AudioPlayer', arguments: song); 
      },
      child: FutureBuilder(
        future: song.getMetadata(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Metadata data = snapshot.data!; 
            return Container(
              height: 75, 
              margin: const EdgeInsets.only(bottom: 10), 
              padding: const EdgeInsets.symmetric(horizontal: 20), 
              decoration: const BoxDecoration(
                color: Colors.blue, 
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 70, 
                    child: _songAlbumArt(data)
                  ), 
                  const SizedBox(
                    width: 15,
                  ), 
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300, 
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            basenameWithoutExtension(song.url),
                            maxLines: 2, 
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ), 
                        Text(
                          data.authorName ?? "Unknown Artist", 
                          maxLines: 2, 
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Placeholder();
          }
        }
      ),
    );
  }
}

