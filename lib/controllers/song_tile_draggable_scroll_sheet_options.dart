import 'package:flutter/foundation.dart';

class SongTileDraggableScrollSheetOptions extends ChangeNotifier {
  bool visible = false; 

  void setVisible(bool value) {
    visible = value; 
    notifyListeners(); 
  }

}