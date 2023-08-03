import 'package:flutter/material.dart';

class SongTileDraggableScrollSheetButton extends StatelessWidget {
  const SongTileDraggableScrollSheetButton({
    super.key, 
    required this.icon, 
    required this.leading,
    this.onPressed, 
  });

  final void Function()? onPressed; 
  final Widget icon; 
  final String leading; 

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      style: const ButtonStyle(
        elevation: MaterialStatePropertyAll<double>(0), 
      ),
      child: Row(
        children: [
          icon, 
          const SizedBox(width: 20), 
          Text(
            leading
          ), 
        ],
      ),
    );
  }
}