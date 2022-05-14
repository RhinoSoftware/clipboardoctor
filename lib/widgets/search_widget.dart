import 'package:clipboardoctor/providers/clipboard_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

class SearchWidget extends ConsumerWidget {
  SearchWidget({
    Key? key,
  }) : super(key: key);

  final searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    return MacosSearchField(
      expands: true,
      maxResultsToShow: 15,
      resultHeight: 30,
      placeholder: 'Search & tap to copy',
      controller: searchFieldController,
      onResultSelected: (result) async {
        await Clipboard.setData(ClipboardData(text: result.searchKey));
        searchFieldController.clear();
      },
      results: ref
          .watch(clipboardItemsProvider)
          .map((e) => SearchResultItem(
                e.text,
                child: Text(e.text, style: const TextStyle(fontSize: 12)),
              ))
          .toList(),
    );
  }
}
