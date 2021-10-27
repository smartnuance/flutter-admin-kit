import 'package:admin/utils/string_manipulation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

const noRole = '';

@freezed
class User with _$User {
  factory User({
    required String username,
    String? displayName,
    TokenPair? tokens,
    @Default(noRole) String currentRole,
  }) = _User;

  factory User.anonymous({
    @Default('') String username,
    @Default('') String? displayName,
    @Default(null) TokenPair? tokens,
    @Default(noRole) String currentRole,
  }) = _AnonymousUser;

  User._();

  late final isAnonymous = username == '';

  factory User.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for User');
    }

    final username = data['username'] as String?;
    if (username == '') {
      return User.anonymous(username: '');
    }

    final tokens = data['tokens'] as Map<String, dynamic>?;
    final TokenPair? tokenPair =
        tokens != null ? TokenPair.fromMap(tokens) : null;

    return User(
      username: username!,
      displayName: data['displayName'] as String?,
      tokens: tokenPair,
      currentRole: data['currentRole'] as String? ?? noRole,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'displayName': displayName,
      'tokens': tokens?.toMap(),
      'currentRole': currentRole,
    };
  }
}

@freezed
class TokenPair with _$TokenPair {
  factory TokenPair({
    required String refresh,
    required String access,
    @Default(noRole) String role,
    @Default(<String>[]) List<String> switchRoles,
  }) = _TokenPair;

  const TokenPair._();

  @override
  String toString() {
    return '$role with (Access: ...${tail(access, 5)}, Refresh: ...${tail(refresh, 5)})';
  }

  factory TokenPair.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for TokenPair');
    }

    final refreshToken = data['refreshToken'] as String?;
    if (refreshToken == null) {
      throw Exception(
          'Did not found refresh token in response to successful login call');
    }
    final accessToken = data['accessToken'] as String?;
    if (accessToken == null) {
      throw Exception(
          'Did not found access token in response to successful login call');
    }

    return TokenPair(
      refresh: refreshToken,
      access: accessToken,
      role: data['role'] as String? ?? noRole,
      switchRoles: List<String>.from(data['switchRoles'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': access,
      'refreshToken': refresh,
      'role': role,
      'switchRoles': switchRoles,
    };
  }
}
