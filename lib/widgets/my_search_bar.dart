import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    required this.textFormField,
    required this.textEditingController, 
    this.onClearAllPressed, 
  });

  final TextEditingController textEditingController; 
  final void Function()? onClearAllPressed; 
  final Widget textFormField; 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.search), 
        const SizedBox(width: 20), 
        SizedBox(
          width: 200, 
          child: textFormField, 
        ), 
        Visibility(
          visible: textEditingController.text.isNotEmpty,
          child: IconButton(
            onPressed: () {
              textEditingController.clear(); 
              if (onClearAllPressed != null) {
                onClearAllPressed!(); 
              }
            },
            icon: const Icon(Icons.cancel)
          ),
        )
      ],
    );
  }
}