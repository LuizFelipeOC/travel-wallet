import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extends/extends.dart';
import '../../../core/widgtes/custom_buttons/cusom_button.dart';
import '../../../core/widgtes/fade_in/fade_in.dart';
import '../../../routers/app_routes.dart';
import '../state/auth_validator.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';

class RecoveryPasswordScreen extends StatefulWidget {
  const RecoveryPasswordScreen({super.key});

  @override
  State<RecoveryPasswordScreen> createState() => _RecoveryPasswordScreenState();
}

class _RecoveryPasswordScreenState extends State<RecoveryPasswordScreen> with AuthValidator {
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  bool _isEmailVerified = false;
  bool _obscurePassword = true;
  bool _obscurePasswordConfirmation = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  void _onBack() {
    // On the second step the back button returns to the email step, so the
    // user can fix a typo without leaving the flow.
    if (_isEmailVerified) {
      setState(() {
        _isEmailVerified = false;
        _passwordController.clear();
        _passwordConfirmationController.clear();
      });

      return;
    }

    context.popOrGo(AppRoutes.signIn);
  }

  void _onVerifyEmail() {
    FocusScope.of(context).unfocus();

    if (_emailFormKey.currentState?.validate() ?? false) {
      setState(() => _isEmailVerified = true);
    }
  }

  void _onResetPassword() {
    FocusScope.of(context).unfocus();

    if (!(_passwordFormKey.currentState?.validate() ?? false)) {
      return;
    }

    final localizations = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(localizations.auth_recovery_success)));

    context.popOrGo(AppRoutes.signIn);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return PopScope(
      // Intercepts the system back gesture so it mirrors the header button.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _onBack();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthHeader(
                  onBack: _onBack,
                  title: localizations.auth_recovery_title,
                  subtitle: _isEmailVerified
                      ? localizations.auth_recovery_subtitle_password
                      : localizations.auth_recovery_subtitle,
                ),
                const SizedBox(height: 32),
                FadeIn(
                  delay: const Duration(milliseconds: 250),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: _isEmailVerified
                          ? _buildPasswordStep(localizations)
                          : _buildEmailStep(localizations),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailStep(AppLocalizations localizations) {
    return Form(
      key: _emailFormKey,
      child: Column(
        key: const ValueKey('email-step'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            controller: _emailController,
            label: localizations.auth_field_email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.email],
            onFieldSubmitted: (_) => _onVerifyEmail(),
            validator: (value) => requiredEmail(value, localizations.auth_field_email),
          ),
          const SizedBox(height: 28),
          CustomButton(
            title: localizations.auth_recovery_verify_action,
            onPressed: _onVerifyEmail,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => context.popOrGo(AppRoutes.signIn),
            child: Text(localizations.auth_back_to_sign_in),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordStep(AppLocalizations localizations) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _passwordFormKey,
      child: Column(
        key: const ValueKey('password-step'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              localizations.auth_recovery_account(_emailController.text.trim()),
              style: textTheme.bodyMedium,
            ),
          ),
          AuthTextField(
            controller: _passwordController,
            label: localizations.auth_field_new_password,
            autofillHints: const [AutofillHints.newPassword],
            obscureText: _obscurePassword,
            onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
            validator: (value) => requiredPassword(value, localizations.auth_field_new_password),
          ),
          const SizedBox(height: 20),
          AuthTextField(
            controller: _passwordConfirmationController,
            label: localizations.auth_field_password_confirmation,
            textInputAction: TextInputAction.done,
            obscureText: _obscurePasswordConfirmation,
            onToggleObscure: () =>
                setState(() => _obscurePasswordConfirmation = !_obscurePasswordConfirmation),
            onFieldSubmitted: (_) => _onResetPassword(),
            validator: (value) => requiredPasswordConfirmation(
              value,
              _passwordController.text,
              localizations.auth_field_password_confirmation,
            ),
          ),
          const SizedBox(height: 28),
          CustomButton(
            title: localizations.auth_recovery_reset_action,
            onPressed: _onResetPassword,
          ),
        ],
      ),
    );
  }
}
