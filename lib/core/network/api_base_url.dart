import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';

/// Session-only override of the Express base URL (debug address screen).
/// Never written to disk or secure storage.
class ApiBaseUrlOverride extends Notifier<String?> {
  @override
  String? build() => null;

  void setOverride(String? value) {
    final trimmed = value?.trim();
    state = (trimmed == null || trimmed.isEmpty) ? null : trimmed;
  }
}

final apiBaseUrlOverrideProvider =
    NotifierProvider<ApiBaseUrlOverride, String?>(ApiBaseUrlOverride.new);

/// Effective base URL used by [apiClientProvider]. The only place outside
/// [AppConfig] that resolves the address for HTTP.
final effectiveApiBaseUrlProvider = Provider<String>((ref) {
  final override = ref.watch(apiBaseUrlOverrideProvider);
  if (override != null && override.isNotEmpty) {
    return _trimTrailingSlash(override);
  }
  return ref.watch(appConfigProvider).apiBaseUrl;
});

String _trimTrailingSlash(String url) {
  if (url.endsWith('/')) {
    return url.substring(0, url.length - 1);
  }
  return url;
}
