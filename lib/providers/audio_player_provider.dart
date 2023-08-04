import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_music_player/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:audio_session/audio_session.dart'; 

import '../domain/domain.dart';

class AudioPlayerProvider extends ChangeNotifier {

  AudioPlayer? audioPlayer; 
  Song? currentSong; 

  // TODO: This does not work yet, see: https://suragch.medium.com/background-audio-in-flutter-with-audio-service-and-just-audio-3cce17b4a7d
  void allowOverlapSystemAudio(bool value) async {
    final session = await AudioSession.instance;
    if (value == false) {
      await session.configure(const AudioSessionConfiguration(
        androidWillPauseWhenDucked: true, 
      ));
      return; 
    }
    await session.configure(const AudioSessionConfiguration(
      androidWillPauseWhenDucked: false, 
    ));
  }

  void startAndGoToAudioPlayer(BuildContext context, List<Song> songs, int initialIndex) {
    final SongQueueProvider songQueueProvider = context.read<SongQueueProvider>(); 
    songQueueProvider.setItems(songs); 
    startAudioPlayer(songQueueProvider.items, initialIndex); 
    Get.toNamed( '/AudioPlayer'); 
  } 

  void startAudioPlayer(List<Song> songs, int initialIndex) async {
    if (audioPlayer == null) {
      audioPlayer = AudioPlayer(); 
      audioPlayer!.setLoopMode(LoopMode.all); 
    }
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
    currentSong = songs[initialIndex]; 
    currentSong!.timesSelected++; 
    currentSong!.timesPlayed++; 
    audioPlayer!.play(); 
    notifyListeners(); 
  }

  bool isPlaying(Song song) {
    return currentSong == song; 
  }

  void setLoopMode(LoopMode loopMode) {
    audioPlayer!.setLoopMode(loopMode); 
    notifyListeners(); 
  }

}

