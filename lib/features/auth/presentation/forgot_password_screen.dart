import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/glass_button.dart';
import '../application/auth_controller.dart';
import 'auth_fields.dart';
import 'auth_scaffold.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _submitting = false;
  bool _sent = false;
  String? _emailError;
  String? _serverError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final emailError = emailMessage(_emailController.text.trim());
    setState(() {
      _emailError = emailError;
      _serverError = null;
    });
    if (_submitting || emailError != null) {
      return;
    }
    setState(() => _submitting = true);
    try {
      await ref
          .read(authControllerProvider.notifier)
          .forgotPassword(email: _emailController.text.trim().toLowerCase());
      if (!mounted) {
        return;
      }
      setState(() => _sent = true);
    } on ApiException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _serverError = error.message);
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() => _serverError = 'Could not send the reset link.');
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
            'Forgot password?',
            style: AppTypography.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Enter your email and we will send a reset link if an account exists.',
            style: AppTypography.caption,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          if (_sent)
            const Text(
              'If an account exists for that email, a reset link is on the way.',
              key: Key('reset-sent'),
              style: AppTypography.body,
            )
          else ...[
            TextField(
              key: const Key('email-field'),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.email],
              onSubmitted: (_) => _submit(),
              style: AppTypography.body,
              cursorColor: AppColors.accent,
              decoration: authFieldDecoration(
                label: 'Email',
                error: _emailError,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            if (_serverError != null) ...[
              Text(_serverError!, style: AppTypography.error),
              const SizedBox(height: AppSpacing.sm),
            ],
            GlassButton(
              key: const Key('forgot-button'),
              label: 'Send reset link',
              variant: GlassButtonVariant.primary,
              expand: true,
              loading: _submitting,
              onPressed: _submit,
            ),
          ],
          TextButton(
            onPressed: () => context.go(AppRoutes.login),
            child: const Text('Sign in', style: AppTypography.label),
          ),
        ],
      ),
    );
  }
}
