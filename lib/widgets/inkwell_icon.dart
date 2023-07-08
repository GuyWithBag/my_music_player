import 'package:flutter/material.dart';
import 'package:my_music_player/theme/theme.dart';

class InkwellIcon extends StatelessWidget {
  const InkwellIcon({
    super.key, 
    this.height, 
    this.width, 
    this.onTap, 
    this.fit = BoxFit.fill, 
    required this.icon, 
  }); 

  final double? height; 
  final double? width; 
  final Widget icon; 
  final Function()? onTap; 
  final BoxFit fit; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, 
      width: width, 
      child: InkWell(
        onTap: onTap, 
        child: FittedBox(
          fit: fit,
          child: icon
        ),
      ),
    );
 }
}
