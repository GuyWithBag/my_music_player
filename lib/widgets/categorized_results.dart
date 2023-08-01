import 'package:flutter/material.dart';

class CategorizedResults extends StatelessWidget {
  const CategorizedResults({
    super.key, 
    required this.children
  }); 

  final List<Widget> children; 
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: children,
    );
  }
}