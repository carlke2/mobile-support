import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Private deep link captured while signed out. Cleared after login.
class PendingRouteNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void capture(String location) {
    state = location;
  }

  void clear() {
    state = null;
  }
}

final pendingRouteProvider =
    NotifierProvider<PendingRouteNotifier, String?>(PendingRouteNotifier.new);
