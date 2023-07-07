import 'package:flutter/material.dart';

class SongThumbnail extends StatelessWidget {
  const SongThumbnail({
    Key? key, 
    this.height, 
    this.width, 
    required this.thumbnail, 
    required this.borderRadius, 

  }) : super(key: key); 

  final Widget thumbnail; 
  final double? height; 
  final double? width; 
  final double borderRadius; 

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius), 
      child: Container(
        color: Colors.grey, 
        alignment: Alignment.center, 
        height: height,
        width: width, 
        child: thumbnail
      ),
    );
  }
}

