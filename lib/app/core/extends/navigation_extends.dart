import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationExtension on BuildContext {
  /// Pops the current route when there is something to pop, otherwise falls
  /// back to [route]. Avoids the `GoError` raised when the screen was opened
  /// directly (deep link, initial route or a redirect).
  void popOrGo(String route) {
    if (canPop()) {
      pop();
      return;
    }

    go(route);
  }
}
