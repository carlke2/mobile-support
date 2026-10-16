import 'package:boardroom/core/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('parseDotEnv reads the backend url', () {
    final values = parseDotEnv('''
# comment
API_BASE_URL="http://127.0.0.1:5000"
PAGE_SIZE=20
''');
    expect(values['API_BASE_URL'], 'http://127.0.0.1:5000');
    expect(values['PAGE_SIZE'], '20');
  });

  test('load uses env/dev.json and can launch', () async {
    final config = await AppConfig.load();
    expect(config.apiBaseUrl, defaultApiBaseUrl);
    expect(config.canLaunch, isTrue);
    expect(config.setupMessage, isEmpty);
  });

  test('a blank url falls back to the local backend', () {
    final config = AppConfig.fromValues(const {'API_BASE_URL': ''});
    expect(config.apiBaseUrl, defaultApiBaseUrl);
    expect(config.canLaunch, isTrue);
  });
}
