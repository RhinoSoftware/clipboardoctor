import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'clipboard_entry.dart';

final clipboardProvider = StateProvider<Set<String>>((ref) => {});

class ClipBoardSecond extends ConsumerStatefulWidget {
  const ClipBoardSecond({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClipBoardSecondState();
}

class _ClipBoardSecondState extends ConsumerState<ClipBoardSecond> with ClipboardListener {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clipboard Doctor'),
        actions: [
          TextButton.icon(
              onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              clearAllData(ref.read);
                              Navigator.pop(context);
                            },
                            child: const Text('YES, I AM SURE!'),
                          ),
                        ],
                        content: const Text('Are you sure you want to clear all items?'),
                      );
                    },
                  ),
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              label: const Text('Clear All Data'))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(child: Consumer(
          builder: (context, ref, child) {
            final x = ref.watch(clipboardProvider);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (var item in x.toList().reversed.toList()) ClipboardEntry(text: item.toString()),
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
      if (newText.isNotEmpty) saveData(ref.read, newText);
    }
  }
}

void clearAllData(Reader read) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('clipboardoctor');
  read(clipboardProvider.state).update((state) => {});
}

void getData(Reader read) async {
  final pref = await SharedPreferences.getInstance();
  final items = pref.getStringList('clipboardoctor');
  if (items != null) {
    read(clipboardProvider.state).update((state) => {...state, ...Set.from(items)});
  }
}

//save clipboard data to shared preferences
Future saveData(Reader read, String text) async {
  final prefs = await SharedPreferences.getInstance();
  final data = prefs.getStringList('clipboardoctor') ?? [];
  data.add(text);
  data.toSet();
  prefs.setStringList('clipboardoctor', data);
  read(clipboardProvider.state).update((state) => {...state, text});
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
