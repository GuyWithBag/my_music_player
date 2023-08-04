import 'package:flutter/material.dart';
import 'package:my_music_player/theme/theme.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({
    super.key, 
    required this.child, 
    this.padding
  }); 

  final Widget child; 
  final EdgeInsets? padding; 

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: backgroundDecoration, 
        padding: padding, 
        child: child,
      ),
    );
  }
}