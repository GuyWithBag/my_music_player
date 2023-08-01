import 'package:flutter/material.dart';
import 'package:my_music_player/domain/domain.dart';

import 'widgets.dart';

class CategorizedResultsTile extends StatelessWidget {
  const CategorizedResultsTile({
    super.key, 
    required this.title, 
    required this.songTileResults, 
    required this.resultsData, 
  });

  final String title; 
  final List<Widget> songTileResults; 
  final List<HasNameObject> resultsData; 

  @override 
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CategorizedResultsHeader(
            title: title, 
            data: resultsData, 
          ), 
          const SizedBox(height: 10), 
          Column(
            children: songTileResults
          ),
        ], 
      ),
    );
  }
}