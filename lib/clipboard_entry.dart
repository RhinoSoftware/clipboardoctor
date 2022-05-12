// ignore_for_file: file_names

import 'package:clipboardoctor/clipboard_notifier.dart';
import 'package:clipboardoctor/models/clipboard_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClipboardEntryWidget extends ConsumerWidget {
  final ClipboardItem entry;
  const ClipboardEntryWidget({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return entry.text == ' '
        ? const SizedBox()
        : SizedBox(
            width: 350,
            child: InkWell(
              onTap: () async => await Clipboard.setData(ClipboardData(text: entry.text)),
              child: Card(
                child: ListTile(
                  title: Text(entry.text, maxLines: 3, style: const TextStyle(overflow: TextOverflow.ellipsis)),
                  leading: IconButton(
                      onPressed: () => ref.read(clipboardEntriesProvider.notifier).removeItem(entry.text),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                        onPressed: () async => await Clipboard.setData(ClipboardData(text: entry.text)),
                        icon: const Icon(Icons.content_copy)),
                    //Icon button to pin the entry
                    IconButton(
                        onPressed: () => ref.read(clipboardEntriesProvider.notifier).pinItem(entry.text),
                        icon: Icon(
                          Icons.save,
                          color: entry.pinned ? Colors.blue : Colors.grey,
                        )),
                  ]),
                ),
              ),
            ),
          );
  }
}
