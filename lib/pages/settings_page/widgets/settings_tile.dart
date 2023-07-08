import 'package:flutter/material.dart';

class SettingsTile extends StatefulWidget {
  const SettingsTile({
    super.key, 
    required this.header, 
    this.shortDescription, 
    this.initialSwitchValue, 
    this.onChanged, 
  }); 

  final String header; 
  final String? shortDescription; 
  final bool? initialSwitchValue; 
  final void Function(bool)? onChanged;

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {

  bool switchValue = false; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.header, 
                  maxLines: 1, 
                  style: Theme.of(context)
                              .textTheme
                              .titleMedium,
                ), 
                Text(
                  widget.shortDescription ?? "", 
                  maxLines: 1,
                  style: Theme.of(context) 
                              .textTheme 
                              .titleSmall!
                              .copyWith(color: Colors.grey), 
                ), 
              ],
            ),
          ), 
          const Spacer(), 
          Switch.adaptive(
            value: widget.initialSwitchValue ?? switchValue,  
            autofocus: true,
            onChanged: (value) {
              setState(() {
                switchValue = value; 
                void Function(bool)? onChanged = widget.onChanged; 
                onChanged = onChanged ?? (value) {}; 
                onChanged(value); 
              });
            }
          )
        ],
      ),
    );
  }
}

