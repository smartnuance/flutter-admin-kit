import 'dart:collection';

import 'package:admin/utils/string_manipulation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

const noRole = '';

@freezed
class User with _$User {
  factory User({
    required String email,
    String? name,
    TokenPair? tokens,
    @Default(noRole) String currentRole,
  }) = _User;

  factory User.anonymous() = _AnonymousUser;

  User._();

  _User? get orNull {
    return mapOrNull(
      (d) => d,
    );
  }

  late final bool isAnonymous = maybeMap((_) => false, orElse: () => true);

  late final List<String> switchRoles = whenOrNull<List<String>?>(
          (email, name, tokens, currentRole) => tokens?.switchRoles) ??
      [];

  late final List<String> currentInheritedRoles = whenOrNull<List<String>?>(
          (email, name, tokens, currentRole) =>
              tokens?.inheritedRoles(currentRole)) ??
      [];

  @override
  String toString() {
    return when(
      (email, name, tokens, currentRole) =>
          name != null ? '$name<$email>' : email,
      anonymous: () => '<anonymous>',
    );
  }

  factory User.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for User');
    }

    final email = data['email'] as String?;
    if (email == null || email == '') {
      return User.anonymous();
    }

    final tokens = data['tokens'] as Map<String, dynamic>?;
    final TokenPair? tokenPair =
        tokens != null ? TokenPair.fromMap(tokens) : null;

    return User(
      email: email,
      name: data['name'] as String?,
      tokens: tokenPair,
      currentRole: data['currentRole'] as String? ?? noRole,
    );
  }

  Map<String, dynamic> toMap() {
    return whenOrNull((email, name, tokens, currentRole) => {
              'email': email,
              'name': name,
              'tokens': tokens?.toMap(),
              'currentRole': currentRole,
            }) ??
        {};
  }
}

@freezed
class TokenPair with _$TokenPair {
  factory TokenPair({
    required String refresh,
    required String access,
    @Default(noRole) String role,
    @Default(<RolesSpecEntry>[]) List<RolesSpecEntry> rolesSpec,
  }) = _TokenPair;

  TokenPair._();

  late final Map<String, List<String>> _rolesSpecMap = HashMap.fromIterable(
      rolesSpec,
      key: (dynamic e) => (e as RolesSpecEntry).role,
      value: (dynamic e) => (e as RolesSpecEntry).inherited);

  late final List<String> switchRoles =
      _rolesSpecMap.keys.toList(growable: false);

  List<String> inheritedRoles(String currentRole) =>
      _rolesSpecMap[currentRole] ?? [];

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
      rolesSpec: (data['rolesSpec'] as List<dynamic>)
          .map<RolesSpecEntry>(
              (dynamic e) => RolesSpecEntry.fromMap(e as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': access,
      'refreshToken': refresh,
      'role': role,
      'rolesSpec': rolesSpec.map((e) => e.toMap()).toList(growable: false),
    };
  }
}

@freezed
class RolesSpecEntry with _$RolesSpecEntry {
  factory RolesSpecEntry({
    required String role,
    required List<String> inherited,
  }) = _RolesSpecEntry;

  const RolesSpecEntry._();

  factory RolesSpecEntry.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for RolesSpecEntry');
    }

    final role = data['role'] as String?;
    if (role == null) {
      throw Exception('Did not found role in RolesSpecEntry');
    }

    final inherited = data['inherited'] as List<dynamic>?;
    if (inherited == null) {
      throw StateError('missing inherited for RolesSpecEntry');
    }

    return RolesSpecEntry(
      role: role,
      inherited: List.castFrom<dynamic, String>(inherited),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'inherited': inherited,
    };
  }
}
