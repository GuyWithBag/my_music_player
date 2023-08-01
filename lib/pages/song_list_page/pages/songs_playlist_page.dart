import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/providers.dart'; 
import '../../../domain/domain.dart'; 
import '../../../widgets/widgets.dart';
import '../widgets/widgets.dart'; 
import '../../../theme/theme.dart'; 

class SongsPlaylistPage extends StatelessWidget {
  const SongsPlaylistPage({
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SongPlaylistProvider songPlaylistProvider = context.watch<SongPlaylistProvider>();
    final List<SongPlaylist> playlists = songPlaylistProvider.items; 
    return Container(
      decoration: backgroundDecoration, 
      child: Column(
        children: [
          SubHeader(
            header: Text("Playlists (${playlists.length})"), 
            actions: <SubHeaderAction>[
              SubHeaderAction(
                onTap: () {
                  songPlaylistProvider.promptCreatePlaylist(context); 
                },
                icon: const Icon(Icons.add)
              )
            ],
          ), 
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SongPlaylistList(
                onReorder: (int oldIndex, int newIndex) => onReOrderUpdateList(
                  oldIndex, 
                  newIndex, 
                  songPlaylistProvider.removeItemAt, 
                  songPlaylistProvider.insertItemAt
                ),
                songPlaylists: playlists, 
              ),
            ),
          ),
        ],
      )
    );
  }
}





