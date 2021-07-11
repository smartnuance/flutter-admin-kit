import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:admin/views/auth/auth.dart';
import 'package:admin/views/crud/api_provider.dart';
import 'package:admin/views/messages/message_model.dart';
import 'package:admin/views/messages/message_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

/// Provides sign in and sign out functionality.
///
/// This provider's value is wrapped with an AsyncValue to allow differentiation
/// between valid user, loading and error states.
final userProvider = StateNotifierProvider<Auth, AsyncValue<User>>(
  (ref) {
    return Auth(ref);
  },
);

class Auth extends StateNotifier<AsyncValue<User>> {
  Auth(this.ref) : super(AsyncValue.data(User.anonymous()));

  late final ProviderRefBase ref;

  Future<void> signInWithCredential(
      {required String username, required String password}) async {
    state = await state.when(
      data: (user) async {
        final updated = await AsyncValue.guard<User>(() async {
          final tokens =
              await ref.read(authServiceProvider).signIn(username, password);
          return User(username: username, tokens: tokens);
        });
        updated.when(
          data: (user) => ref.read(messagesProvider.notifier).publish(
              Message(text: 'Successfully logged in as ${user.username}')),
          loading: () => {},
          error: (error, stackTrace) {
            ref.read(messagesProvider.notifier).publish(Message(
                  text: 'Error logging in $username',
                  error: error,
                  stackTrace: stackTrace,
                ));
          },
        );
        return updated;
      },
      loading: () {
        return state;
      },
      error: (error, stackTrace) {
        ref.read(messagesProvider.notifier).publish(Message(
              text:
                  'Cannot login as long as error present: ${error.toString()}',
              error: error,
              stackTrace: stackTrace,
            ));
        return AsyncValue<User>.error(error);
      },
    );
  }

  Future<void> refreshToken() async {
    final currentTokens = state.data?.value.tokens;
    if (currentTokens == null) {
      state = AsyncValue.error(
          StateError('refresh failed since user has no tokens yet'));
      return;
    }
    // do NOT set the state to loading here to avoid showing loading indicators wherever the user provider is user
    final tokens =
        await ref.read(authServiceProvider).refreshTokens(currentTokens);

    state.when(
      data: (user) {
        state = AsyncValue.data(user.copyWith(tokens: tokens));
      },
      loading: () => {},
      error: (error, stackTrace) =>
          ref.read(messagesProvider.notifier).publish(Message(
                text: error.toString(),
                error: error,
                stackTrace: stackTrace,
              )),
    );
  }

  Future<void> signInAnonymously() async {
    state = AsyncValue.data(User.anonymous());
  }

  Future<void> signOut() async {
    state = AsyncValue.data(User.anonymous());
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {}

  Future<void> sendPasswordResetEmail({required String email}) async {}
}

class AuthInterceptor implements InterceptorContract {
  AuthInterceptor(this.ref);

  final ProviderRefBase ref;

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    final tokens = ref.read(userProvider).data?.value.tokens;
    if (tokens?.access == null) {
      final error = StateError(
          'Attempt to access the access token to intercept and authenticate a request but no access token is available.');
      ref
          .read(messagesProvider.notifier)
          .publish(Message(text: error.toString(), error: error));
      return data;
    }
    developer.log('intercepted and added token ${tokens.toString()}');
    data.headers[HttpHeaders.authorizationHeader] = 'Bearer ${tokens?.access}';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  ExpiredTokenRetryPolicy(this.ref);

  final ProviderRefBase ref;

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == HttpStatus.unauthorized) {
      developer.log('401 -> refresh token');
      try {
        final auth = ref.read(userProvider.notifier);
        await auth.refreshToken();
        return true;
      } catch (e) {
        developer.log(e.toString());
      }
    }
    return false;
  }
}
