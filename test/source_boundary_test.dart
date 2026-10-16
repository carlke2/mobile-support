import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('library and package manifest omit the removed vendor name', () {
    final needle = String.fromCharCodes(const <int>[
      115,
      117,
      112,
      97,
      98,
      97,
      115,
      101,
    ]);
    final hits = <String>[];
    _scan(File('pubspec.yaml'), needle, hits);
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is File) {
        _scan(entity, needle, hits);
      }
    }
    expect(hits, isEmpty);
  });
}

void _scan(File file, String needle, List<String> hits) {
  final text = file.readAsStringSync().toLowerCase();
  if (text.contains(needle)) {
    hits.add(file.path);
  }
}
