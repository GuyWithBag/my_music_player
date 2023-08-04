import 'package:flutter/material.dart';
import 'package:my_music_player/providers/providers.dart';
import 'package:my_music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../domain/domain.dart';

class PlaylistRenameDialog extends StatelessWidget {
  const PlaylistRenameDialog({
    Key? key, 
    required this.playlist, 
    required this.textEditingController, 
  }) : super(key: key);

  final SongPlaylist playlist; 
  final TextEditingController textEditingController; 

  @override
  Widget build(BuildContext context) {
    final SongPlaylistProvider songPlaylistProvider = context.watch<SongPlaylistProvider>(); 
    return YesNoMyAlertDialog(
      title: const Text("Rename Playlist"), 
      content: _RenameDialogContent(
        textEditingController: textEditingController
      ), 
      noText: const Text("Cancel"), 
      yesText: const Text("Confirm"), 
      onYes: () {
        playlist.setName(textEditingController.text); 
        songPlaylistProvider.updateNotifier(); 
      }, 
    );
  }
}

class _RenameDialogContent extends StatelessWidget {
  const _RenameDialogContent({
    Key? key, 
    required this.textEditingController
  }) : super(key: key); 

  final TextEditingController textEditingController; 

  @override 
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        decoration: const InputDecoration(
        border: UnderlineInputBorder(), 
        labelText: "Playlist Name: "
      ),
    );
  }
}