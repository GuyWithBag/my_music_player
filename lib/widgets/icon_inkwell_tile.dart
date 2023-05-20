import 'package:flutter/material.dart';

class IconInkWellTile extends StatelessWidget {
  const IconInkWellTile({
    Key? key, 
    required this.icon, 
    required this.text, 
    required this.onTap, 
  }) : super(key: key); 

  final Icon icon; 
  final Text text;  
  final Function()? onTap; 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          height: 30,
          child: Row(
            children: [
              SizedBox(
                child: icon,
              ), 
              const SizedBox(width: 20,), 
              text
            ],
          ),
        ),
      ),
    );
  }
}