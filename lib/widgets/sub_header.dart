import 'package:flutter/material.dart';
import '../../../domain/audio_player.dart';
import 'widgets.dart'; 

class SubHeader extends StatelessWidget {
  const SubHeader({
    Key? key,
    required this.header, 
    required this.actions, 
    this.padding = const EdgeInsets.symmetric(vertical: 7, horizontal: 20), 
  }) : super(key: key);

  final Widget header; 
  final List<Widget> actions; 
  final EdgeInsets padding; 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Expanded(
              child: header
            ), 
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions, 
              ),
            ), 
          ],
        ),
      ),
    );
  }
}