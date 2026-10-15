import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/glass_scene.dart';
import '../application/auth_controller.dart';
import '../domain/login_response.dart';
import 'role_selection_sheet.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validate() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final emailError = _emailMessage(email);
    final passwordError = password.isEmpty ? 'Password is required' : null;
    setState(() {
      _emailError = emailError;
      _passwordError = passwordError;
      _serverError = null;
    });
    return emailError == null && passwordError == null;
  }

  Future<void> _submit() async {
    if (_submitting || !_validate()) {
      return;
    }
    setState(() => _submitting = true);
    try {
      final response = await ref
          .read(authControllerProvider.notifier)
          .signIn(
            email: _emailController.text.trim().toLowerCase(),
            password: _passwordController.text,
          );
      if (!mounted) {
        return;
      }
      switch (response) {
        case LoginSession():
          context.go('/home');
        case LoginRoleSelection(:final pendingToken, :final roles):
          setState(() => _submitting = false);
          final role = await RoleSelectionSheet.show(context, roles);
          if (!mounted || role == null) {
            return;
          }
          await ref
              .read(authControllerProvider.notifier)
              .selectRole(pendingToken: pendingToken, role: role);
          if (!mounted) {
            return;
          }
          context.go('/home');
      }
    } on ApiException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _serverError = error.message);
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() => _serverError = 'Sign in failed.');
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: GlassScene(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                  vertical: AppSpacing.lg,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 48,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: GlassCard(
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
                            TextField(
                              key: const Key('email-field'),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.email],
                              style: AppTypography.body,
                              cursorColor: AppColors.accent,
                              decoration: _fieldDecoration(
                                label: 'Email',
                                error: _emailError,
                              ),
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
                              decoration: _fieldDecoration(
                                label: 'Password',
                                error: _passwordError,
                                suffix: Semantics(
                                  button: true,
                                  label: _obscure
                                      ? 'Show password'
                                      : 'Hide password',
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
                                onPressed: () {},
                                child: const Text(
                                  'Forgot password?',
                                  style: AppTypography.caption,
                                ),
                              ),
                            ),
                            if (_serverError != null) ...[
                              Text(_serverError!, style: AppTypography.error),
                              const SizedBox(height: AppSpacing.sm),
                            ],
                            GlassButton(
                              key: const Key('sign-in-button'),
                              label: 'Sign in',
                              variant: GlassButtonVariant.primary,
                              expand: true,
                              loading: _submitting,
                              onPressed: _submit,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Create account',
                                style: AppTypography.label,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

String? _emailMessage(String email) {
  if (email.isEmpty || !_emailPattern.hasMatch(email)) {
    return 'Enter a valid email address';
  }
  return null;
}

final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

InputDecoration _fieldDecoration({
  required String label,
  String? error,
  Widget? suffix,
}) {
  return InputDecoration(
    labelText: label,
    errorText: error,
    suffixIcon: suffix,
    labelStyle: AppTypography.caption,
    errorStyle: AppTypography.error,
    filled: true,
    fillColor: AppColors.glassFill,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadii.tile),
      borderSide: const BorderSide(color: AppColors.glassBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadii.tile),
      borderSide: const BorderSide(color: AppColors.onAccent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadii.tile),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadii.tile),
      borderSide: const BorderSide(color: AppColors.error),
    ),
  );
}
