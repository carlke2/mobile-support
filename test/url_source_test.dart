import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('API_BASE_URL key is read only in app_config.dart', () {
    final hits = <String>[];
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }
      final text = entity.readAsStringSync();
      if (text.contains('API_BASE_URL')) {
        hits.add(entity.path.replaceAll('\\', '/'));
      }
    }
    expect(hits, [
      'lib/core/config/app_config.dart',
    ]);
  });

  test('lib has no hardcoded http(s) host URLs outside config/network helpers', () {
    final allowed = <String>{
      'lib/core/config/app_config.dart',
      // Comments / docs only — scanned separately if they grow URLs.
    };
    final url = RegExp(r'https?://[0-9A-Za-z]');
    final hits = <String>[];
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }
      final path = entity.path.replaceAll('\\', '/');
      if (allowed.contains(path)) {
        continue;
      }
      final text = entity.readAsStringSync();
      if (url.hasMatch(text)) {
        hits.add(path);
      }
    }
    expect(hits, isEmpty);
  });
}
