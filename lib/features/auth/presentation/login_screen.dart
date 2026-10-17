import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/pending_route.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/connection_failure.dart';
import '../../../core/network/connectivity_exception.dart';
import '../../../core/network/health_status.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/connection_failure_panel.dart';
import '../../../shared/widgets/glass_button.dart';
import '../application/auth_controller.dart';
import '../domain/auth_destinations.dart';
import 'auth_fields.dart';
import 'auth_scaffold.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _submitting = false;
  String? _emailError;
  String? _passwordError;
  String? _serverError;
  ConnectionFailure? _connectionFailure;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validate() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final emailError = emailMessage(email);
    final passwordError = password.isEmpty ? 'Password is required' : null;
    setState(() {
      _emailError = emailError;
      _passwordError = passwordError;
      _serverError = null;
      _connectionFailure = null;
    });
    return emailError == null && passwordError == null;
  }

  Future<void> _submit() async {
    if (_submitting || !_validate()) {
      return;
    }
    setState(() => _submitting = true);
    try {
      final user = await ref
          .read(authControllerProvider.notifier)
          .signIn(
            email: _emailController.text.trim().toLowerCase(),
            password: _passwordController.text,
          );
      if (!mounted) {
        return;
      }
      final pending = ref.read(pendingRouteProvider);
      ref.read(pendingRouteProvider.notifier).clear();
      context.go(
        destinationAfterAuth(role: user.activeRole, pendingDeepLink: pending),
      );
    } on ConnectivityException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _connectionFailure = error.failure;
        _serverError = null;
      });
      await ref.read(healthStatusProvider.notifier).check();
    } on ApiException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _serverError = error.message;
        _connectionFailure = null;
      });
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() {
        _serverError = 'Sign in failed.';
        _connectionFailure = null;
      });
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = GoRouterState.of(context).uri.queryParameters;
    final expired = query[AppRoutes.expiredQuery] == '1';
    return AuthScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: AppLogo(size: 48)),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Sign in',
            style: AppTypography.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          if (expired) ...[
            const Text(
              AppRoutes.sessionExpiredMessage,
              key: Key('session-expired-message'),
              style: AppTypography.error,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          TextField(
            key: const Key('email-field'),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            style: AppTypography.body,
            cursorColor: AppColors.accent,
            decoration: authFieldDecoration(label: 'Email', error: _emailError),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            key: const Key('password-field'),
            controller: _passwordController,
            obscureText: _obscure,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            onSubmitted: (_) => _submit(),
            style: AppTypography.body,
            cursorColor: AppColors.accent,
            decoration: authFieldDecoration(
              label: 'Password',
              error: _passwordError,
              suffix: Semantics(
                button: true,
                label: _obscure ? 'Show password' : 'Hide password',
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: IconButton(
                    onPressed: () {
                      setState(() => _obscure = !_obscure);
                    },
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
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => context.push(AppRoutes.forgotPassword),
              child: const Text(
                'Forgot password?',
                style: AppTypography.caption,
              ),
            ),
          ),
          if (_connectionFailure != null) ...[
            ConnectionFailurePanel(
              failure: _connectionFailure!,
              onRetry: _submit,
            ),
            const SizedBox(height: AppSpacing.sm),
          ] else if (_serverError != null) ...[
            Text(_serverError!, style: AppTypography.error),
            const SizedBox(height: AppSpacing.sm),
          ],
          if (_connectionFailure == null)
            GlassButton(
              key: const Key('sign-in-button'),
              label: 'Sign in',
              variant: GlassButtonVariant.primary,
              expand: true,
              loading: _submitting,
              onPressed: _submit,
            ),
        ],
      ),
    );
  }
}
