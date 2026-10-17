import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/connectivity_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/async_body.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../bookings/data/bookings_api.dart';
import '../../bookings/domain/booking_models.dart';
import '../../dashboard/presentation/widgets/dashboard_widgets.dart';
import '../data/rooms_api.dart';
import '../domain/room_models.dart';

class RoomsTab extends ConsumerStatefulWidget {
  const RoomsTab({super.key, required this.roleRoot});

  final String roleRoot;

  @override
  ConsumerState<RoomsTab> createState() => _RoomsTabState();
}

class _RoomsTabState extends ConsumerState<RoomsTab> {
  var _segment = 0;
  List<RoomSummary> _rooms = const [];
  List<Booking> _mine = const [];
  RoomDayView? _day;
  var _loading = true;
  String? _error;
  late String _dayIso;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now().toUtc();
    _dayIso =
        '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    Future<void>(() => _reload());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.md,
                AppSpacing.screenHorizontal,
                AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Rooms', style: AppTypography.title),
                  const SizedBox(height: AppSpacing.sm),
                  DashboardSegmented(
                    left: 'Day view',
                    right: 'My bookings',
                    index: _segment,
                    onChanged: (value) => setState(() => _segment = value),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AsyncBody(
                loading: _loading,
                errorMessage: _error,
                empty: _segment == 0
                    ? (_day?.rooms.isEmpty ?? true) && _rooms.isEmpty
                    : _mine.isEmpty,
                emptyMessage: _segment == 0 ? 'No rooms.' : 'No bookings.',
                onRetry: _reload,
                onRefresh: _reload,
                child: _segment == 0 ? _dayList() : _mineList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dayList() {
    final rooms = _day?.rooms ??
        _rooms
            .map(
              (room) => RoomDayEntry(
                id: room.id,
                name: room.name,
                capacity: room.capacity,
                location: room.location,
              ),
            )
            .toList();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(room.name, style: AppTypography.label),
                Text(
                  '${room.capacity} seats · ${room.location ?? '—'}',
                  style: AppTypography.caption,
                ),
                const SizedBox(height: AppSpacing.sm),
                if (room.bookings.isEmpty)
                  const Text('Free all day', style: AppTypography.caption)
                else
                  for (final booking in room.bookings)
                    Text(
                      '${booking.startAt} – ${booking.endAt}'
                      '${booking.meetingTitle == null ? '' : ' · ${booking.meetingTitle}'}',
                      style: AppTypography.caption,
                    ),
                const SizedBox(height: AppSpacing.sm),
                GlassButton(
                  label: 'Book',
                  variant: GlassButtonVariant.outlined,
                  onPressed: () => _openCreate(room.id, room.name),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mineList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      itemCount: _mine.length,
      itemBuilder: (context, index) {
        final booking = _mine[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.meetingTitle ?? 'Booking',
                  style: AppTypography.label,
                ),
                Text(
                  '${booking.startAt} – ${booking.endAt} · ${booking.status}',
                  style: AppTypography.caption,
                ),
                if (booking.status == 'CONFIRMED') ...[
                  const SizedBox(height: AppSpacing.sm),
                  GlassButton(
                    label: 'Cancel',
                    variant: GlassButtonVariant.outlined,
                    onPressed: () => _cancel(booking.id),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _reload() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final roomsApi = ref.read(roomsApiProvider);
      final bookingsApi = ref.read(bookingsApiProvider);
      final rooms = await roomsApi.list();
      final day = await roomsApi.day(_dayIso);
      final mine = await bookingsApi.mine();
      if (!mounted) {
        return;
      }
      setState(() {
        _rooms = rooms;
        _day = day;
        _mine = mine;
        _loading = false;
      });
    } on Object catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _error = _message(error);
      });
    }
  }

  Future<void> _cancel(String id) async {
    try {
      await ref.read(bookingsApiProvider).cancel(id);
      await _reload();
    } on Object catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _error = _message(error));
    }
  }

  Future<void> _openCreate(String roomId, String roomName) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CreateBookingSheet(
        roomId: roomId,
        roomName: roomName,
        dayIso: _dayIso,
      ),
    );
    if (result == true) {
      await _reload();
    }
  }

  String _message(Object error) {
    if (error is ApiExceptionBackend && error.code == ApiErrorCode.conflict) {
      return conflictDisplayMessage(error);
    }
    if (error is ApiException) {
      return displayMessageFor(error);
    }
    if (error is ConnectivityException) {
      return error.failure.message;
    }
    return 'Could not load rooms.';
  }
}

class _CreateBookingSheet extends ConsumerStatefulWidget {
  const _CreateBookingSheet({
    required this.roomId,
    required this.roomName,
    required this.dayIso,
  });

  final String roomId;
  final String roomName;
  final String dayIso;

  @override
  ConsumerState<_CreateBookingSheet> createState() =>
      _CreateBookingSheetState();
}

class _CreateBookingSheetState extends ConsumerState<_CreateBookingSheet> {
  final _team = TextEditingController(text: 'Team');
  final _title = TextEditingController();
  var _startHour = 9;
  var _endHour = 10;
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    _team.dispose();
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: GlassCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Book ${widget.roomName}', style: AppTypography.title),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _team,
              decoration: const InputDecoration(labelText: 'Team name'),
            ),
            TextField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: _startHour,
                    decoration: const InputDecoration(labelText: 'Start hour'),
                    items: [
                      for (var h = 7; h <= 20; h++)
                        DropdownMenuItem(value: h, child: Text('$h:00')),
                    ],
                    onChanged: (v) {
                      if (v != null) {
                        setState(() => _startHour = v);
                      }
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: _endHour,
                    decoration: const InputDecoration(labelText: 'End hour'),
                    items: [
                      for (var h = 8; h <= 21; h++)
                        DropdownMenuItem(value: h, child: Text('$h:00')),
                    ],
                    onChanged: (v) {
                      if (v != null) {
                        setState(() => _endHour = v);
                      }
                    },
                  ),
                ),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                _error!,
                key: const Key('booking-clash-message'),
                style: AppTypography.error,
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            GlassButton(
              label: _busy ? 'Booking…' : 'Create booking',
              onPressed: _busy ? null : _submit,
            ),
            const SizedBox(height: AppSpacing.sm),
            GlassButton(
              label: 'Close',
              variant: GlassButtonVariant.outlined,
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final start =
        '${widget.dayIso}T${_startHour.toString().padLeft(2, '0')}:00:00.000Z';
    final end =
        '${widget.dayIso}T${_endHour.toString().padLeft(2, '0')}:00:00.000Z';
    try {
      await ref.read(bookingsApiProvider).create(
            roomId: widget.roomId,
            start: start,
            end: end,
            teamName: _team.text.trim().isEmpty ? 'Team' : _team.text.trim(),
            title: _title.text.trim().isEmpty ? null : _title.text.trim(),
          );
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(true);
    } on Object catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        if (error is ApiExceptionBackend &&
            error.code == ApiErrorCode.conflict) {
          _error = conflictDisplayMessage(error);
        } else if (error is ApiException) {
          _error = displayMessageFor(error);
        } else if (error is ConnectivityException) {
          _error = error.failure.message;
        } else {
          _error = 'Could not create booking.';
        }
      });
    }
  }
}
