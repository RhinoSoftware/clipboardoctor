import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'clipboard_entry.dart';
import 'clipboard_notifier.dart';
import 'models/clipboard_entry_model.dart';

class ClipboardMainScreen extends ConsumerWidget {
  const ClipboardMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SingleChildScrollView(child: Consumer(
        builder: (context, ref, child) {
          final clipboardItems = ref.watch(clipboardItemsProvider);
          return Column(
            children: [
              const Text('Pinned Items'),
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (ClipboardItem entry in clipboardItems.where((element) => element.pinned))
                    ClipboardEntryWidget(entry: entry),
                ],
              ),
              const Divider(),
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (ClipboardItem entry in clipboardItems.where((element) => !element.pinned))
                    ClipboardEntryWidget(entry: entry),
                ],
              ),
            ],
          );
        },
      )),
    );
  }
}
