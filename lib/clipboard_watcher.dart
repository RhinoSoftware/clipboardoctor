import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:clipboardoctor/models/clipboard_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'clipboard_entry.dart';
import 'settings_widget.dart';

final clipboardProvider = StateProvider<Set<ClipboardEntry>>((ref) => {});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClipBoardSecondState();
}

class _ClipBoardSecondState extends ConsumerState<HomeScreen> with ClipboardListener {
  @override
  void initState() {
    clipboardWatcher.addListener(this);
    // start watch
    clipboardWatcher.start();
    getData(ref.read);
    super.initState();
  }

  @override
  void dispose() {
    clipboardWatcher.removeListener(this);
    // stop watch
    clipboardWatcher.stop();
    super.dispose();
  }

  Set<String> items = {};
  @override
  Widget build(BuildContext context) {
    getData(ref.read);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clipboard Doctor'),
        actions: const [
          //gear icon to show settings popup
          SettingsWidget(),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(child: Consumer(
          builder: (context, ref, child) {
            final x = ref.watch(clipboardProvider);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (var entry in x.toList().reversed.toList()) ClipboardEntryWidget(entry: entry),
              ],
            );
          },
        )),
      ),
    );
  }

  @override
  void onClipboardChanged() async {
    ClipboardData? newClipboardData = await Clipboard.getData(Clipboard.kTextPlain);

    final String? newText = newClipboardData?.text;
    if (newText != null) {
      newText.trim();
      if (newText.isNotEmpty) saveData(ref.read, ClipboardEntry(text: newText));
    }
  }
}

const appkey = 'clipboardoctor';
void clearAllData(Reader read) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(appkey);
  read(clipboardProvider.state).update((state) => {});
}

void getData(Reader read) async {
  final pref = await SharedPreferences.getInstance();
  final items = pref.getStringList(appkey);
  if (items != null) {
    Set<ClipboardEntry> _set = {};
    if (items.isNotEmpty) {
      for (String e in items) {
        _set.add(ClipboardEntry.fromJsonString(e));
      }
    }

    read(clipboardProvider.state).update((state) => {..._set});
  }
}

//save clipboard data to shared preferences
Future saveData(Reader read, ClipboardEntry newEntry) async {
  final prefs = await SharedPreferences.getInstance();
  final data = prefs.getStringList(appkey) ?? [];
  data.add(newEntry.toJsonString());
  data.toSet();
  prefs.setStringList(appkey, data);
  read(clipboardProvider.state).update((state) => {...state, newEntry});
}

// ////////////////////
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with ClipboardListener {
//   @override
//   void initState() {
//     clipboardWatcher.addListener(this);
//     // start watch
//     clipboardWatcher.start();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     clipboardWatcher.removeListener(this);
//     // stop watch
//     clipboardWatcher.stop();
//     super.dispose();
//   }

//   Set<String> items = {};
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Clipboard Watcher'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(child: Consumer(
//           builder: (context, ref, child) {
//             final x = ref.watch(clipboardProvider);
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 for (var item in x.toList().reversed.toList()) ClipboardEntry(text: item.toString()),
//               ],
//             );
//           },
//         )),
//       ),
//     );
//   }

//   @override
//   void onClipboardChanged() async {
//     ClipboardData? newClipboardData = await Clipboard.getData(Clipboard.kTextPlain);
//     final String? newText = newClipboardData?.text;
//     if (newText != null) {
//       if (newText.isNotEmpty) {
//         setState(() {
//           items.add(newText);
//         });
//       }
//     }
//   }
// }
