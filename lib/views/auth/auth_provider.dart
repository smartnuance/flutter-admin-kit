import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:admin/views/auth/auth.dart';
import 'package:admin/views/crud/api_provider.dart';
import 'package:admin/views/messages/message_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

const roleHeader = 'Role';

final loadedUser = FutureProvider<User>((ref) async {
  return await loadUser() ?? User.anonymous();
});

/// Provides sign in and sign out functionality.
///
/// This provider's value is wrapped with an AsyncValue to allow differentiation
/// between valid user, loading and error states.
final userProvider = StateNotifierProvider<Auth, AsyncValue<User>>(
  (ref) {
    final user = ref.watch(loadedUser).when(
          data: (user) => AsyncValue<User>.data(user),
          loading: () => const AsyncValue<User>.loading(),
          error: (error, stackTrace) =>
              AsyncValue<User>.error(error, stackTrace),
        );
    return Auth(ref, user);
  },
);

/// Provides the current temporary role. Might deviate from the default role returned with tokens.
final currentRoleProvider = Provider<String>(
  (ref) {
    return ref.watch(userProvider
        .select((user) => user.asData?.value.orNull?.currentRole ?? noRole));
  },
);

final tokensProvider = Provider<TokenPair?>(
  (ref) {
    return ref.watch(
        userProvider.select((user) => user.asData?.value.orNull?.tokens));
  },
);

class Auth extends StateNotifier<AsyncValue<User>> {
  Auth(this.ref, AsyncValue<User> user) : super(user);

  final StateNotifierProviderRef<Auth, AsyncValue<User>> ref;

  Future<void> signInWithCredential(
      {required String username, required String password}) async {
    state = await state.when(
      data: (user) async {
        if (!user.isAnonymous) {
          final msg = 'Another user $user is still logged in.'.i18n;
          ref.read(messagesProvider.notifier).error(
                text: msg,
                error: msg,
              );
          return state;
        }
        final updated = await AsyncValue.guard<User>(() async {
          final tokens =
              await ref.read(authServiceProvider).signIn(username, password);
          return User(
              email: username, tokens: tokens, currentRole: tokens.role);
        });
        updated.when(
          data: (user) {
            storeUser(user);
            ref
                .read(messagesProvider.notifier)
                .info(text: 'Successfully logged in as $user');
          },
          loading: () => {},
          error: (error, stackTrace) {
            ref.read(messagesProvider.notifier).error(
                  text: 'Error logging in $username',
                  error: error,
                  stackTrace: stackTrace,
                );
          },
        );
        return updated;
      },
      loading: () {
        return state;
      },
      error: (error, stackTrace) {
        ref.read(messagesProvider.notifier).error(
              text:
                  'Cannot login as long as error present: ${error.toString()}',
              error: error,
              stackTrace: stackTrace,
            );
        return AsyncValue<User>.error(error, stackTrace);
      },
    );
  }

  Future<void> refreshToken() async {
    state.when(
      data: (user) async {
        await user.mapOrNull((user) async {
          if (user.tokens == null) {
            state = AsyncValue.error(
                StateError('refresh failed since user has no tokens yet'),
                StackTrace.current);
            return;
          }
          // do NOT set the state to loading here to avoid showing loading indicators wherever the user provider is user
          final newTokens =
              await ref.read(authServiceProvider).refreshTokens(user.tokens!);
          state = AsyncValue.data(user.copyWith(tokens: newTokens));
        });
      },
      loading: () => {},
      error: (error, stackTrace) => ref.read(messagesProvider.notifier).error(
            text: error.toString(),
            error: error,
            stackTrace: stackTrace,
          ),
    );
  }

  Future<void> switchRole(String? role) async {
    state.maybeWhen(
      data: (user) async {
        await user.mapOrNull((user) async {
          final updatedUser = user.copyWith(currentRole: role ?? noRole);
          state = AsyncValue.data(updatedUser);
          await storeUser(updatedUser);
        });
      },
      orElse: () => {},
    );
  }

  Future<void> signOut() async {
    final user = User.anonymous();
    state = AsyncValue.data(user);
    await clearStoredUser();
  }

  Future<bool> signUp({required String email, required String password}) async {
    var name = email;
    final i = name.lastIndexOf('@');
    if (i != -1) {
      name = name.substring(0, i);
    }
    try {
      await ref.read(authServiceProvider).signUp(name, email, password);
    } catch (error, stackTrace) {
      ref.read(messagesProvider.notifier).error(
            text: 'Error registering user in'.i18n,
            error: error,
            stackTrace: stackTrace,
          );
      return false;
    }
    return true;
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    // TODO
  }
}

class AuthInterceptor implements InterceptorContract {
  AuthInterceptor(this.ref);

  final StateProviderRef<Client> ref;

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    final tokens = ref.read(tokensProvider);
    final role = ref.read(currentRoleProvider);
    if (tokens?.access == null) {
      final error = StateError(
          'Attempt to access the access token to intercept and authenticate a request but no access token is available.');
      ref
          .read(messagesProvider.notifier)
          .error(text: error.toString(), error: error);
      return data;
    }
    developer.log('intercepted and added token ${tokens.toString()}');
    data.headers[HttpHeaders.authorizationHeader] = 'Bearer ${tokens?.access}';
    // Set the header even if role == '', which denotes no role at all
    data.headers[roleHeader] = role;
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  ExpiredTokenRetryPolicy(this.ref);

  final StateProviderRef<Client> ref;

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == HttpStatus.unauthorized) {
      developer.log('401 -> refresh token');
      try {
        final auth = ref.read(userProvider.notifier);
        await auth.refreshToken();
        return true;
      } catch (e) {
        ref.read(messagesProvider.notifier).error(
            text: 'Refreshing tokens failed after receiving 401.', error: e);
      }
    }
    return false;
  }
}

Future<User?> loadUser() async {
  final prefs = await SharedPreferences.getInstance();
  final userEnc = prefs.getString('user');
  if (userEnc == null) {
    return null;
  }
  final user = User.fromMap(json.decode(userEnc) as Map<String, dynamic>);
  developer.log('loaded user $user');
  return user;
}

Future<void> storeUser(User user) async {
  final prefs = await SharedPreferences.getInstance();
  final encoded = json.encode(user.toMap());
  await prefs.setString('user', encoded);
  developer.log('store user $user');
}

Future<void> clearStoredUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
}
