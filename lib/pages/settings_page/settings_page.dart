
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../../theme/theme.dart';
import '../../widgets/widgets.dart'; 

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: backgroundDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, 
            children: [
              IconInkWellTile(
                onTap: () {

                },
                text: Text(
                  "Display", 
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                icon: const Icon(Icons.tv), 
              ), 
              IconInkWellTile(
                onTap: () {
                  Get.toNamed("Settings/Audio"); 
                },
                text: Text(
                  "Audio", 
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                icon: const Icon(Icons.music_note), 
              ), 
              IconInkWellTile(
                onTap: () {},
                text: Text(
                  "Headset", 
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                icon: const Icon(Icons.headphones), 
              ), 
              IconInkWellTile(
                onTap: () {},
                text: Text(
                  "Lockscreen", 
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                icon: const Icon(Icons.lock), 
              ), 
              IconInkWellTile(
                onTap: () {},
                text: Text(
                  "Advanced", 
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                icon: const Icon(Icons.sort), 
              ), 
              IconInkWellTile(
                onTap: () {},
                text: Text(
                  "Others", 
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                icon: const Icon(Icons.settings), 
              ), 
            ],
          ),
        ),
      ),
    );
  }
}




