import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extends/extends.dart';
import '../../../core/widgtes/custom_buttons/cusom_button.dart';
import '../../../core/widgtes/fade_in/fade_in.dart';
import '../../../routers/app_routes.dart';
import '../state/auth_validator.dart';
import '../widgets/auth_divider.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/google_sign_in_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with AuthValidator {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscurePasswordConfirmation = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthHeader(
                onBack: () => context.popOrGo(AppRoutes.signIn),
                title: localizations.auth_sign_up_title,
                subtitle: localizations.auth_sign_up_subtitle,
              ),
              const SizedBox(height: 32),
              FadeIn(
                delay: const Duration(milliseconds: 250),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthTextField(
                        controller: _nameController,
                        label: localizations.auth_field_name,
                        keyboardType: TextInputType.name,
                        autofillHints: const [AutofillHints.name],
                        validator: (value) => requiredText(value, localizations.auth_field_name),
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: _emailController,
                        label: localizations.auth_field_email,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        validator: (value) => requiredEmail(value, localizations.auth_field_email),
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: _passwordController,
                        label: localizations.auth_field_password,
                        autofillHints: const [AutofillHints.newPassword],
                        obscureText: _obscurePassword,
                        onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
                        validator: (value) =>
                            requiredPassword(value, localizations.auth_field_password),
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: _passwordConfirmationController,
                        label: localizations.auth_field_password_confirmation,
                        textInputAction: TextInputAction.done,
                        obscureText: _obscurePasswordConfirmation,
                        onToggleObscure: () => setState(
                          () => _obscurePasswordConfirmation = !_obscurePasswordConfirmation,
                        ),
                        onFieldSubmitted: (_) => _onSignUp(),
                        validator: (value) => requiredPasswordConfirmation(
                          value,
                          _passwordController.text,
                          localizations.auth_field_password_confirmation,
                        ),
                      ),
                      const SizedBox(height: 28),
                      CustomButton(title: localizations.auth_sign_up_action, onPressed: _onSignUp),
                      const SizedBox(height: 24),
                      AuthDivider(label: localizations.auth_divider),
                      const SizedBox(height: 24),
                      GoogleSignInButton(title: localizations.auth_google_action, onPressed: () {}),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => context.popOrGo(AppRoutes.signIn),
                        child: Text(localizations.auth_has_account),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
