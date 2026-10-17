import 'dart:io';

import 'package:dio/dio.dart';

/// Why the phone could not complete a call to the Express API.
enum ConnectionFailureReason {
  timedOut,
  connectionRefused,
  noNetwork,
  dnsFailure,
  certificateError,
  serverError,
  unknown,
}

/// User-facing copy for a connectivity failure. Pure and testable.
class ConnectionFailure {
  const ConnectionFailure({
    required this.reason,
    required this.hostPort,
    required this.message,
    required this.suggestion,
    this.statusCode,
    this.requestId,
  });

  final ConnectionFailureReason reason;
  final String hostPort;
  final String message;
  final String suggestion;
  final int? statusCode;
  final String? requestId;

  static ConnectionFailure forReason({
    required ConnectionFailureReason reason,
    required String baseUrl,
    int? statusCode,
    String? requestId,
  }) {
    final hostPort = hostPortOf(baseUrl);
    return ConnectionFailure(
      reason: reason,
      hostPort: hostPort,
      message: messageFor(reason, statusCode: statusCode),
      suggestion: suggestionFor(reason),
      statusCode: statusCode,
      requestId: requestId,
    );
  }

  static String hostPortOf(String baseUrl) {
    try {
      final uri = Uri.parse(baseUrl);
      if (uri.host.isEmpty) {
        return baseUrl;
      }
      final port = uri.hasPort
          ? uri.port
          : (uri.scheme == 'https' ? 443 : 80);
      return '${uri.host}:$port';
    } on Object {
      return baseUrl;
    }
  }

  static String messageFor(
    ConnectionFailureReason reason, {
    int? statusCode,
  }) {
    switch (reason) {
      case ConnectionFailureReason.timedOut:
        return 'Timed out waiting for the server.';
      case ConnectionFailureReason.connectionRefused:
        return 'Connection refused.';
      case ConnectionFailureReason.noNetwork:
        return 'No network connection.';
      case ConnectionFailureReason.dnsFailure:
        return 'DNS lookup failed.';
      case ConnectionFailureReason.certificateError:
        return 'Certificate error.';
      case ConnectionFailureReason.serverError:
        return statusCode == null
            ? 'Server error.'
            : 'Server error (HTTP $statusCode).';
      case ConnectionFailureReason.unknown:
        return 'Unable to reach the server.';
    }
  }

  static String suggestionFor(ConnectionFailureReason reason) {
    switch (reason) {
      case ConnectionFailureReason.timedOut:
        return 'Check the phone is on the same Wi-Fi as the server and the address matches the server\'s Reachable line.';
      case ConnectionFailureReason.connectionRefused:
        return 'Confirm the API is running and listening on 0.0.0.0, then match the Reachable address in env/dev.json.';
      case ConnectionFailureReason.noNetwork:
        return 'Turn on Wi-Fi or mobile data, then tap Retry.';
      case ConnectionFailureReason.dnsFailure:
        return 'Use the server\'s numeric IP from its Reachable line instead of a host name.';
      case ConnectionFailureReason.certificateError:
        return 'Release builds need https. In debug, use http only against a trusted local server.';
      case ConnectionFailureReason.serverError:
        return 'The server responded with an error. Match X-Request-Id to the API log, then retry.';
      case ConnectionFailureReason.unknown:
        return 'Check the phone is on the same Wi-Fi as the server and the address matches the server\'s Reachable line.';
    }
  }

  static ConnectionFailureReason reasonFromDio(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return ConnectionFailureReason.timedOut;
    }
    if (error.type == DioExceptionType.badCertificate) {
      return ConnectionFailureReason.certificateError;
    }
    if (error.type == DioExceptionType.badResponse) {
      return ConnectionFailureReason.serverError;
    }
    final underlying = error.error;
    if (underlying is SocketException) {
      final text = '${underlying.message} ${underlying.osError}'.toLowerCase();
      if (text.contains('refused')) {
        return ConnectionFailureReason.connectionRefused;
      }
      if (text.contains('failed host lookup') ||
          text.contains('name or service not known') ||
          text.contains('nodename nor servname')) {
        return ConnectionFailureReason.dnsFailure;
      }
      if (text.contains('network is unreachable') ||
          text.contains('no address associated') ||
          text.contains('socketexception: network')) {
        return ConnectionFailureReason.noNetwork;
      }
      if (text.contains('connection reset') || text.contains('broken pipe')) {
        return ConnectionFailureReason.connectionRefused;
      }
    }
    if (error.type == DioExceptionType.connectionError) {
      final text = '${error.message} ${error.error}'.toLowerCase();
      if (text.contains('refused')) {
        return ConnectionFailureReason.connectionRefused;
      }
      if (text.contains('failed host lookup') || text.contains('dns')) {
        return ConnectionFailureReason.dnsFailure;
      }
      if (text.contains('certificate') || text.contains('handshake')) {
        return ConnectionFailureReason.certificateError;
      }
      if (text.contains('network is unreachable') ||
          text.contains('socket')) {
        return ConnectionFailureReason.noNetwork;
      }
    }
    return ConnectionFailureReason.unknown;
  }

  factory ConnectionFailure.fromDio(DioException error, {required String baseUrl}) {
    final reason = reasonFromDio(error);
    final status = error.response?.statusCode;
    final header = error.response?.headers.value('x-request-id');
    return forReason(
      reason: reason,
      baseUrl: baseUrl,
      statusCode: status,
      requestId: header,
    );
  }

  factory ConnectionFailure.fromStatus({
    required String baseUrl,
    required int statusCode,
    String? requestId,
  }) {
    return forReason(
      reason: ConnectionFailureReason.serverError,
      baseUrl: baseUrl,
      statusCode: statusCode,
      requestId: requestId,
    );
  }
}
