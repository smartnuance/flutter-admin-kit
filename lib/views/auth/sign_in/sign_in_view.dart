import 'dart:math';

import 'package:admin/common_widgets/error_actions.dart';
import 'package:admin/common_widgets/progress_status.dart';
import 'package:admin/constants.dart';
import 'package:admin/dialogs/show_alert_dialog.dart';
import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/auth/profile_button.dart';
import 'package:admin/views/auth/sign_in/buttons.dart';
import 'package:admin/views/auth/sign_in/sign_in_model.dart';
import 'package:admin/views/auth/sign_in/sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/default.i18n.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({
    Key? key,
    this.onSignedIn,
  }) : super(key: key);

  final VoidCallback? onSignedIn;

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final FocusScopeNode _node = FocusScopeNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInForm get state => ref.watch(signInFormProvider);
  SignInFormState get notifier => ref.watch(signInFormProvider.notifier);

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          user.when(
            data: (user) => user.isAnonymous
                ? Text('Please sign in:'.i18n)
                : Flexible(
                    flex: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('You are already signed in as:'),
                        SizedBox(width: defaultPadding),
                        ProfileButton(),
                      ],
                    ),
                  ),
            loading: () => const ProgressStatus(
              message: 'Loading user info',
            ),
            error: (error, _) => ErrorActions(error),
          ),
          const SizedBox(height: defaultPadding),
          Flexible(
            flex: 0,
            child: Center(
              child: LayoutBuilder(builder: (context, constraints) {
                return Container(
                  width: min(constraints.maxWidth, 600),
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildContent(),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final bool success = await notifier.submit();
    if (success) {
      await state.maybeMap(
        register: (value) async {
          await showAlertDialog(
            context: context,
            title: 'Registered'.i18n,
            content: 'The user is registered. You can now log in.'.i18n,
            defaultActionText: 'OK'.i18n,
          );
          notifier.switchToLogin();
        },
        passwordReset: (value) async {
          await showAlertDialog(
            context: context,
            title: 'Reset link sent'.i18n,
            content:
                'If the email entered is assigned to an account you will receive an email to reset your password'
                    .i18n,
            defaultActionText: 'OK'.i18n,
          );
        },
        orElse: () {
          widget.onSignedIn?.call();
        },
      );
    } else {
      final desiresPasswordReset = await showAlertDialog(
          context: context,
          title: state.map(
            login: (value) => 'Login failed'.i18n,
            register: (value) => 'Registration failed'.i18n,
            passwordReset: (value) => 'Password reset failed'.i18n,
          ),
          content: state.map(
            login: (value) => 'Did you forget your password?'.i18n,
            register: (value) =>
                'Please contact us that we can help you with the registration.'
                    .i18n,
            passwordReset: (value) =>
                'Please contact us that we can help recovering your account.'
                    .i18n,
          ),
          defaultActionText: 'Reset password'.i18n,
          cancelActionText: 'Go back'.i18n);
      if (desiresPasswordReset ?? false) {
        notifier.switchToPasswordReset();
      }
    }
    _passwordController.clear();
  }

  Widget _buildContent() {
    return FocusScope(
      node: _node,
      child: Form(
        onChanged: () => notifier.state = state.copyWith(
            emailOrUsername: _emailController.text,
            password: _passwordController.text),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 8.0),
            _buildEmailField(),
            ...state.maybeMap(
              passwordReset: (_) => [],
              orElse: () => [
                const SizedBox(height: 8.0),
                _buildPasswordField(),
              ],
            ),
            const SizedBox(height: 8.0),
            state.when(
              login: (email, password, isLoading, submitted) => SignInButton(
                key: const Key('primary-button'),
                text: 'Log in'.i18n,
                loading: isLoading,
                onPressed: isLoading ? null : _submit,
              ),
              register: (email, password, isLoading, submitted) => SignInButton(
                key: const Key('primary-button'),
                text: 'Create an account'.i18n,
                loading: isLoading,
                onPressed: isLoading ? null : _submit,
              ),
              passwordReset: (email, password, isLoading, submitted) =>
                  SignInButton(
                key: const Key('primary-button'),
                text: 'Send Reset Link'.i18n,
                loading: isLoading,
                onPressed: isLoading ? null : _submit,
              ),
            ),
            const SizedBox(height: 8.0),
            ...state.map(
              login: (value) => [
                TextButton(
                  key: const Key('secondary-button'),
                  child: Text('Need an account? Register'.i18n),
                  onPressed: state.isLoading
                      ? null
                      : () => notifier.switchToRegister(),
                ),
                TextButton(
                  key: const Key('tertiary-button'),
                  child: Text('Forgot your password? Reset it'.i18n),
                  onPressed: state.isLoading
                      ? null
                      : () => notifier.switchToPasswordReset(),
                ),
              ],
              register: (value) => [
                TextButton(
                  key: const Key('secondary-button'),
                  child: Text('Back to login'.i18n),
                  onPressed:
                      state.isLoading ? null : () => notifier.switchToLogin(),
                )
              ],
              passwordReset: (value) => [
                TextButton(
                  key: const Key('secondary-button'),
                  child: Text('Back to login'.i18n),
                  onPressed:
                      state.isLoading ? null : () => notifier.switchToLogin(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    final bool showErrorText = state.submitted && !state.canSubmitEmail;

    return TextFormField(
      key: const Key('email'),
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email'.i18n,
        hintText: 'test@test.com'.i18n,
        errorText: showErrorText
            ? (state.emailOrUsername.isEmpty
                ? 'Email can\'t be empty'.i18n
                : 'Email is invalid'.i18n)
            : null,
        enabled: !state.isLoading,
      ),
      autocorrect: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      keyboardAppearance: Brightness.light,
      onEditingComplete: () {
        if (state.canSubmitEmail) {
          _node.nextFocus();
        }
      },
      inputFormatters: <TextInputFormatter>[
        emailOrUsernameInputFormatter,
      ],
    );
  }

  Widget _buildPasswordField() {
    final bool showErrorText = state.submitted && !state.canSubmitPassword;
    return TextFormField(
      key: const Key('password'),
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: state.maybeMap(
            register: (value) => 'Password (8+ characters)'.i18n,
            orElse: () => 'Password'.i18n),
        errorText: showErrorText
            ? (state.password.isEmpty
                ? 'Password can\'t be empty'.i18n
                : 'Password is too short'.i18n)
            : null,
        enabled: !state.isLoading,
      ),
      obscureText: true,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      keyboardAppearance: Brightness.light,
      onEditingComplete: () {
        if (!state.canSubmitEmail) {
          _node.previousFocus();
          return;
        }
        _submit();
      },
    );
  }
}
