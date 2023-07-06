import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

import '../domain/domain.dart';

class AudioPlayerState extends ChangeNotifier {

  AudioPlayer? audioPlayer; 

  void startAudioPlayer(List<Song> songs, int initialIndex) async {
    audioPlayer ??= AudioPlayer(); 
    await audioPlayer!.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          for (Song song in songs)
            AudioSource.file(
              song.url, 
              tag: song
            ),
        ],
      ), 
      initialIndex: initialIndex, 
    );
    audioPlayer!.play(); 
    notifyListeners(); 
  }
}