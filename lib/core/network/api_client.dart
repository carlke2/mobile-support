import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_session.dart';
import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'api_exception.dart';
import 'auth_interceptor.dart';

/// Single Dio client for the Boardroom REST API.
class ApiClient {
  ApiClient({
    required AppConfig config,
    required TokenStorage tokenStorage,
    required void Function() onUnauthenticated,
    Dio? dio,
  }) : _dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: config.apiBaseUrl,
               connectTimeout: const Duration(seconds: 10),
               sendTimeout: const Duration(seconds: 20),
               receiveTimeout: const Duration(seconds: 20),
               contentType: Headers.jsonContentType,
               responseType: ResponseType.json,
               headers: <String, String>{
                 Headers.acceptHeader: Headers.jsonContentType,
               },
             ),
           ) {
    _dio.interceptors.add(
      AuthInterceptor(
        tokenStorage: tokenStorage,
        onUnauthenticated: onUnauthenticated,
      ),
    );
  }

  final Dio _dio;

  Future<Map<String, dynamic>> getJson(String path) async {
    try {
      final response = await _dio.get<dynamic>(path);
      return parseSuccessBody(response.data, statusCode: response.statusCode);
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }

  Future<Map<String, dynamic>> postJson(
    String path,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        path,
        data: body,
        options: headers == null ? null : Options(headers: headers),
      );
      return parseSuccessBody(response.data, statusCode: response.statusCode);
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }

  void dispose() {
    _dio.close(force: true);
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ApiClient(
    config: ref.watch(appConfigProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
    onUnauthenticated: () {
      ref.read(authSessionProvider.notifier).markUnauthenticated();
    },
  );
  ref.onDispose(client.dispose);
  return client;
});
