import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_state.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/connectivity_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../auth/application/auth_controller.dart';
import '../../dashboard/presentation/widgets/dashboard_widgets.dart';
import '../data/tickets_api.dart';
import '../domain/ticket_models.dart';

class TicketDetailScreen extends ConsumerStatefulWidget {
  const TicketDetailScreen({super.key, required this.ticketId});

  final String ticketId;

  @override
  ConsumerState<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends ConsumerState<TicketDetailScreen> {
  final _reply = TextEditingController();
  TicketDetail? _ticket;
  var _loading = true;
  var _busy = false;
  String? _error;
  var _internal = false;
  var _score = 5;

  bool get _isStaff {
    final auth = ref.read(authControllerProvider);
    if (auth is! AuthSignedIn) {
      return false;
    }
    final role = auth.user.activeRole;
    return role == 'AGENT' || role == 'TEAM_LEAD' || role == 'ADMIN';
  }

  bool get _isUser {
    final auth = ref.read(authControllerProvider);
    return auth is AuthSignedIn && auth.user.activeRole == 'USER';
  }

  @override
  void initState() {
    super.initState();
    Future<void>(() => _load());
  }

  @override
  void dispose() {
    _reply.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticket = _ticket;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(ticket?.number ?? 'Ticket'),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SafeArea(
        child: _loading && ticket == null
            ? const Padding(
                padding: EdgeInsets.all(AppSpacing.screenHorizontal),
                child: DashboardSkeleton(),
              )
            : _error != null && ticket == null
                ? ListView(
                    padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
                    children: [
                      Text(_error!, style: AppTypography.body),
                      const SizedBox(height: AppSpacing.md),
                      GlassButton(
                        label: 'Try again',
                        variant: GlassButtonVariant.outlined,
                        onPressed: _load,
                      ),
                    ],
                  )
                : ticket == null
                    ? const SizedBox.shrink()
                    : ListView(
                        padding: const EdgeInsets.all(
                          AppSpacing.screenHorizontal,
                        ),
                        children: [
                          GlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(ticket.subject, style: AppTypography.title),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  '${ticket.status} · ${ticket.priority}',
                                  style: AppTypography.caption,
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(ticket.description, style: AppTypography.body),
                                if (_isStaff) ...[
                                  const SizedBox(height: AppSpacing.md),
                                  Text(
                                    'Assignee: ${ticket.assigneeId ?? 'Unassigned'}',
                                    style: AppTypography.caption,
                                  ),
                                  Text(
                                    'SLA response: ${ticket.slaResponseDue ?? '—'}',
                                    style: AppTypography.caption,
                                  ),
                                  Text(
                                    'SLA resolution: ${ticket.slaResolutionDue ?? '—'}',
                                    style: AppTypography.caption,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text('Comments', style: AppTypography.sectionTitle),
                          const SizedBox(height: AppSpacing.sm),
                          for (final comment in ticket.comments)
                            if (_isStaff || !comment.isInternal)
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.sm,
                                ),
                                child: GlassCard(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (comment.isInternal)
                                        const Text(
                                          'Internal note',
                                          key: Key('internal-note-label'),
                                          style: AppTypography.caption,
                                        ),
                                      Text(
                                        comment.body,
                                        style: AppTypography.body,
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        comment.createdAt,
                                        style: AppTypography.caption,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            key: const Key('ticket-reply'),
                            controller: _reply,
                            minLines: 2,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              labelText: 'Reply',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          if (_isStaff)
                            SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Internal note'),
                              value: _internal,
                              onChanged: (value) =>
                                  setState(() => _internal = value),
                            ),
                          GlassButton(
                            key: const Key('send-reply'),
                            label: _busy ? 'Sending…' : 'Send reply',
                            onPressed: _busy ? null : _sendReply,
                          ),
                          if (_isStaff &&
                              ticket.allowedTransitions.isNotEmpty) ...[
                            const SizedBox(height: AppSpacing.lg),
                            Text(
                              'Change status',
                              style: AppTypography.sectionTitle,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Wrap(
                              spacing: AppSpacing.sm,
                              children: [
                                for (final to in ticket.allowedTransitions)
                                  GlassButton(
                                    label: to,
                                    variant: GlassButtonVariant.outlined,
                                    onPressed: _busy
                                        ? null
                                        : () => _transition(to),
                                  ),
                              ],
                            ),
                          ],
                          if (_isUser && ticket.status == 'RESOLVED') ...[
                            const SizedBox(height: AppSpacing.lg),
                            Text('Rate this ticket', style: AppTypography.sectionTitle),
                            const SizedBox(height: AppSpacing.sm),
                            DropdownButtonFormField<int>(
                              key: const Key('ticket-rating'),
                              initialValue: _score,
                              items: [
                                for (var i = 1; i <= 5; i++)
                                  DropdownMenuItem(
                                    value: i,
                                    child: Text('$i'),
                                  ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _score = value);
                                }
                              },
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            GlassButton(
                              key: const Key('submit-rating'),
                              label: 'Submit rating',
                              onPressed: _busy ? null : _rate,
                            ),
                          ],
                          if (_error != null) ...[
                            const SizedBox(height: AppSpacing.md),
                            Text(_error!, style: AppTypography.error),
                          ],
                        ],
                      ),
      ),
    );
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final ticket =
          await ref.read(ticketsApiProvider).detail(widget.ticketId);
      if (!mounted) {
        return;
      }
      setState(() {
        _ticket = ticket;
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

  Future<void> _sendReply() async {
    final body = _reply.text.trim();
    if (body.isEmpty) {
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(ticketsApiProvider).comment(
            id: widget.ticketId,
            body: body,
            internal: _isStaff && _internal,
          );
      _reply.clear();
      await _load();
    } on Object catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _error = _message(error));
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _transition(String to) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final ticket = await ref.read(ticketsApiProvider).transition(
            id: widget.ticketId,
            to: to,
          );
      if (!mounted) {
        return;
      }
      setState(() {
        _ticket = ticket;
        _busy = false;
      });
    } on Object catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        _error = _message(error);
      });
    }
  }

  Future<void> _rate() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(ticketsApiProvider).rate(
            id: widget.ticketId,
            score: _score,
          );
      if (!mounted) {
        return;
      }
      setState(() => _busy = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thanks for your rating.')),
      );
    } on Object catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        _error = _message(error);
      });
    }
  }

  String _message(Object error) {
    if (error is ApiException) {
      return displayMessageFor(error);
    }
    if (error is ConnectivityException) {
      return error.failure.message;
    }
    return 'Request failed.';
  }
}
