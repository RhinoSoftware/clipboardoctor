import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'clipboard_watcher.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
//provider for theme color and dark mode
final themeProvider = StateProvider<bool>((ref) => true);
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clipboard Doctor',
      theme: ref.watch(themeProvider) ? ThemeData.dark() : ThemeData.light(),

      home: const ClipBoardSecond(),
    );
  }
}
