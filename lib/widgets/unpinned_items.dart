import 'package:flutter/material.dart';

import '../models/clipboard_entry_model.dart';
import 'single_clipboard_item.dart';

class UnpinnedItemsWidget extends StatelessWidget {
  const UnpinnedItemsWidget({
    Key? key,
    required this.clipboardItems,
  }) : super(key: key);

  final List<ClipboardItem> clipboardItems;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (var entry in clipboardItems) ClipboardItemWidget(entry: entry),
      ],
    );
  }
}
