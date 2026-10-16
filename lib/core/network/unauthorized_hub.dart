import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef UnauthorizedHandler = Future<void> Function();

/// Breaks the ApiClient ↔ AuthController import cycle.
class UnauthorizedHub {
  UnauthorizedHandler? handler;

  Future<void> notify() async {
    final next = handler;
    if (next != null) {
      await next();
    }
  }
}

final unauthorizedHubProvider = Provider<UnauthorizedHub>((ref) {
  return UnauthorizedHub();
});
