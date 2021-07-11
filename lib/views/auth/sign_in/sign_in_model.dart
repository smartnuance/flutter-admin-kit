import 'package:admin/utils/string_validators.dart';
import 'package:admin/views/auth/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:i18n_extension/default.i18n.dart';

enum SignInFormType { signIn, register, forgotPassword }

class EmailAndPasswordValidators {
  final TextInputFormatter emailInputFormatter =
      ValidatorInputFormatter(editingValidator: EmailEditingRegexValidator());
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);
  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();
}

class SignInModel with EmailAndPasswordValidators, ChangeNotifier {
  SignInModel({
    required this.auth,
    this.email = '',
    this.password = '',
    this.formType = SignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });
  final Auth auth;

  String email;
  String password;
  SignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<bool> submit() async {
    try {
      updateWith(submitted: true);
      if (!canSubmit) {
        return false;
      }
      updateWith(isLoading: true);
      switch (formType) {
        case SignInFormType.signIn:
          await auth.signInWithCredential(username: email, password: password);
          break;
        case SignInFormType.register:
          await auth.createUserWithEmailAndPassword(
              email: email, password: password);
          break;
        case SignInFormType.forgotPassword:
          await auth.sendPasswordResetEmail(email: email);
          updateWith(isLoading: false);
          break;
      }
      return true;
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateFormType(SignInFormType formType) {
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateWith({
    String? email,
    String? password,
    SignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }

  String get passwordLabelText {
    if (formType == SignInFormType.register) {
      return 'Password (8+ characters)'.i18n;
    }
    return 'Password'.i18n;
  }

  // Getters
  String get primaryButtonText {
    return <SignInFormType, String>{
      SignInFormType.register: 'Create an account'.i18n,
      SignInFormType.signIn: 'Sign in'.i18n,
      SignInFormType.forgotPassword: 'Send Reset Link'.i18n,
    }[formType]!;
  }

  String get secondaryButtonText {
    return <SignInFormType, String>{
      SignInFormType.register: 'Have an account? Sign in'.i18n,
      SignInFormType.signIn: 'Need an account? Register'.i18n,
      SignInFormType.forgotPassword: 'Back to sign in'.i18n,
    }[formType]!;
  }

  SignInFormType get secondaryActionFormType {
    return <SignInFormType, SignInFormType>{
      SignInFormType.register: SignInFormType.signIn,
      SignInFormType.signIn: SignInFormType.register,
      SignInFormType.forgotPassword: SignInFormType.signIn,
    }[formType]!;
  }

  String get errorAlertTitle {
    return <SignInFormType, String>{
      SignInFormType.register: 'Registration failed'.i18n,
      SignInFormType.signIn: 'Sign in failed'.i18n,
      SignInFormType.forgotPassword: 'Password reset failed'.i18n,
    }[formType]!;
  }

  String get title {
    return <SignInFormType, String>{
      SignInFormType.register: 'Register'.i18n,
      SignInFormType.signIn: 'Sign in'.i18n,
      SignInFormType.forgotPassword: 'Forgot password'.i18n,
    }[formType]!;
  }

  bool get canSubmitEmail {
    // TODO when changing to email sign in reactivate this
    // return emailSubmitValidator.isValid(email);
    return true;
  }

  bool get canSubmitPassword {
    if (formType == SignInFormType.register) {
      return passwordRegisterSubmitValidator.isValid(password);
    }
    return passwordSignInSubmitValidator.isValid(password);
  }

  bool get canSubmit {
    final bool canSubmitFields = formType == SignInFormType.forgotPassword
        ? canSubmitEmail
        : canSubmitEmail && canSubmitPassword;
    return canSubmitFields && !isLoading;
  }

  String? get emailErrorText {
    final bool showErrorText = submitted && !canSubmitEmail;
    final String errorText =
        email.isEmpty ? 'Email can\'t be empty'.i18n : 'Email is invalid'.i18n;
    return showErrorText ? errorText : null;
  }

  String? get passwordErrorText {
    final bool showErrorText = submitted && !canSubmitPassword;
    final String errorText = password.isEmpty
        ? 'Password can\'t be empty'.i18n
        : 'Password is too short'.i18n;
    return showErrorText ? errorText : null;
  }

  @override
  String toString() {
    return 'email: $email, password: $password, formType: $formType, isLoading: $isLoading, submitted: $submitted';
  }
}
