import 'package:dio/dio.dart';

import '../storage/token_storage.dart';

/// Attaches `Authorization: Bearer <token>` and, on HTTP 401, clears the
/// token and emits [onUnauthenticated] so the router can leave protected routes.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.tokenStorage,
    required this.onUnauthenticated,
  });

  final TokenStorage tokenStorage;
  final void Function() onUnauthenticated;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final existing = options.headers['Authorization']?.toString().trim();
    if (existing != null && existing.isNotEmpty) {
      handler.next(options);
      return;
    }
    final token = await tokenStorage.readToken();
    final value = token?.trim();
    if (value != null && value.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $value';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await tokenStorage.clear();
      onUnauthenticated();
    }
    handler.next(err);
  }
}
