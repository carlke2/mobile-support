import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Set when a recovery deep link arrives before the router is listening.
bool pendingPasswordRecovery = false;

class PasswordRecoveryNotifier extends Notifier<bool> {
  @override
  bool build() => pendingPasswordRecovery;

  void begin() {
    pendingPasswordRecovery = true;
    state = true;
  }

  void clear() {
    pendingPasswordRecovery = false;
    state = false;
  }
}

final passwordRecoveryProvider =
    NotifierProvider<PasswordRecoveryNotifier, bool>(
      PasswordRecoveryNotifier.new,
    );
