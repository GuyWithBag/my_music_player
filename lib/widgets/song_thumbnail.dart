import 'package:flutter/material.dart';

class SongThumbnail extends StatelessWidget {
  const SongThumbnail({
    Key? key, 
    this.height, 
    this.width, 
    this.thumbnail, 
    required this.borderRadius, 

  }) : super(key: key); 

  final Widget? thumbnail; 
  final double? height; 
  final double? width; 
  final double borderRadius; 

  Color? _thumbnail() {
    if (thumbnail == null || thumbnail is Icon) {
      return Colors.grey; 
    }
    return null; 
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius), 
      child: Container(
        color: _thumbnail(), 
        alignment: Alignment.center, 
        height: height,
        width: width, 
        child: thumbnail ?? const Icon(Icons.music_note_rounded)
      ),
    );
  }
}

