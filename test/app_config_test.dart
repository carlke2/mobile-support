import 'package:boardroom/core/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('parseDotEnv reads the backend url key', () {
    final values = parseDotEnv('''
# comment
API_BASE_URL="http://192.168.0.10:5000"
PAGE_SIZE=20
''');
    expect(values['API_BASE_URL'], 'http://192.168.0.10:5000');
    expect(values['PAGE_SIZE'], '20');
  });

  test('load uses env/dev.json and can launch', () async {
    final config = await AppConfig.load();
    expect(config.apiBaseUrl, isNotEmpty);
    expect(config.canLaunch, isTrue);
    expect(config.setupMessage, isEmpty);
  });

  test('a blank url cannot launch', () {
    final config = AppConfig.fromValues(const {'API_BASE_URL': ''});
    expect(config.apiBaseUrl, isEmpty);
    expect(config.canLaunch, isFalse);
    expect(config.setupMessage, 'Backend URL missing.');
  });
}
