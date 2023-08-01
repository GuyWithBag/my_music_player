import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({
    Key? key, 
    this.content, 
    required this.title, 
    required this.actions, 
  }) : super(key: key); 

  final Widget title; 
  final List<Widget> actions; 
  final Widget? content; 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title, 
      titlePadding: const EdgeInsets.only(
        top: 30, 
        left: 20, 
        right: 20, 
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20), 
      actionsPadding: const EdgeInsets.only(bottom: 30),
      backgroundColor: Theme.of(context).primaryColor, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      content: content,
      actions: actions
    );
  }
}