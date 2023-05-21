import 'package:flutter/material.dart'; 
import '../../../data/database.dart';
import '../../../domain/domain.dart'; 
import '../../../widgets/widgets.dart';
import '../widgets/widgets.dart'; 
import '../../../theme/theme.dart'; 

class SongsPlaylistPage extends StatefulWidget {
  const SongsPlaylistPage({
    Key? key, 
    required this.database, 
  }) : super(key: key);

  final Database database; 

  @override
  State<SongsPlaylistPage> createState() => _SongsPlaylistPageState();
}

class _SongsPlaylistPageState extends State<SongsPlaylistPage> {
  final TextEditingController textEditingController = TextEditingController(); 
  final List<SongPlaylist> songPlaylists = []; 

  void _promptCreatePlaylistDialogue(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("New Playlist"), 
      titlePadding: const EdgeInsets.only(
        top: 30, 
        left: 20, 
        right: 20, 
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20), 
      actionsPadding: const EdgeInsets.only(bottom: 30),
      backgroundColor: Theme.of(context).primaryColor, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      content: CreatePlaylistDialogContent(
        textEditingController: textEditingController
      ), 
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); 
          }, 
          child: Text("Cancel")
        ), 
        ElevatedButton(
          onPressed: () {
            _createPlaylist(textEditingController.text, widget.database.placeholderSongs); 
            Navigator.pop(context); 
          }, 
          child: Text("Create")
        ), 
      ],
    ); 
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return alert; 
      }, 
    ); 
  }

  void _createPlaylist(String name, List<Song> songs) {
    if (name == "") {
      return; 
    }
    setState(() {
      SongPlaylist newSongPlaylist = SongPlaylist(
        name: name, 
        songs: songs, 
      ); 
      songPlaylists.add(newSongPlaylist); 
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration, 
      child: Column(
        children: [
          SubHeader(
            header: Text("Playlists (${songPlaylists.length})"), 
            actions: <SubHeaderAction>[
              SubHeaderAction(
                onTap: () {
                  _promptCreatePlaylistDialogue(context); 
                },
                icon: const Icon(Icons.add)
              )
            ],
          ), 
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SongPlaylistList(
              songPlaylists: songPlaylists, 
            ),
          ),
        ],
      )
    );
  }
}

class CreatePlaylistDialogContent extends StatelessWidget {
  const CreatePlaylistDialogContent({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Theme.of(context).primaryColor, 
      height: 100,
      child: Center(
        child: Row(
          children: [
            _PlaylistArtDisplay(), 
            const SizedBox(width: 20,), 
            Expanded(
              child: TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(), 
                  labelText: "Playlist Name: "
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}

class _PlaylistArtDisplay extends StatelessWidget {
  const _PlaylistArtDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, 
      width: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.grey,
          child: const Icon(Icons.music_note)
        ),
      ),
    );
  }
}



