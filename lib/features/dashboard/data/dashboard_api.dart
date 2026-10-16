import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../domain/dashboard_models.dart';

/// Express dashboard routes from docs/API.md.
abstract class DashboardApi {
  Future<UserDashboard> user();

  Future<StaffDashboard> staff();

  Future<AdminDashboard> admin();
}

class ExpressDashboardApi implements DashboardApi {
  ExpressDashboardApi(this._client);

  final ApiClient _client;

  @override
  Future<UserDashboard> user() async {
    final body = await _client.get('/dashboard/user');
    return UserDashboard.fromJson(body);
  }

  @override
  Future<StaffDashboard> staff() async {
    final body = await _client.get('/dashboard/staff');
    return StaffDashboard.fromJson(body);
  }

  @override
  Future<AdminDashboard> admin() async {
    final body = await _client.get('/dashboard/admin');
    return AdminDashboard.fromJson(body);
  }
}

final dashboardApiProvider = Provider<DashboardApi>((ref) {
  return ExpressDashboardApi(ref.watch(apiClientProvider));
});
