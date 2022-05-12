import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:clipboardoctor/clipboard_notifier.dart';
import 'package:clipboardoctor/main_clipboardentries_widget.dart';
import 'package:clipboardoctor/models/clipboard_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_widget.dart';

final clipboardProvider = StateProvider<Set<ClipboardItem>>((ref) => {});

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
    ref.read(clipboardEntriesProvider.notifier).getData(ref.read);
    super.initState();
  }

  @override
  void dispose() {
    clipboardWatcher.removeListener(this);
    // stop watch
    clipboardWatcher.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Clipboard Doctor'),
          actions: const [
            //gear icon to show settings popup
            SettingsWidget(),
          ],
        ),
        body: const ClipboardMainWidget());
  }

  @override
  void onClipboardChanged() async {
    ClipboardData? newClipboardData = await Clipboard.getData(Clipboard.kTextPlain);

    final String? newText = newClipboardData?.text;
    if (newText != null) {
      newText.trim();
      if (newText.isNotEmpty) {
        ref.read(clipboardEntriesProvider.notifier).addItem(newText);
      }
    }
  }
}
