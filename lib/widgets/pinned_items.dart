import 'package:flutter/material.dart';

import '../models/clipboard_entry_model.dart';
import 'single_clipboard_item.dart';

class PinnedItemsWidget extends StatelessWidget {
  const PinnedItemsWidget({
    Key? key,
    required this.clipboardItems,
  }) : super(key: key);

  final List<ClipboardItem> clipboardItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Pinned Items'),
        Wrap(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (ClipboardItem entry in clipboardItems) ClipboardItemWidget(entry: entry),
          ],
        ),
      ],
    );
  }
}
