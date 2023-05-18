import 'package:flutter/material.dart'; 
import '../../../domain/domain.dart'; 
import '../widgets/widgets.dart'; 

class SongsPlaylistPage extends StatelessWidget {
  const SongsPlaylistPage({
    Key? key, 
    required this.songPlaylists, 
  }) : super(key: key);

  final List<SongPlaylist> songPlaylists; 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SongPlaylistList(
          songPlaylists: songPlaylists, 
        ),
      )
    );
  }
}



