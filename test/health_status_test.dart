import 'package:boardroom/core/network/health_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('chip labels for connected and unreachable', () {
    const up = HealthCheckResult(connected: true, latencyMs: 12);
    const down = HealthCheckResult(connected: false, latencyMs: 30);
    expect(up.chipLabel, 'Connected');
    expect(down.chipLabel, "Can't reach server");
  });
}
