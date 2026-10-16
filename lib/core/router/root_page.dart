import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Stack root: no iOS swipe-back, Android back minimizes the app.
class RootPage<T> extends NoTransitionPage<T> {
  RootPage({
    required Widget child,
    super.key,
    super.name,
  }) : super(
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                return;
              }
              minimizeApp();
            },
            child: child,
          ),
        );

  /// Overridden in widget tests so route replacement does not call the platform.
  static void Function() minimizeApp = SystemNavigator.pop;
}
