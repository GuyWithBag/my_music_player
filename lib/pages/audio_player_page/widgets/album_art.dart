
import 'dart:typed_data';

import 'package:flutter/material.dart';

class AlbumArt extends StatelessWidget {
  const AlbumArt({
    Key? key, 
    required this.imageData, 
  }) : super(key: key); 

  final Uint8List? imageData; 

  @override
  Widget build(BuildContext context) {
    if (imageData != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          imageData! 
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
}

