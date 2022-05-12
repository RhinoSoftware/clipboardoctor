import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/clipboard_entry_model.dart';

// Using StateNotifierProvider to allow the UI to interact with
// our ItemsNotifier class.
final clipboardItemsProvider = StateNotifierProvider<ClipboardItemsNotifier, List<ClipboardItem>>((ref) {
  return ClipboardItemsNotifier();
});

class ClipboardItemsNotifier extends StateNotifier<List<ClipboardItem>> {
  ClipboardItemsNotifier() : super(<ClipboardItem>[]);
  static const appkey = 'clipboardoctorsharedpreferences@rhinosoft.io';

// Let's allow the UI to add items.
  void addItem(String text) {
//check if the text is not empty and none of the items contain this text
    if (text.isNotEmpty && !state.any((entry) => entry.text == text)) {
      state = [
        ClipboardItem(text: text, createdAt: DateTime.now().toIso8601String()),
        ...state,
      ];
      saveItemsToStorage();
    }
  }

//save clipboard data to shared preferences
  Future saveItemsToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    //convert the list to a jsonString and save it to shared preferences
    final data = state.map((entry) => entry.toJsonString()).toList();

    prefs.setStringList(appkey, data);
  }

  void removeItem(String text) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = [
      for (final item in state)
        if (item.text != text) item,
    ];
    saveItemsToStorage();
  }

  void pinItem(String text) {
    state = [
      for (final item in state)
        // we're marking only the matching items as pinned
        if (item.text == text)
          item.copyWith(pinned: !item.pinned)
        else
          // other items are not modified
          item,
    ];
    saveItemsToStorage();
  }

  void clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(appkey);
    state = [];
  }

  void getData(Reader read) async {
    final pref = await SharedPreferences.getInstance();
    final items = pref.getStringList(appkey);
    if (items != null) {
      //get the data from shared preferences and convert it to a list of ClipboardEntry, then update the state
      state = [...items.map((item) => ClipboardItem.fromJsonString(item)).toList()];
    }
  }
}
