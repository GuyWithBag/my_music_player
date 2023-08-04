import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/domain.dart'; 
import '../../widgets/widgets.dart';
import '../../providers/providers.dart'; 

class SongQueuePage extends StatelessWidget {
  const SongQueuePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AllSongsProvider allSongsState = context.watch<AllSongsProvider>(); 
    return SizedBox.expand(
      child: AllSongsList(
        songs: allSongsState.items, 
        onReorder: (int oldIndex, int newIndex) => onReOrderUpdateList(
          oldIndex, 
          newIndex, 
          allSongsState.removeItemAt, 
          allSongsState.insertItemAt
        ),
      ),
    );
  }
}



