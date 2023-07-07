
import 'dart:typed_data';

import 'package:flutter/material.dart';

class AlbumArt extends StatelessWidget {
  const AlbumArt({
    Key? key, 
    this.height, 
    required this.imageData, 
  }) : super(key: key); 
  
  final Uint8List? imageData; 
  final double? height; 
  final double? musicNoteSize = 100; 
  final double borderRadius = 10; 

  Widget getImage(Uint8List? imageData) {
    if (imageData != null) {
      return Image.memory(imageData); 
      
    } else {
      return Container(
        height: height,
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
      ); 
    }
  }

  double getLength(double a, double b) {
    return a * b; 
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: getImage(imageData),
    ); 
  }
}

