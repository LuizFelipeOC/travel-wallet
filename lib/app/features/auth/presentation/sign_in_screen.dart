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

class SignInScreen extends StatefulWidget {
  /// Set when the screen lives inside the home pager: it has no route to pop
  /// back to, so the back button and the "continue without an account" escape
  /// are dropped in favour of swiping to another page.
  final bool isEmbedded;
  final double bottomInset;

  const SignInScreen({super.key, this.isEmbedded = false, this.bottomInset = 0});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with AuthValidator {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: widget.isEmbedded ? Colors.transparent : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24, 0, 24, widget.isEmbedded ? widget.bottomInset : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthHeader(
                onBack: widget.isEmbedded ? null : () => context.popOrGo(AppRoutes.home),
                title: localizations.auth_sign_in_title,
                subtitle: localizations.auth_sign_in_subtitle,
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
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.password],
                        obscureText: _obscurePassword,
                        onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
                        onFieldSubmitted: (_) => _onSignIn(),
                        validator: (value) =>
                            requiredPassword(value, localizations.auth_field_password),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.push(AppRoutes.recoveryPassword),
                          child: Text(localizations.auth_forgot_password),
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomButton(title: localizations.auth_sign_in_action, onPressed: _onSignIn),
                      const SizedBox(height: 24),
                      AuthDivider(label: localizations.auth_divider),
                      const SizedBox(height: 24),
                      GoogleSignInButton(title: localizations.auth_google_action, onPressed: () {}),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => context.push(AppRoutes.signUp),
                        child: Text(localizations.auth_no_account),
                      ),
                      if (!widget.isEmbedded)
                        TextButton(
                          onPressed: () => context.popOrGo(AppRoutes.home),
                          child: Text(localizations.auth_continue_without_account),
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
