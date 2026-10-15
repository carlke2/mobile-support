import 'package:json_annotation/json_annotation.dart';

part 'health_status.g.dart';

/// Body of `GET /health`: `{ "ok": true, "time": "<iso>" }`.
@JsonSerializable()
class HealthStatus {
  const HealthStatus({required this.ok, this.time});

  final bool ok;
  final String? time;

  factory HealthStatus.fromJson(Map<String, dynamic> json) =>
      _$HealthStatusFromJson(json);

  Map<String, dynamic> toJson() => _$HealthStatusToJson(this);
}
