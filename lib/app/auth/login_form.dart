import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/auth/filled_loading_button.dart";
import "package:portal/app/auth/login_result.dart";
import "package:portal/app/auth/user_controller.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/app/validation/form_validation.dart";
import "package:provider/provider.dart";

class LoginForm extends StatefulWidget {
  static const Key emailFieldKey = Key("loginform.email");

  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordObscured = true;

  late UserController _userController;

  Future<void> onLoginClick() async {
    if (_autoValidateMode == AutovalidateMode.disabled) {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });
    }
    if (!_formKey.currentState!.validate()) return;

    final result = await context.read<UserController>().login(
          _emailController.text,
          _passwordController.text,
        );
    if (!mounted) return;

    final t = AppLocalizations.of(context)!;
    switch (result) {
      case LoginResult.success:
        // Redirect is handled in app.dart
        break;
      case LoginResult.invalidCredentials:
        _showErrorSnackBar(t.errorCheckCredentials);
        break;
      case LoginResult.error:
        _showErrorSnackBar(t.errorSomethingWentWrongTryAgain);
        break;
      case LoginResult.aborted:
        // Do nothing
        break;
    }
  }

  void _showErrorSnackBar(String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: theme.colorScheme.onError),
        ),
        backgroundColor: theme.colorScheme.error,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final emailValidator = FormValidator(
      validators: [
        FormValidation.fieldHasInputValidator(t.errorFieldRequired),
        FormValidation.fieldIsValidEmail(t.errorInvalidEmail),
      ],
    );
    final passwordValidator = FormValidator(
      validators: [FormValidation.fieldHasInputValidator(t.errorFieldRequired)],
    );

    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            key: LoginForm.emailFieldKey,
            controller: _emailController,
            autofillHints: const [AutofillHints.email],
            textInputAction: TextInputAction.next,
            enableSuggestions: true,
            validator: emailValidator.validate,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(t.email),
            ),
          ),
          const SizedBox(height: Paddings.large),
          TextFormField(
            controller: _passwordController,
            autofillHints: const [AutofillHints.password],
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => unawaited(onLoginClick()),
            obscureText: _passwordObscured,
            validator: passwordValidator.validate,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(t.password),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordObscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  semanticLabel: _passwordObscured ? t.show : t.hide,
                ),
                onPressed: () {
                  setState(() {
                    _passwordObscured = !_passwordObscured;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: Paddings.large),
          Builder(
            builder: (context) {
              _userController = context.watch<UserController>();
              return FilledLoadingButton(
                onPressed: onLoginClick,
                isLoading:
                    _userController.isLoggedIn || _userController.isLoggingIn,
                child: Text(t.logIn),
              );
            },
          ),
        ],
      ),
    );
  }
}
