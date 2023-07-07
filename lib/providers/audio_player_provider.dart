import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_music_player/providers/providers.dart';
import 'package:provider/provider.dart';

import '../domain/domain.dart';

class AudioPlayerProvider extends ChangeNotifier {

  AudioPlayer? audioPlayer; 

  void startAndGoToAudioPlayer(BuildContext context, List<Song> songs, int initialIndex) {
    final SongQueueProvider songQueueState = context.watch<SongQueueProvider>(); 
    songQueueState.setSongs(songs); 
    startAudioPlayer(songQueueState.allSongs, initialIndex); 
    Get.toNamed( '/AudioPlayer'); 
  }

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