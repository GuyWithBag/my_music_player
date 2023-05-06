
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
    return Image.memory(
      imageData!, 
      height: 256, 
      width: 256,
    ); 
  }
}

