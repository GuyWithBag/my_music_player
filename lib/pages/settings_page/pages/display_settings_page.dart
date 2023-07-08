import 'package:flutter/material.dart';
import '../widgets/widgets.dart'; 

class DisplaySettingsPage extends StatelessWidget {
  const DisplaySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPagesLayout(
      title: "Display", 
      children: [
        SettingsList(
          header: "themes", 
          children: [
            
          ],
        ), 
      ]
    );
  }
}


