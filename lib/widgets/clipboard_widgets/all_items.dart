import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../models/clipboard_entry_model.dart';
import '../../providers/clipboard_notifier.dart';
import 'single_clipboard_item.dart';

class AllItems extends ConsumerWidget {
  const AllItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final clipboardItems = ref.watch(clipboardItemsProvider);

    return ContentArea(
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          child: clipboardItems.isEmpty
              ? const Text(('No items'))
              : Wrap(
                  children: <Widget>[
                    for (ClipboardItem entry in clipboardItems) ClipboardItemWidget(entry: entry),
                  ],
                ),
        );
      },
    );
  }
}
