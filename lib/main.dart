import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

//provider for theme color and dark mode
final themeProvider = StateProvider<bool>((ref) => true);

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  void _getThemeSavedData(Reader read) async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getBool('clipoarddoctortheme');
    if (theme != null) {
      read(themeProvider.state).update((state) => theme);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    _getThemeSavedData(ref.read);
    return MacosApp(
      debugShowCheckedModeBanner: false,
      title: 'Clipboard Doctor',
      theme: ref.watch(themeProvider) ? MacosThemeData.dark() : MacosThemeData.light(),
      home: const HomeScreen(),
    );
  }
}
