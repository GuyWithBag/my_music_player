import 'package:flutter/material.dart';
import 'package:my_music_player/theme/theme.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({
    super.key, 
    required this.child
  }); 

  final Widget child; 

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: backgroundDecoration,
        child: child,
      ),
    );
  }
}