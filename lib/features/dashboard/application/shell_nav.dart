import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../tickets/domain/ticket_models.dart';

/// In-shell tab selection and ticket list filter for card → list jumps.
class ShellNavState {
  const ShellNavState({
    this.tabIndex = 0,
    this.ticketFilter = const TicketListQuery(),
    this.token = 0,
  });

  final int tabIndex;
  final TicketListQuery ticketFilter;
  final int token;

  ShellNavState copyWith({
    int? tabIndex,
    TicketListQuery? ticketFilter,
    int? token,
  }) {
    return ShellNavState(
      tabIndex: tabIndex ?? this.tabIndex,
      ticketFilter: ticketFilter ?? this.ticketFilter,
      token: token ?? this.token,
    );
  }
}

class ShellNavController extends Notifier<ShellNavState> {
  @override
  ShellNavState build() => const ShellNavState();

  void selectTab(int index) {
    state = state.copyWith(tabIndex: index, token: state.token + 1);
  }

  /// Returns false when the role has no Tickets tab (TEAM_LEAD) so the caller
  /// can push `/staff/tickets` instead.
  bool openTickets(String role, TicketListQuery filter) {
    final index = RoleTabs.tickets(role);
    if (index < 0) {
      state = state.copyWith(ticketFilter: filter, token: state.token + 1);
      return false;
    }
    state = ShellNavState(
      tabIndex: index,
      ticketFilter: filter,
      token: state.token + 1,
    );
    return true;
  }

  void openAlerts(String role) {
    final index = RoleTabs.alerts(role);
    if (index < 0) {
      return;
    }
    state = state.copyWith(tabIndex: index, token: state.token + 1);
  }

  void openRooms(String role) {
    final index = RoleTabs.rooms(role);
    if (index < 0) {
      return;
    }
    state = state.copyWith(tabIndex: index, token: state.token + 1);
  }

  void openBookings(String role) {
    final index = RoleTabs.bookings(role);
    if (index < 0) {
      return;
    }
    state = state.copyWith(tabIndex: index, token: state.token + 1);
  }

  void openUsers(String role) {
    final index = RoleTabs.users(role);
    if (index < 0) {
      return;
    }
    state = state.copyWith(tabIndex: index, token: state.token + 1);
  }

  void openTeam(String role) {
    final index = RoleTabs.team(role);
    if (index < 0) {
      return;
    }
    state = state.copyWith(tabIndex: index, token: state.token + 1);
  }
}

final shellNavProvider =
    NotifierProvider<ShellNavController, ShellNavState>(ShellNavController.new);

/// Tab indices matching [_tabsFor] in dashboard_screen.dart.
///
/// USER Rooms is index 2 when the Rooms tab is present. docs/API.md has no
/// Express route for `customers_can_book_rooms`, so USER always gets Rooms
/// (seed default is true); gated hide is reported as a gap.
abstract final class RoleTabs {
  static int tickets(String role) {
    switch (role) {
      case 'ADMIN':
        return 1;
      case 'TEAM_LEAD':
        return -1;
      case 'AGENT':
        return 1;
      default:
        return 1;
    }
  }

  static int rooms(String role) {
    switch (role) {
      case 'ADMIN':
        return -1;
      case 'TEAM_LEAD':
        return 2;
      case 'AGENT':
        return 2;
      default:
        return 2;
    }
  }

  static int alerts(String role) {
    switch (role) {
      case 'ADMIN':
        return -1;
      case 'TEAM_LEAD':
        return 3;
      case 'AGENT':
        return 3;
      default:
        return 3;
    }
  }

  static int bookings(String role) => role == 'ADMIN' ? 2 : -1;

  static int users(String role) => role == 'ADMIN' ? 3 : -1;

  static int team(String role) => role == 'TEAM_LEAD' ? 1 : -1;
}
