import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/clipboard_entry_model.dart';

class ClipboardEntriesNotifier extends StateNotifier<List<ClipboardItem>> {
  ClipboardEntriesNotifier() : super(<ClipboardItem>[]);

// Let's allow the UI to add todos.
  void addItem(String text) {
//check if the text is not empty and none of the items contain this text
    if (text.isNotEmpty && !state.any((entry) => entry.text == text)) {
      state = [...state, ClipboardItem(text: text)];
      saveItemsToStorage();
    }
  }

//save clipboard data to shared preferences
  Future saveItemsToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    // final data = prefs.getStringList(appkey) ?? [];
    // data.add(newEntry.toJsonString());
    // data.toSet();
    //convert the list to a jsonString and save it to shared preferences
    final data = state.map((entry) => entry.toJsonString()).toList();

    prefs.setStringList(appkey, data);
  }

  // Let's allow removing todos
  void removeItem(String todoId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = [
      for (final todo in state)
        if (todo.text != todoId) todo,
    ];
    saveItemsToStorage();
  }

  // Let's mark a todo as pinned
  void pinItem(String text) {
    state = [
      for (final todo in state)
        // we're marking only the matching items as pinned
        if (todo.text == text)
          todo.copyWith(pinned: !todo.pinned)
        else
          // other todos are not modified
          todo,
    ];
    saveItemsToStorage();
  }

  static const appkey = 'clipboardoctor';
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

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final clipboardEntriesProvider = StateNotifierProvider<ClipboardEntriesNotifier, List<ClipboardItem>>((ref) {
  return ClipboardEntriesNotifier();
});
