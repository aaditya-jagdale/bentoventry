import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get currentContext => navigatorKey.currentContext;

  void navigate(Widget screen) {
    if (currentContext != null) {
      Navigator.push(
        currentContext!,
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }
}
