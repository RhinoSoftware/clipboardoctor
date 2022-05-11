// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clipboardoctor/clipboard_watcher.dart';

class ClipboardEntry extends StatelessWidget {
  final String text;
  const ClipboardEntry({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return text == ' '
        ? const SizedBox()
        : Card(
            child: ListTile(
              title: Text(text, maxLines: 3, style: const TextStyle(overflow: TextOverflow.ellipsis)),
              leading: Consumer(
                builder: (context, ref, child) {
                  return IconButton(
                      onPressed: () {
                        final clipboardWatcher = ref.watch(clipboardProvider);
                        clipboardWatcher.remove(text);
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
                    await Clipboard.setData(ClipboardData(text: text));
                  },
                  icon: const Icon(Icons.content_copy)),
            ),
          );
  }
}