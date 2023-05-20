import 'package:flutter/material.dart';
import 'package:my_music_player/widgets/widgets.dart';
import '../../theme/theme.dart'; 

class MoreFeaturesPage extends StatelessWidget {
  const MoreFeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: backgroundDecoration,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MoreCategory(
                title: const Text("Tools"), 
                children: [
                  IconInkWellTile(
                    onTap: () {},
                    icon: const Icon(Icons.alarm), 
                    text: const Text("Sleep Timer"), 
                  ), 
                  IconInkWellTile(
                    onTap: () {},
                    icon: const Icon(Icons.alarm), 
                    text: const Text("Sleep Timer"), 
                  ), 
                  IconInkWellTile(
                    onTap: () {},
                    icon: const Icon(Icons.alarm), 
                    text: const Text("Sleep Timer"), 
                  ), 
                ],
              ), 
              MoreCategory(
                title: const Text("Others"), 
                children: [
                  IconInkWellTile(
                    onTap: () {},
                    icon: const Icon(Icons.thumbs_up_down_outlined), 
                    text: const Text("Rate us"), 
                  ), 
                  IconInkWellTile(
                    onTap: () {},
                    icon: const Icon(Icons.feedback), 
                    text: const Text("Feedback"), 
                  ), 
                  IconInkWellTile(
                    onTap: () {},
                    icon: const Icon(Icons.change_history), 
                    text: const Text("Change log"), 
                  ), 
                  IconInkWellTile(
                    onTap: () {},
                    icon: const Icon(Icons.privacy_tip), 
                    text: const Text("Privacy Policy"), 
                  ), 
                  IconInkWellTile(
                    onTap: () {},
                    icon: const Icon(Icons.bus_alert_outlined), 
                    text: const Text("About"), 
                  ), 
                ],
              ), 
            ],
          ),
        ),
      ),
    );
  }
}

class MoreCategory extends StatelessWidget {
  const MoreCategory({
    Key? key, 
    required this.title, 
    required this.children, 
  }) : super(key: key);

  final Text title; 
  final List<IconInkWellTile> children; 

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Container(
              child: title,
            ), 
            Expanded(
              child: Column(
                children: children, 
              ),
            )
          ],
        ),
      ),
    );
  }
}

