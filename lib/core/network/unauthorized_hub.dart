import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Breaks the ApiClient ↔ AuthController import cycle.
class UnauthorizedHub {
  /// Refresh token rejected (`refresh_invalid`) → expired message.
  Future<void> Function()? onRefreshInvalid;

  /// Access token not verifiable (`token_invalid`) → signed out.
  Future<void> Function()? onTokenInvalid;
}

final unauthorizedHubProvider = Provider<UnauthorizedHub>((ref) {
  return UnauthorizedHub();
});
