import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/auth/sign_in/sign_in_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInFormProvider =
    StateNotifierProvider.autoDispose<SignInFormState, SignInForm>((ref) {
  final auth = ref.watch(userProvider.notifier);
  return SignInFormState(SignInForm.login(), auth: auth);
});

class SignInFormState extends StateNotifier<SignInForm> {
  SignInFormState(SignInForm state, {required this.auth}) : super(state);

  final Auth auth;

  @override
  set state(SignInForm value) {
    super.state = value;
  }

  void switchToLogin() {
    state = SignInForm.login(
        emailOrUsername: state.emailOrUsername, submitted: state.submitted);
  }

  void switchToRegister() {
    state = SignInForm.register(
        emailOrUsername: state.emailOrUsername, submitted: state.submitted);
  }

  void switchToPasswordReset() {
    state = SignInForm.passwordReset(
        emailOrUsername: state.emailOrUsername, submitted: state.submitted);
  }

  Future<bool> submit() async {
    state = state.copyWith(submitted: true);
    if (!state.canSubmit) {
      return false;
    }
    state = state.copyWith(isLoading: true);
    await state.when(
      login: (email, password, isLoading, submitted) =>
          auth.signInWithCredential(username: email, password: password),
      register: (email, password, isLoading, submitted) async {
        return auth.signUp(email: email, password: password);
      },
      passwordReset: (email, password, isLoading, submitted) =>
          auth.sendPasswordResetEmail(email: email),
    );
    state = state.copyWith(isLoading: false);
    return auth.state.map(
      data: (value) => true,
      loading: (value) => false,
      error: (value) => false,
    );
  }
}
