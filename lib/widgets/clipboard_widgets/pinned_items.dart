import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../models/clipboard_entry_model.dart';
import '../../providers/clipboard_notifier.dart';
import 'single_clipboard_item.dart';

class PinnedItems extends ConsumerWidget {
  const PinnedItems({
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
                    for (ClipboardItem entry in clipboardItems.where((item) => item.pinned))
                      ClipboardItemWidget(entry: entry),
                  ],
                ),
        );
      },
    );
  }
}
