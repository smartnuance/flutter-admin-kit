import 'package:admin/utils/string_validators.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_model.freezed.dart';

final TextInputFormatter emailOrUsernameInputFormatter =
    ValidatorInputFormatter(
        editingValidator: RegexValidator(regexSource: '^(|\\S)+\$'));
final StringValidator emailSubmitValidator =
    RegexValidator(regexSource: '^\\S+@\\S+\\.\\S+\$');
final StringValidator usernameSubmitValidator =
    RegexValidator(regexSource: '^\\S+\$');
final StringValidator passwordRegisterSubmitValidator =
    MinLengthStringValidator(8);
final StringValidator passwordSignInSubmitValidator = NonEmptyStringValidator();

@freezed
class SignInForm with _$SignInForm {
  factory SignInForm.login({
    @Default('') String emailOrUsername,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(false) bool submitted,
  }) = LoginForm;

  factory SignInForm.register({
    @Default('') String emailOrUsername,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(false) bool submitted,
  }) = RegisterForm;

  factory SignInForm.passwordReset({
    @Default('') String emailOrUsername,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(false) bool submitted,
  }) = PasswordResetForm;

  SignInForm._();

  bool get canSubmitEmail {
    return emailSubmitValidator.isValid(emailOrUsername) ||
        usernameSubmitValidator.isValid(emailOrUsername);
  }

  bool get canSubmitPassword {
    return maybeMap(
      register: (value) => passwordRegisterSubmitValidator.isValid(password),
      orElse: () => passwordSignInSubmitValidator.isValid(password),
    );
  }

  bool get canSubmit {
    final bool canSubmitFields = maybeMap(
      passwordReset: (value) => canSubmitEmail,
      orElse: () => canSubmitEmail && canSubmitPassword,
    );

    return canSubmitFields && !isLoading;
  }
}
