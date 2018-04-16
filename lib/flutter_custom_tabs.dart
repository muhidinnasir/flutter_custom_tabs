import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'src/custom_tabs_launcher.dart';
import 'src/url_launcher.dart';

/// Option class for customizing appearance of Custom Tabs.
/// **This option applies only on Android platform.**
///
/// See also:
///
/// * [CustomTabsIntent.Builder](https://developer.android.com/reference/android/support/customtabs/CustomTabsIntent.Builder.html)
///
class CustomTabsOption {

  /// Custom tab toolbar color.
  final Color toolbarColor;

  /// Enables the url bar to hide as the user scrolls down on the page.
  final bool enableUrlBarHiding;

  /// Adds a default share item to the menu.
  final bool enableDefaultShare;

  /// The page title should be shown in the custom tab.
  final bool showPageTitle;

  const CustomTabsOption({
    this.toolbarColor,
    this.enableUrlBarHiding,
    this.enableDefaultShare,
    this.showPageTitle,
  });

  Map<String, dynamic> toMap() {
    final dest = new Map<String, dynamic>();
    if (toolbarColor != null) {
      dest['toolbarColor'] = "#${toolbarColor.value.toRadixString(16)}";
    }
    if (enableUrlBarHiding != null) {
      dest['enableUrlBarHiding'] = enableUrlBarHiding;
    }
    if (enableDefaultShare != null) {
      dest['enableDefaultShare'] = enableDefaultShare;
    }
    if (showPageTitle != null) {
      dest['showPageTitle'] = showPageTitle;
    }
    return dest;
  }
}

/// Open the specified Web URL with custom tab.
///
/// Custom Tab is only supported on the Android platform.
/// Therefore, this plugin uses [url_launcher](https://pub.dartlang.org/packages/url_launcher) on iOS to launch SFSafariViewController.
/// (The specified [option] is ignored on iOS.)
///
/// When Chrome is not installed on Android device, try to start other browsers.
/// And throw [PlatformException] if browser is not installed.
///
/// Example:
///
/// ```dart
/// await launch(
///   'https://flutter.io',
///   option: new CustomTabsOption(
///     toolbarColor: Theme.of(context).primaryColor,
///     enableUrlBarHiding: true,
///     showPageTitle: true,
///   ),
/// );
/// ```
Future<void> launch(
  String urlString, {
  @required CustomTabsOption option,
}) {
  assert(urlString != null);
  assert(option != null);

  if (Platform.isAndroid) {
    return customTabsLauncher(urlString, option);
  } else {
    return urlLauncher(urlString);
  }
}
