import 'package:flutter/material.dart'
    show
        AlertDialog,
        BuildContext,
        Colors,
        Column,
        Icon,
        IconButton,
        Icons,
        Key,
        MainAxisSize,
        Navigator,
        Row,
        Switch,
        Text,
        TextButton,
        Widget,
        showDialog;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ConsumerWidget;
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/clipboard_notifier.dart';
import '../main.dart' show themeProvider;

class SettingsWidget extends ConsumerWidget {
  const SettingsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //switch to dark mode
                Row(
                  children: [
                    const Text('Light Mode'),
                    Switch(
                      value: ref.watch(themeProvider),
                      onChanged: (value) async{
                        //save the value to shared preferences
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('clipoarddoctortheme', value);
                        ref.read(themeProvider.state).update((state) => value);
                      },
                    ),
                    const Text('Dark Mode'),
                  ],
                ),
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
                                    ref.read(clipboardItemsProvider.notifier).clearAllData();
                                    Navigator.pop(context);
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
          );
        },
      ),
    );
  }
}
