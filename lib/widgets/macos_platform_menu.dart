import 'package:flutter/cupertino.dart';

List<PlatformMenu> macosPlatformMenu = const [
  PlatformMenu(
    label: 'Clipboard Doctor',
    menus: [
      PlatformProvidedMenuItem(
        type: PlatformProvidedMenuItemType.about,
      ),
      PlatformProvidedMenuItem(
        type: PlatformProvidedMenuItemType.quit,
      ),
    ],
  ),
  PlatformMenu(
    label: 'View',
    menus: [
      PlatformProvidedMenuItem(
        type: PlatformProvidedMenuItemType.toggleFullScreen,
      ),
    ],
  ),
  PlatformMenu(
    label: 'Window',
    menus: [
      PlatformProvidedMenuItem(
        type: PlatformProvidedMenuItemType.minimizeWindow,
      ),
      PlatformProvidedMenuItem(
        type: PlatformProvidedMenuItemType.zoomWindow,
      ),
    ],
  )
];
