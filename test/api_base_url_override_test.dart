import 'package:boardroom/core/config/app_config.dart';
import 'package:boardroom/core/network/api_base_url.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('debug session override is not persisted', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(apiBaseUrl: 'http://10.0.0.1:5000'),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(effectiveApiBaseUrlProvider), 'http://10.0.0.1:5000');
    container
        .read(apiBaseUrlOverrideProvider.notifier)
        .setOverride('http://10.0.0.2:5000');
    expect(container.read(effectiveApiBaseUrlProvider), 'http://10.0.0.2:5000');

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getKeys(), isEmpty);

    container.read(apiBaseUrlOverrideProvider.notifier).setOverride(null);
    expect(container.read(effectiveApiBaseUrlProvider), 'http://10.0.0.1:5000');
  });
}
