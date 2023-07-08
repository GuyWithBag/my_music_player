import 'package:flutter/material.dart';
import 'package:my_music_player/theme/theme.dart';

class SettingsPagesLayout extends StatelessWidget {
  const SettingsPagesLayout({
    super.key, 
    required this.title, 
    required this.children, 
  });

  final List<Widget> children; 
  final String title; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), 
      body: SizedBox.expand(
        child: Container(
          decoration: backgroundDecoration, 
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text(
                title, 
                style: Theme.of(context)
                            .textTheme
                            .displaySmall,
              ),
              SizedBox(
                child: Column(
                  children: children, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


