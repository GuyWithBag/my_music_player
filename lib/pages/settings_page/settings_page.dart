
import 'package:flutter/material.dart'; 
import '../../theme/theme.dart'; 

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: backgroundDecoration,
      ),
    );
  }
}


