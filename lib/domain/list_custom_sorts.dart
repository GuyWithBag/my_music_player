
import 'audio_player.dart';


void sortSongsAlphabetically(List<Song> songs, {bool descending = false}) {
  songs.sort((Song a, Song b) {
    String nameA = trimNonAlphanumericCharacters(a.name); 
    String nameB = trimNonAlphanumericCharacters(b.name); 
    if (descending) {
      return stringAlphabeticalSort(nameB, nameA); 
    } else {
      return stringAlphabeticalSort(nameA, nameB); 
    }
  }); 
}

int stringAlphabeticalSort(String a, String b) {
  int result = a.toLowerCase().compareTo(b.toLowerCase());
  return result;
}

String trimNonAlphanumericCharacters(String value) {
  return value.replaceAll(RegExp("[\\W]|_"), "");
}

bool isEnglish(String value) {
  return RegExp(r'^[a-zA-Z0-9\s,.!?]*$').hasMatch(value);
}

// int arrangeStringAlphabetically(Song a, Song b) {
//   return a.name.toLowerCase().compareTo(b.name.toLowerCase());
// }

