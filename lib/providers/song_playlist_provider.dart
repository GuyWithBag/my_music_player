
import 'package:flutter/material.dart'; 
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/providers/providers.dart';

import '../pages/song_list_page/widgets/widgets.dart';
import '../widgets/widgets.dart';

class SongPlaylistProvider extends ItemListProvider<SongPlaylist> with SearchItem<SongPlaylist> {
  void promptCreatePlaylist(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController(); 
    YesNoMyAlertDialog alert = YesNoMyAlertDialog(
      title: const Text("New Playlist"), 
      content: CreatePlaylistDialogContent(
        textEditingController: textEditingController
      ), 
      noText: const Text("Cancel"), 
      yesText: const Text("Create"), 
      onNo: () {
        textEditingController.dispose(); 
      }, 
      onYes: () {
        createPlaylist(textEditingController.text); 
      }, 
    ); 
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return alert; 
      }, 
    ); 
    notifyListeners(); 
  }

  void createPlaylist(String name, {List<Song>? songs}) {
    if (name == "") {
      return; 
    }
    SongPlaylist newSongPlaylist = SongPlaylist(
      name: name, 
      songs: songs ?? [], 
    ); 
    addItem(newSongPlaylist); 
    notifyListeners(); 
  }

}

