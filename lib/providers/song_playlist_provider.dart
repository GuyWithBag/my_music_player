
import 'package:flutter/material.dart'; 
import 'package:my_music_player/domain/domain.dart';

import '../pages/song_list_page/widgets/widgets.dart';

class SongPlaylistProvider extends ChangeNotifier {
  List<SongPlaylist> playlists = []; 

  void promptCreatePlaylistDialogue(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController(); 
    AlertDialog alert = AlertDialog(
      title: const Text("New Playlist"), 
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
          child: const Text("Cancel")
        ), 
        ElevatedButton(
          onPressed: () {
            createPlaylist(textEditingController.text); 
            Navigator.pop(context); 
          }, 
          child: const Text("Create")
        ), 
      ], 
    ); 
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return alert; 
      }, 
    ); 
    notifyListeners(); 
  }

  void addPlaylists(List<SongPlaylist> value) {
    playlists.addAll(value); 
    notifyListeners(); 
  }

  void setPlaylists(List<SongPlaylist> value) {
    playlists = value; 
    notifyListeners(); 
  }

  void addPlaylist(SongPlaylist song) {
    playlists.add(song); 
    notifyListeners(); 
  }

  void clearPlaylists() {
    playlists.clear(); 
    notifyListeners(); 
  }

  SongPlaylist removePlaylistAt(int index) {
    SongPlaylist playlist = playlists.removeAt(index); 
    notifyListeners(); 
    return playlist; 
  }

  void insertPlaylistAt(int index, SongPlaylist song) {
    playlists.insert(index, song); 
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
    addPlaylist(newSongPlaylist); 
  }
}

