import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/connectivity_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../data/tickets_api.dart';

class CreateTicketScreen extends ConsumerStatefulWidget {
  const CreateTicketScreen({super.key, required this.roleRoot});

  final String roleRoot;

  @override
  ConsumerState<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends ConsumerState<CreateTicketScreen> {
  final _subject = TextEditingController();
  final _description = TextEditingController();
  final _category = TextEditingController();
  var _priority = 'MEDIUM';
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    _subject.dispose();
    _description.dispose();
    _category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('New ticket'),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
          children: [
            GlassCard(
              child: Column(
                children: [
                  TextField(
                    key: const Key('ticket-subject'),
                    controller: _subject,
                    decoration: const InputDecoration(labelText: 'Subject'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    key: const Key('ticket-description'),
                    controller: _description,
                    minLines: 4,
                    maxLines: 8,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    key: const Key('ticket-category'),
                    controller: _category,
                    decoration: const InputDecoration(
                      labelText: 'Category id (optional)',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DropdownButtonFormField<String>(
                    key: const Key('ticket-priority'),
                    initialValue: _priority,
                    decoration: const InputDecoration(labelText: 'Priority'),
                    items: const [
                      DropdownMenuItem(value: 'LOW', child: Text('LOW')),
                      DropdownMenuItem(value: 'MEDIUM', child: Text('MEDIUM')),
                      DropdownMenuItem(value: 'HIGH', child: Text('HIGH')),
                      DropdownMenuItem(value: 'URGENT', child: Text('URGENT')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _priority = value);
                      }
                    },
                  ),
                ],
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(_error!, style: AppTypography.error),
            ],
            const SizedBox(height: AppSpacing.lg),
            GlassButton(
              key: const Key('submit-ticket'),
              label: _busy ? 'Saving…' : 'Create ticket',
              onPressed: _busy ? null : _submit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final subject = _subject.text.trim();
    final description = _description.text.trim();
    if (subject.isEmpty || description.isEmpty) {
      setState(() => _error = 'Subject and description are required.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final ticket = await ref.read(ticketsApiProvider).create(
            subject: subject,
            description: description,
            categoryId: _category.text.trim().isEmpty
                ? null
                : _category.text.trim(),
            priority: _priority,
          );
      if (!mounted) {
        return;
      }
      context.go('${widget.roleRoot}/tickets/${ticket.id}');
    } on Object catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        _error = error is ApiException
            ? displayMessageFor(error)
            : error is ConnectivityException
                ? error.failure.message
                : 'Could not create the ticket.';
      });
    }
  }
}
