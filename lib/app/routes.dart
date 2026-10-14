import 'package:flutter/material.dart';

import '../features/app_view/presentation/app_view_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/web_view/presentation/web_view_screen.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const webView = '/web-view';
  static const appView = '/app-view';

  static final Map<String, WidgetBuilder> routes = {
    home: (_) => const HomeScreen(),
    webView: (_) => const WebViewScreen(),
    appView: (_) => const AppViewScreen(),
  };
}
