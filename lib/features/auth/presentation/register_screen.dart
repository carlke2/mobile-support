import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/pending_route.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/glass_button.dart';
import '../application/auth_controller.dart';
import '../domain/auth_destinations.dart';
import 'auth_fields.dart';
import 'auth_scaffold.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _submitting = false;
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _serverError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validate() {
    final nameError = _nameController.text.trim().isEmpty
        ? 'Name is required'
        : null;
    final emailError = emailMessage(_emailController.text.trim());
    final phoneError = phoneMessage(_phoneController.text);
    final passwordError = passwordMessage(_passwordController.text);
    setState(() {
      _nameError = nameError;
      _emailError = emailError;
      _phoneError = phoneError;
      _passwordError = passwordError;
      _serverError = null;
    });
    return nameError == null &&
        emailError == null &&
        phoneError == null &&
        passwordError == null;
  }

  Future<void> _submit() async {
    if (_submitting || !_validate()) {
      return;
    }
    setState(() => _submitting = true);
    try {
      final user = await ref
          .read(authControllerProvider.notifier)
          .register(
            name: _nameController.text.trim(),
            email: _emailController.text.trim().toLowerCase(),
            phone: _phoneController.text.trim(),
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
    } on ApiException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _serverError = error.message);
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() => _serverError = 'Could not create the account.');
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
            'Create account',
            style: AppTypography.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            key: const Key('name-field'),
            controller: _nameController,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.name],
            style: AppTypography.body,
            cursorColor: AppColors.accent,
            decoration: authFieldDecoration(label: 'Name', error: _nameError),
          ),
          const SizedBox(height: AppSpacing.sm),
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
            key: const Key('phone-field'),
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.telephoneNumber],
            style: AppTypography.body,
            cursorColor: AppColors.accent,
            decoration: authFieldDecoration(label: 'Phone', error: _phoneError),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            key: const Key('password-field'),
            controller: _passwordController,
            obscureText: _obscure,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.newPassword],
            onSubmitted: (_) => _submit(),
            style: AppTypography.body,
            cursorColor: AppColors.accent,
            decoration: authFieldDecoration(
              label: 'Password',
              error: _passwordError,
              suffix: _visibilityToggle(),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (_serverError != null) ...[
            Text(_serverError!, style: AppTypography.error),
            const SizedBox(height: AppSpacing.sm),
          ],
          GlassButton(
            key: const Key('register-button'),
            label: 'Create account',
            variant: GlassButtonVariant.primary,
            expand: true,
            loading: _submitting,
            onPressed: _submit,
          ),
          TextButton(
            onPressed: () => context.go(AppRoutes.login),
            child: const Text('Sign in', style: AppTypography.label),
          ),
        ],
      ),
    );
  }

  Widget _visibilityToggle() {
    return Semantics(
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
    );
  }
}
