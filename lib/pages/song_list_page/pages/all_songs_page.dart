import 'package:flutter/material.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../widgets/widgets.dart'; 
import '../../../providers/providers.dart'; 

class AllSongsPage extends StatelessWidget {
  const AllSongsPage({
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllSongsProvider allSongsState = context.watch<AllSongsProvider>(); 
    List<Song> songs = allSongsState.items; 
    return Container(
      decoration: backgroundDecoration,
      child: Column(
        children: [
          SubHeader(
            header: Text("${songs.length} songs"), 
            actions: [
              SubHeaderAction(
                onTap: () {},
                icon: const Icon(
                  Icons.sort, 
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 25), 
              SubHeaderAction(
                onTap: () {},
                icon: const Icon(
                  Icons.list, 
                  color: Colors.white,
                ),
              ), 
            ],
          ), 
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 10), 
              child: AllSongsList(
                songs: songs, 
                onReorder: (int oldIndex, int newIndex) => onReOrderUpdateList(
                  oldIndex, 
                  newIndex, 
                  allSongsState.removeItemAt, 
                  allSongsState.insertItemAt, 
                ),
              )
            ),
          )
        ],
      )
    ); 
  }
}






