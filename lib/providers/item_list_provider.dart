import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_music_player/domain/domain.dart';

import '../widgets/widgets.dart';

abstract class ItemListProvider<T> extends ChangeNotifier {
  List<T> items = []; 
  bool hiveEnabled = false; 
  Box? box; 

  void initializeHive(String boxName) async {
    hiveEnabled = true; 
    box = await Hive.openBox(boxName); 
    if (box!.isNotEmpty) {
      items = [...box!.values]; 
    }
  }

  void setItems(List<T> newItems) {
    items = newItems; 
    notifyListeners(); 
  }

  void addItems(List<T> newItems) {
    items.addAll(newItems); 
    notifyListeners(); 
  }

  void addItem(T item, {String? key}) {
    if (hiveEnabled) {
      box!.put(key, item); 
    }
    items.add(item); 
    notifyListeners(); 
  }

  void clearItems() {
    items.clear(); 
    notifyListeners(); 
  }

  T removeItemAt(int index) {
    if (hiveEnabled) {
      box!.deleteAt(index); 
    }
    T item = items.removeAt(index); 
    notifyListeners(); 
    return item; 
  }

  T promptRemoveItemAt(BuildContext context, int index) {
    T? item; 
    Widget alert = _deleteDialog<T?, int>(item, index, removeItemAt); 
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return alert; 
      }, 
    ); 
    notifyListeners(); 
    return item!; 
  }

  void insertItemAt(int index, T item) {
    items.insert(index, item); 
  }

  bool promptRemoveItem(BuildContext context, T item , {String? key}) {
    bool value = false; 
    Widget alert = _deleteDialog<bool, T>(value, item, removeItem, key: key); 
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return alert; 
      }, 
    ); 
    notifyListeners(); 
    return value; 
  }

  bool removeItem(T item, {String? key}) {
    if (hiveEnabled) {
      box!.delete(key); 
    }
    bool value = items.remove(item); 
    notifyListeners(); 
    return value; 
  }

  Widget _deleteDialog<T2, T3>(T2 value, T3 item, Function remove, {String? key}) {
    return _DeleteAppAlertDialog(
      onYes: () {
        _deleteDialogLogic<T2, T3>(value, item, remove, key: key); 
      }
    ); 
  }

  void _deleteDialogLogic<T2, T3>(T2 value, T3 item, Function remove, {String? key}) {
    if (key == null) {
      remove(item); 
      return; 
    }
    value = remove(item, key: key); 
  }

  void updateNotifier() {
    notifyListeners(); 
  }

}


class _DeleteAppAlertDialog extends StatelessWidget {
  const _DeleteAppAlertDialog({
    Key? key, 
    this.onYes, 
  }) : super(key: key); 

  final Function()? onYes; 

  @override
  Widget build(BuildContext context) {
    return YesNoMyAlertDialog(
      title: const Text("Delete?"),
      noText: const Text("Cancel"), 
      yesText: const Text("Delete"), 
      onYes: onYes
    ); 
  }
}

mixin SearchItem<T extends HasNameObject> on ItemListProvider<T>{
  List<T> getSearchedItemsByName(String searchValue) {
    List<T> results = []; 
    if (searchValue.isEmpty) {
      return results; 
    }
    for (T item in items) {
      String songName = item.name.toLowerCase(); 
      if (songName.contains(searchValue.toLowerCase())) {
        results.add(item); 
      }
    }
    return results; 
  }
}
