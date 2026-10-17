import 'package:boardroom/core/network/connection_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const base = 'http://10.0.0.5:5000';

  test('each failure reason maps to its message and suggestion', () {
    for (final reason in ConnectionFailureReason.values) {
      final failure = ConnectionFailure.forReason(
        reason: reason,
        baseUrl: base,
        statusCode: reason == ConnectionFailureReason.serverError ? 503 : null,
      );
      expect(failure.hostPort, '10.0.0.5:5000');
      expect(failure.message, isNotEmpty);
      expect(failure.suggestion, isNotEmpty);
      expect(
        failure.message,
        ConnectionFailure.messageFor(
          reason,
          statusCode: reason == ConnectionFailureReason.serverError ? 503 : null,
        ),
      );
      expect(failure.suggestion, ConnectionFailure.suggestionFor(reason));
    }
  });

  test('timed out suggestion mentions Wi-Fi and Reachable line', () {
    final failure = ConnectionFailure.forReason(
      reason: ConnectionFailureReason.timedOut,
      baseUrl: base,
    );
    expect(failure.message, contains('Timed out'));
    expect(failure.suggestion, contains('same Wi-Fi'));
    expect(failure.suggestion, contains('Reachable'));
  });

  test('server error includes status and request id when provided', () {
    final failure = ConnectionFailure.forReason(
      reason: ConnectionFailureReason.serverError,
      baseUrl: base,
      statusCode: 502,
      requestId: 'req-abc',
    );
    expect(failure.message, contains('502'));
    expect(failure.requestId, 'req-abc');
  });
}
