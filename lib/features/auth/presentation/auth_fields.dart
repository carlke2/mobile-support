import 'package:flutter/material.dart';

import '../../../core/theme/app_tokens.dart';

String? emailMessage(String email) {
  if (email.isEmpty || !_emailPattern.hasMatch(email)) {
    return 'Enter a valid email address';
  }
  return null;
}

/// Same Kenyan mobile shapes the API accepts: 2547…, 07…, or 7….
String? phoneMessage(String phone) {
  final trimmed = phone.trim();
  if (trimmed.isEmpty) {
    return 'Phone is required';
  }
  if (_normalizeKenyanMobile(trimmed) == null) {
    return 'Enter a valid phone number';
  }
  return null;
}

String? passwordMessage(String password, {int minimum = 8}) {
  if (password.isEmpty) {
    return 'Password is required';
  }
  if (password.length < minimum) {
    return 'Password must be at least 8 characters';
  }
  return null;
}

String? _normalizeKenyanMobile(String raw) {
  final value = raw.trim().replaceAll(RegExp(r'\s+'), '').replaceFirst('+', '');
  if (value.isEmpty) {
    return null;
  }
  if (RegExp(r'^254\d{9,12}$').hasMatch(value)) {
    return value;
  }
  if (RegExp(r'^0\d{9}$').hasMatch(value)) {
    return '254${value.substring(1)}';
  }
  if (RegExp(r'^7\d{8}$').hasMatch(value)) {
    return '254$value';
  }
  final digits = value.replaceAll(RegExp(r'\D'), '');
  if (RegExp(r'^254\d{9,12}$').hasMatch(digits)) {
    return digits;
  }
  if (RegExp(r'^0\d{9}$').hasMatch(digits)) {
    return '254${digits.substring(1)}';
  }
  return null;
}

final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

InputDecoration authFieldDecoration({
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
