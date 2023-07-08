import 'package:flutter/material.dart';
import 'package:my_music_player/pages/settings_page/widgets/widgets.dart';
import 'package:my_music_player/providers/audio_player_provider.dart';

class AudioSettingsPage extends StatelessWidget {
  const AudioSettingsPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider = AudioPlayerProvider(); 
    return SettingsPagesLayout(
      title: "Audio", 
      children: [
        SettingsList(
          header: "Audio", 
          children: [
            SettingsTile(
              header: "Overlap system audio", 
              shortDescription: "Allow the audio player to overlap videos, music and so on, playing at the background. (Except for calls)", 
              onChanged: (bool value) {
                print(value); 
                audioPlayerProvider.allowOverlapSystemAudio(value); 
              },
            )
          ],
        ), 
      ]
    );
  }
}

