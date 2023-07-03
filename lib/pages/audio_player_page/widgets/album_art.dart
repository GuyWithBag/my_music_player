
import 'dart:typed_data';

import 'package:flutter/material.dart';

class AlbumArt extends StatelessWidget {
  const AlbumArt({
    Key? key, 
    required this.imageData, 
  }) : super(key: key); 

  final Uint8List? imageData; 
  final double? size = 280; 
  final double? musicNoteSize = 100; 
  final double borderRadius = 10; 

  @override
  Widget build(BuildContext context) {
    if (imageData != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.memory(
          imageData! 
        ),
      ); 
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: size,
          height: size,
          color: Colors.grey, 
          alignment: Alignment.center,
          child: SizedBox(
            height: musicNoteSize, 
            width: musicNoteSize,
            child: const FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                Icons.music_note
              ),
            ),
          )
        ),
      ); 
    }
  }
}

