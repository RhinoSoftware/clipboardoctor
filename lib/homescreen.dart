import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:clipboardoctor/providers/clipboard_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

import 'widgets/clipboard_widgets/pinned_items.dart';
import 'widgets/clipboard_widgets/all_items.dart';
import 'widgets/search_widget.dart';
import 'widgets/macos_platform_menu.dart';

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
    _focusNode.requestFocus();
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

  final FocusNode _focusNode = FocusNode();
  int pageIndex = 0;
  final List<String> _tabs = ['All Items', 'Pinned Items', 'buttons'];
  List<Widget> pages = [
    const AllItems(),
    const PinnedItems(),
  ];
  @override
  Widget build(BuildContext context) {
    return PlatformMenuBar(
      menus: macosPlatformMenu,
      body: MacosWindow(
        titleBar: const TitleBar(
          height: 50,
          title: Text('Clipboard Doctor'),
        ),
        child: MacosScaffold(
            toolBar: ToolBar(
              title: Text(
                _tabs[pageIndex],
              ),
              titleWidth: 150.0,
              actions: [
                ToolBarIconButton(
                  label: 'Clear Data',
                  icon: const MacosIcon(
                    CupertinoIcons.delete,
                  ),
                  onPressed: () => clearDataMethod(context),
                  showLabel: true,
                ),
              ],
            ),
            children: [
              ContentArea(builder: (context, scrollController) {
                return IndexedStack(index: pageIndex, children: pages);
              })
            ]),
        sidebar: Sidebar(
          minWidth: 200,
          top: SearchWidget(),
          builder: (context, controller) {
            return SidebarItems(
                currentIndex: pageIndex,
                onChanged: (i) => setState(() => pageIndex = i),
                scrollController: controller,
                items: [
                  SidebarItem(
                    focusNode: _focusNode,
                    leading: const MacosIcon(CupertinoIcons.list_bullet),
                    label: const Text('All Items'),
                  ),
                  const SidebarItem(
                    leading: MacosIcon(CupertinoIcons.infinite),
                    label: Text('Pinned'),
                  ),
                ]);
          },
          bottom: const MacosListTile(
            leading: MacosIcon(CupertinoIcons.info),
            title: Text('Request a feature'),
            subtitle: Text('huthaifa@rhinosoft.io'),
          ),
        ),
      ),
    );
  }

  Future<dynamic> clearDataMethod(BuildContext context) {
    return showDialog(
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
    );
  }
}
