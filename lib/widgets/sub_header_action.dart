import 'package:flutter/material.dart';

class SubHeaderAction extends StatelessWidget {
  const SubHeaderAction({
    Key? key, 
    required this.icon, 
    required this.onTap, 
  }) : super(key: key);

  final Icon icon; 
  final Function()? onTap; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: InkWell(
        onTap: onTap,
        child: icon
      ),
    );
  }
}