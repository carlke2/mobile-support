import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final config = await AppConfig.load();
  final releaseError = config.releaseUrlError;
  if (releaseError != null) {
    runApp(
      SetupRequiredApp(
        config: config,
        messageOverride: releaseError,
      ),
    );
    return;
  }
  if (!config.canLaunch) {
    runApp(SetupRequiredApp(config: config));
    return;
  }
  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(config)],
      child: const App(),
    ),
  );
}
