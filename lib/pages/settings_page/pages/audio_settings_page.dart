import 'package:flutter/material.dart';
import 'package:my_music_player/pages/settings_page/widgets/widgets.dart';

class AudioSettingsPage extends StatelessWidget {
  const AudioSettingsPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SettingsPagesLayout(
      title: "Audio", 
      children: [
        SettingsList(
          header: "Audio", 
          children: [
            SettingsTile(
              header: "Play on background", 
              shortDescription: "test", 
              onChanged: (bool value) {

              },
            )
          ],
        ), 
      ]
    );
  }
}

