import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/domain.dart'; 
import '../song_list_page/widgets/widgets.dart'; 

class SongQueuePage extends StatelessWidget {
  const SongQueuePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AllSongsState allSongsState = context.watch<AllSongsState>(); 
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AllSongsList(
        songs: allSongsState.allSongs, 
        onReorder: (int oldIndex, int newIndex) => onReOrderUpdateList(
          oldIndex, 
          newIndex, 
          allSongsState.removeSongAt, 
          allSongsState.insertSongAt
        ),
      ),
    );
  }
}



