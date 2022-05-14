import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:clipboardoctor/providers/clipboard_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

import 'widgets/pinned_items.dart';
import 'widgets/unpinned_items.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClipBoardSecondState();
}

class _ClipBoardSecondState extends ConsumerState<HomeScreen> with ClipboardListener {
  @override
  void initState() {
    clipboardWatcher.addListener(this);
    // start watch
    clipboardWatcher.start();
    ref.read(clipboardItemsProvider.notifier).getData(ref.read);
    super.initState();
  }

  @override
  void dispose() {
    clipboardWatcher.removeListener(this);
    // stop watch
    clipboardWatcher.stop();
    super.dispose();
  }

  @override
  void onClipboardChanged() async {
    ClipboardData? newClipboardData = await Clipboard.getData(Clipboard.kTextPlain);

    final String? newText = newClipboardData?.text;
    if (newText == null) return;
    newText.trimLeft();
    newText.trimRight();
    if (newText.isNotEmpty) {
      ref.read(clipboardItemsProvider.notifier).addItem(newText);
    }
  }

  int pageIndex = 0;

  late final searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final clipboardItems = ref.watch(clipboardItemsProvider);
    return MacosWindow(
      // child: IndexedStack(
      //   index: pageIndex,
      //   children: [
      //     ContentArea(
      //       builder: (BuildContext context, ScrollController scrollController) {
      //         return Material(
      //           child: SingleChildScrollView(
      //             child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 PinnedItemsWidget(clipboardItems: clipboardItems.where((element) => element.pinned).toList()),
      //                 const Divider(),
      //                 UnpinnedItemsWidget(clipboardItems: clipboardItems.where((element) => !element.pinned).toList()),
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      titleBar: const TitleBar(
        height: 50,
        title: Text('Clipboard Doctor'),
      ),
      sidebar: Sidebar(
          builder: (context, controller) {
            return SidebarItems(currentIndex: 0, onChanged: (i) {}, scrollController: controller, items: [
              const SidebarItem(
                leading: MacosIcon(CupertinoIcons.home),
                label: Text('Home'),
              ),
              SidebarItem(
                  leading: const MacosIcon(CupertinoIcons.delete),
                  label: TextButton(
                    child: const Text('Clear Data'),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MacosAlertDialog(
                          appIcon: const MacosIcon(CupertinoIcons.delete),
                          message: const Text('Are you sure you want to clear all items?'),
                          primaryButton: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  ref.read(clipboardItemsProvider.notifier).clearUnpinnedData();
                                  Navigator.pop(context);
                                  // Navigator.pop(context);
                                },
                                child: const Text('Keep pinned items'),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref.read(clipboardItemsProvider.notifier).clearAllData();
                                  Navigator.pop(context);
                                },
                                child: const Text('Delete everything'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                          title: const Text('Caution'),
                        );
                      },
                    ),
                  ))
            ]);
          },
          bottom: const MacosListTile(
            leading: MacosIcon(CupertinoIcons.info),
            title: Text('Request a feature'),
            subtitle: Text('huthaifa@rhinosoft.io'),
          ),
          minWidth: 200),
      child: MacosScaffold(children: [
        ContentArea(
          builder: (BuildContext context, ScrollController scrollController) {
            return Material(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PinnedItemsWidget(clipboardItems: clipboardItems.where((element) => element.pinned).toList()),
                    const Divider(),
                    UnpinnedItemsWidget(clipboardItems: clipboardItems.where((element) => !element.pinned).toList()),
                  ],
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
