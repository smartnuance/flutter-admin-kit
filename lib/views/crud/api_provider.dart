import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/auth/auth_service.dart';
import 'package:admin/views/crud/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

final _tokenHttpClientProvider = StateProvider<http.Client>((ref) {
  final client = InterceptedClient.build(
    interceptors: [
      AuthInterceptor(ref),
    ],
    retryPolicy: ExpiredTokenRetryPolicy(ref),
  );
  ref.onDispose(() {
    client.close();
  });
  return client;
});

final _unauthHttpClientProvider = StateProvider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(() {
    client.close();
  });
  return client;
});

final apiServiceProvider = Provider.autoDispose<APIService>((ref) {
  // final auth = ref.watch(authStateChangesProvider);
  final client = ref.watch(_tokenHttpClientProvider).state;

  return APIService(client);
});

final authServiceProvider = Provider<AuthService>((ref) {
  // final auth = ref.watch(authStateChangesProvider);
  final unauthClient = ref.watch(_unauthHttpClientProvider).state;

  return AuthService(unauthClient);
});
