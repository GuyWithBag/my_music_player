import 'package:flutter/foundation.dart';


class SongTileDraggableScrollSheetOptionsController extends ChangeNotifier {
  bool visible = false; 

  void setVisible(bool value) {
    visible = value; 
    notifyListeners(); 
  }

}

