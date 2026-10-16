import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/boardroom_api.dart';

/// Counts from `GET /home/counts`. Zeros are real numbers, not a missing response.
class HomeCounts {
  const HomeCounts({
    required this.openTickets,
    required this.unreadNotifications,
    required this.upcomingBookings,
  });

  final int openTickets;
  final int unreadNotifications;
  final int upcomingBookings;

  bool get isEmpty =>
      openTickets == 0 && unreadNotifications == 0 && upcomingBookings == 0;

  factory HomeCounts.fromRpc(Map<String, dynamic> json) {
    return HomeCounts(
      openTickets: _count(json['openTickets']),
      unreadNotifications: _count(json['unreadNotifications']),
      upcomingBookings: _count(json['upcomingBookings']),
    );
  }

  static int _count(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse('$value') ?? 0;
  }
}

final homeCountsProvider = FutureProvider.autoDispose<HomeCounts>((ref) async {
  final api = ref.watch(boardroomApiProvider);
  try {
    return HomeCounts.fromRpc(await api.homeCounts());
  } on ApiException {
    rethrow;
  } on Object {
    throw const ApiException.backend(
      message: 'Could not load your home counts.',
    );
  }
});
