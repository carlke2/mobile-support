import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_base_url.dart';
import 'connection_failure.dart';

/// Result of GET /health. Never blocks sign-in.
class HealthCheckResult {
  const HealthCheckResult({
    required this.connected,
    required this.latencyMs,
    this.failure,
    this.requestId,
  });

  final bool connected;
  final int? latencyMs;
  final ConnectionFailure? failure;
  final String? requestId;

  String get chipLabel => connected ? 'Connected' : "Can't reach server";
}

class HealthStatusNotifier extends AsyncNotifier<HealthCheckResult> {
  static const timeout = Duration(seconds: 3);

  @override
  Future<HealthCheckResult> build() => check();

  Future<HealthCheckResult> check() async {
    final baseUrl = ref.read(effectiveApiBaseUrlProvider);
    final result = await probe(baseUrl);
    state = AsyncData(result);
    return result;
  }

  /// Isolated for tests. Uses a 3s timeout Dio client.
  static Future<HealthCheckResult> probe(String baseUrl) async {
    final started = DateTime.now();
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        sendTimeout: timeout,
        receiveTimeout: timeout,
        headers: const {'Accept': 'application/json'},
        responseType: ResponseType.plain,
        validateStatus: (status) => status != null,
      ),
    );
    try {
      final response = await dio.get<Object?>('/health');
      final latency = DateTime.now().difference(started).inMilliseconds;
      final requestId = response.headers.value('x-request-id');
      final status = response.statusCode ?? 0;
      if (status >= 200 && status < 300) {
        return HealthCheckResult(
          connected: true,
          latencyMs: latency,
          requestId: requestId,
        );
      }
      return HealthCheckResult(
        connected: false,
        latencyMs: latency,
        requestId: requestId,
        failure: ConnectionFailure.fromStatus(
          baseUrl: baseUrl,
          statusCode: status,
          requestId: requestId,
        ),
      );
    } on DioException catch (error) {
      return HealthCheckResult(
        connected: false,
        latencyMs: DateTime.now().difference(started).inMilliseconds,
        failure: ConnectionFailure.fromDio(error, baseUrl: baseUrl),
        requestId: error.response?.headers.value('x-request-id'),
      );
    } finally {
      dio.close();
    }
  }
}

final healthStatusProvider =
    AsyncNotifierProvider<HealthStatusNotifier, HealthCheckResult>(
      HealthStatusNotifier.new,
    );
