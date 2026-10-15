import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/glass_button.dart';
import '../application/auth_controller.dart';
import 'auth_fields.dart';
import 'auth_scaffold.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, required this.token});

  final String token;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure = true;
  bool _submitting = false;
  bool _done = false;
  String? _passwordError;
  String? _confirmError;
  String? _serverError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (widget.token.isEmpty) {
      setState(() => _serverError = 'This reset link is missing a token.');
      return;
    }
    final passwordError = passwordMessage(_passwordController.text);
    final confirmError = _confirmController.text != _passwordController.text
        ? 'Passwords do not match'
        : null;
    setState(() {
      _passwordError = passwordError;
      _confirmError = confirmError;
      _serverError = null;
    });
    if (_submitting || passwordError != null || confirmError != null) {
      return;
    }
    setState(() => _submitting = true);
    try {
      await ref
          .read(authControllerProvider.notifier)
          .resetPassword(
            token: widget.token,
            newPassword: _passwordController.text,
          );
      if (!mounted) {
        return;
      }
      setState(() => _done = true);
    } on ApiException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _serverError = error.message);
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() => _serverError = 'Could not reset the password.');
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: AppLogo(size: 48)),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Reset password',
            style: AppTypography.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          if (widget.token.isEmpty)
            const Text(
              'This reset link is missing a token.',
              style: AppTypography.error,
            )
          else if (_done)
            const Text(
              'Password updated. Sign in with the new password.',
              key: Key('reset-done'),
              style: AppTypography.body,
            )
          else ...[
            TextField(
              key: const Key('password-field'),
              controller: _passwordController,
              obscureText: _obscure,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              style: AppTypography.body,
              cursorColor: AppColors.accent,
              decoration: authFieldDecoration(
                label: 'New password',
                error: _passwordError,
                suffix: Semantics(
                  button: true,
                  label: _obscure ? 'Show password' : 'Hide password',
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              key: const Key('confirm-field'),
              controller: _confirmController,
              obscureText: _obscure,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              style: AppTypography.body,
              cursorColor: AppColors.accent,
              decoration: authFieldDecoration(
                label: 'Confirm password',
                error: _confirmError,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            if (_serverError != null) ...[
              Text(_serverError!, style: AppTypography.error),
              const SizedBox(height: AppSpacing.sm),
            ],
            GlassButton(
              key: const Key('reset-button'),
              label: 'Update password',
              variant: GlassButtonVariant.primary,
              expand: true,
              loading: _submitting,
              onPressed: _submit,
            ),
          ],
          TextButton(
            onPressed: () => context.go('/login'),
            child: const Text('Sign in', style: AppTypography.label),
          ),
        ],
      ),
    );
  }
}
