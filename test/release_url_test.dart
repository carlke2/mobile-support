import 'package:boardroom/core/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('release mode rejects http', () {
    expect(
      AppConfig.releaseUrlErrorFor(
        'http://192.168.0.10:5000',
        releaseMode: true,
      ),
      contains('https'),
    );
    expect(
      AppConfig.releaseUrlErrorFor(
        'https://api.example.com',
        releaseMode: true,
      ),
      isNull,
    );
  });

  test('debug mode allows http', () {
    expect(
      AppConfig.releaseUrlErrorFor(
        'http://192.168.0.10:5000',
        releaseMode: false,
      ),
      isNull,
    );
  });
}
