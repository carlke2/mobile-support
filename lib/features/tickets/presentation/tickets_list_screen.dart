import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/connectivity_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/async_body.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../dashboard/application/shell_nav.dart';
import '../data/tickets_api.dart';
import '../domain/ticket_models.dart';

class TicketsListScreen extends ConsumerStatefulWidget {
  const TicketsListScreen({
    super.key,
    required this.roleRoot,
    this.showFab = true,
  });

  final String roleRoot;
  final bool showFab;

  @override
  ConsumerState<TicketsListScreen> createState() => _TicketsListScreenState();
}

class _TicketsListScreenState extends ConsumerState<TicketsListScreen> {
  final _search = TextEditingController();
  final _items = <TicketSummary>[];
  TicketPageCursor? _next;
  var _loading = true;
  var _loadingMore = false;
  String? _error;
  String? _status;
  TicketListQuery _filter = const TicketListQuery();
  var _heardToken = -1;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nav = ref.watch(shellNavProvider);
    if (nav.token != _heardToken) {
      _heardToken = nav.token;
      _filter = nav.ticketFilter;
      _status = _filter.status;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _reload();
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: widget.showFab
          ? FloatingActionButton.extended(
              key: const Key('create-ticket-fab'),
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.onAccent,
              onPressed: () => context.push('${widget.roleRoot}/tickets/new'),
              label: const Text('New ticket'),
              icon: const Icon(Icons.add),
            )
          : null,
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
                  const Text('Tickets', style: AppTypography.title),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    key: const Key('ticket-search'),
                    controller: _search,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _reload(),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final status in const [
                          null,
                          'OPEN',
                          'PENDING_CUSTOMER',
                          'RESOLVED',
                          'CLOSED',
                        ])
                          Padding(
                            padding: const EdgeInsets.only(right: AppSpacing.sm),
                            child: ChoiceChip(
                              label: Text(status ?? 'All'),
                              selected: _status == status,
                              onSelected: (_) {
                                setState(() => _status = status);
                                _reload();
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (_filter.sla != null || _filter.priority != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sm),
                      child: Text(
                        [
                          if (_filter.sla != null) 'SLA: ${_filter.sla}',
                          if (_filter.priority != null)
                            'Priority: ${_filter.priority}',
                        ].join(' · '),
                        style: AppTypography.caption,
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: AsyncBody(
                loading: _loading,
                errorMessage: _error,
                empty: _items.isEmpty,
                emptyMessage: 'No tickets.',
                onRetry: _reload,
                onRefresh: _reload,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal,
                  ),
                  itemCount: _items.length + (_next != null ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= _items.length) {
                      if (!_loadingMore) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _loadMore();
                        });
                      }
                      return const Padding(
                        padding: EdgeInsets.all(AppSpacing.md),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.accent,
                          ),
                        ),
                      );
                    }
                    final ticket = _items[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Semantics(
                        button: true,
                        label: '${ticket.number} ${ticket.subject}',
                        child: InkWell(
                          onTap: () => context.push(
                            '${widget.roleRoot}/tickets/${ticket.id}',
                          ),
                          child: GlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${ticket.number} · ${ticket.subject}',
                                  style: AppTypography.label,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  '${ticket.status} · ${ticket.priority}',
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _reload() async {
    setState(() {
      _loading = true;
      _error = null;
      _items.clear();
      _next = null;
    });
    try {
      final pageSize = ref.read(appConfigProvider).pageSize;
      final page = await ref.read(ticketsApiProvider).list(
            TicketListQuery(
              status: _status ?? _filter.status,
              priority: _filter.priority,
              assignee: _filter.assignee,
              sla: _filter.sla,
              search: _search.text.trim().isEmpty ? null : _search.text.trim(),
              limit: pageSize,
            ),
          );
      if (!mounted) {
        return;
      }
      setState(() {
        _items.addAll(page.tickets);
        _next = page.next;
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

  Future<void> _loadMore() async {
    final cursor = _next;
    if (cursor == null || _loadingMore) {
      return;
    }
    setState(() => _loadingMore = true);
    try {
      final pageSize = ref.read(appConfigProvider).pageSize;
      final page = await ref.read(ticketsApiProvider).list(
            TicketListQuery(
              status: _status ?? _filter.status,
              priority: _filter.priority,
              assignee: _filter.assignee,
              sla: _filter.sla,
              search: _search.text.trim().isEmpty ? null : _search.text.trim(),
              limit: pageSize,
              before: cursor.before,
              beforeId: cursor.beforeId,
            ),
          );
      if (!mounted) {
        return;
      }
      setState(() {
        _items.addAll(page.tickets);
        _next = page.next;
        _loadingMore = false;
      });
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() => _loadingMore = false);
    }
  }

  String _message(Object error) {
    if (error is ApiException) {
      return displayMessageFor(error);
    }
    if (error is ConnectivityException) {
      return error.failure.message;
    }
    return 'Could not load tickets.';
  }
}
