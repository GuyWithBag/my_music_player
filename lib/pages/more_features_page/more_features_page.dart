import 'package:flutter/material.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/widgets/widgets.dart';
import '../../theme/theme.dart'; 

class MoreFeaturesPage extends StatelessWidget {
  const MoreFeaturesPage({super.key});

  final double categoryGap = 20; 

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: backgroundDecoration,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30, 
            right: 30, 
            top: 30
          ),
          child: PrimaryScrollController(
            controller: scrollController,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MoreCategory(
                    title: "Tools", 
                    children: <IconInkWellTile>[
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
                  SizedBox(height: categoryGap), 
                  MoreCategory(
                    title: "Others", 
                    children: <IconInkWellTile>[
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

  final String title; 
  final List<IconInkWellTile> children; 

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: Theme.of(context).primaryColor, 
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
                title, 
                style: Theme.of(context).textTheme.titleLarge,
            ), 
            Column(
              children: children, 
            )
          ],
        ),
      ),
    );
  }
}

