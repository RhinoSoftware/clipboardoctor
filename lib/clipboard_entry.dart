// ignore_for_file: file_names

import 'package:clipboardoctor/models/clipboard_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clipboardoctor/clipboard_watcher.dart';

class ClipboardEntryWidget extends StatelessWidget {
  final ClipboardEntry entry;
  const ClipboardEntryWidget({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return entry.text == ' '
        ? const SizedBox()
        : Card(
            child: ListTile(
              title: Text(entry.text, maxLines: 3, style: const TextStyle(overflow: TextOverflow.ellipsis)),
              leading: Consumer(
                builder: (context, ref, child) {
                  return IconButton(
                      onPressed: () {
                        final clipboardWatcher = ref.watch(clipboardProvider);
                        clipboardWatcher.remove(entry);
                        ref.read(clipboardProvider.state).update((state) => {...clipboardWatcher});
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ));
                },
              ),
              trailing: IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: entry.text));
                  },
                  icon: const Icon(Icons.content_copy)),
            ),
          );
  }
}
