import 'package:boardroom/app.dart';
import 'package:boardroom/core/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('empty API base URL shows backend URL missing, not keys', (
    tester,
  ) async {
    const config = AppConfig();
    expect(config.canLaunch, isFalse);
    expect(config.setupMessage, 'Backend URL missing.');
    expect(config.setupMessage.toLowerCase().contains('key'), isFalse);

    await tester.pumpWidget(const SetupRequiredApp(config: config));
    expect(find.byKey(const Key('setup-error')), findsOneWidget);
    expect(find.text('Backend URL missing.'), findsOneWidget);
  });
}
