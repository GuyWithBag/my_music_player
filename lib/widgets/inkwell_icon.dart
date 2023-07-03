import 'package:flutter/material.dart';

class InkwellIcon extends StatelessWidget {
  const InkwellIcon({
    super.key, 
    this.height, 
    this.width, 
    required this.icon, 
    this.onTap
  }); 

  final double? height; 
  final double? width; 
  final Widget icon; 
  final Function()? onTap; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, 
      width: width, 
      child: InkWell(
        onTap: onTap, 
        child: FittedBox(
          fit: BoxFit.fill,
          child: icon
        ),
      ),
    );
 }
}
