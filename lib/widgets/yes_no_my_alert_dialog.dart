import 'package:flutter/material.dart';
import 'widgets.dart';

class YesNoMyAlertDialog extends StatelessWidget {
  const YesNoMyAlertDialog({
    super.key, 
    required this.title,
    required this.yesText, 
    required this.noText, 
    this.onYes, 
    this.onNo, 
    this.content, 
  });

  final Widget title; 
  final Widget? content; 
  final Widget yesText; 
  final Widget noText; 
  final void Function()? onYes; 
  final void Function()? onNo; 

  @override
  Widget build(BuildContext context) {
    return MyAlertDialog(
      title: title, 
      content: content,
      actions: [
        ElevatedButton(
        onPressed: () {
          if (onNo != null) {
            onNo!(); 
          }
          Navigator.pop(context); 
        }, 
        child: noText
      ), 
      ElevatedButton(
        onPressed: () {
          if (onYes != null) {
            onYes!(); 
          }
          Navigator.pop(context); 
        }, 
        child: yesText
      ), 
      ]
    );
  }
}