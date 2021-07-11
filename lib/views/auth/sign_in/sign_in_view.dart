import 'dart:math';

import 'package:admin/common_widgets/error_actions.dart';
import 'package:admin/common_widgets/progress_status.dart';
import 'package:admin/constants.dart';
import 'package:admin/dialogs/show_alert_dialog.dart';
import 'package:admin/dialogs/show_exception_alert_dialog.dart';
import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/auth/profile_button.dart';
import 'package:admin/views/auth/sign_in/buttons.dart';
import 'package:admin/views/auth/sign_in/sign_in_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/default.i18n.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({Key? key, required this.model, this.onSignedIn})
      : super(key: key);
  final SignInModel model;
  final VoidCallback? onSignedIn;

  factory SignInView.withAuth(Auth auth, {VoidCallback? onSignedIn}) {
    return SignInView(
      model: SignInModel(auth: auth),
      onSignedIn: onSignedIn,
    );
  }

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final FocusScopeNode _node = FocusScopeNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInModel get model => widget.model;

  @override
  void initState() {
    super.initState();
    // Temporary workaround to update state until a replacement for ChangeNotifierProvider is found
    model.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    model.dispose();
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSignInError(SignInModel model, dynamic exception) {
    showExceptionAlertDialog(
      context: context,
      title: model.errorAlertTitle,
      exception: exception,
    );
  }

  Future<void> _submit() async {
    try {
      final bool success = await model.submit();
      if (success) {
        if (model.formType == SignInFormType.forgotPassword) {
          await showAlertDialog(
            context: context,
            title: 'Reset link sent'.i18n,
            content: 'Check your email to reset your password'.i18n,
            defaultActionText: 'OK'.i18n,
          );
        } else {
          if (widget.onSignedIn != null) {
            widget.onSignedIn?.call();
          }
        }
      }
    } catch (e) {
      _showSignInError(model, e);
    }
  }

  void _emailEditingComplete() {
    if (model.canSubmitEmail) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!model.canSubmitEmail) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  void _updateFormType(SignInFormType formType) {
    model.updateFormType(formType);
    _emailController.clear();
    _passwordController.clear();
  }

  Widget _buildEmailField() {
    return TextFormField(
      key: const Key('email'),
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email'.i18n,
        hintText: 'test@test.com'.i18n,
        errorText: model.emailErrorText,
        enabled: !model.isLoading,
      ),
      autocorrect: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      keyboardAppearance: Brightness.light,
      onEditingComplete: _emailEditingComplete,
      inputFormatters: <TextInputFormatter>[
        model.emailInputFormatter,
      ],
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      key: const Key('password'),
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: model.passwordLabelText,
        errorText: model.passwordErrorText,
        enabled: !model.isLoading,
      ),
      obscureText: true,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      keyboardAppearance: Brightness.light,
      onEditingComplete: _passwordEditingComplete,
    );
  }

  Widget _buildContent() {
    return FocusScope(
      node: _node,
      child: Form(
        onChanged: () => model.updateWith(
            email: _emailController.text, password: _passwordController.text),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 8.0),
            _buildEmailField(),
            if (model.formType != SignInFormType.forgotPassword) ...<Widget>[
              const SizedBox(height: 8.0),
              _buildPasswordField(),
            ],
            const SizedBox(height: 8.0),
            SignInButton(
              key: const Key('primary-button'),
              text: model.primaryButtonText,
              loading: model.isLoading,
              onPressed: model.isLoading ? null : _submit,
            ),
            const SizedBox(height: 8.0),
            TextButton(
              key: const Key('secondary-button'),
              child: Text(model.secondaryButtonText),
              onPressed: model.isLoading
                  ? null
                  : () => _updateFormType(model.secondaryActionFormType),
            ),
            if (model.formType == SignInFormType.signIn)
              TextButton(
                key: const Key('tertiary-button'),
                child: Text('Forgot password?'.i18n),
                onPressed: model.isLoading
                    ? null
                    : () => _updateFormType(SignInFormType.forgotPassword),
              ),
          ],
        ),
      ),
    );
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
                      children: [
                        const Text('You are already signed in as:'),
                        const SizedBox(width: defaultPadding),
                        ProfileButton(),
                      ],
                    ),
                  ),
            loading: () => const ProgressStatus(
              message: 'Loading user info',
            ),
            error: (error, stackTrace) => ErrorActions(error),
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
}
