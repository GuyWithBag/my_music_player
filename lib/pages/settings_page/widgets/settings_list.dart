import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    super.key, 
    this.header, 
    required this.children
  }); 

  final String? header; 
  final List<Widget> children; 

  @override
  Widget build(BuildContext context) {
    if (header == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start, 
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: children, 
      ); 
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header!, 
          style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold), 
        ), 
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: children,
          ),
        )
      ],
    );
  }
}

