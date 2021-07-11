import 'package:admin/utils/string_manipulation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

@freezed
class User with _$User {
  factory User({
    required String username,
    String? displayName,
    TokenPair? tokens,
  }) = _User;

  factory User.anonymous({
    @Default('') String username,
    @Default('') String? displayName,
    @Default(null) TokenPair? tokens,
  }) = _AnonymousUser;

  User._();

  late final isAnonymous = username == '';
}

@freezed
class TokenPair with _$TokenPair {
  factory TokenPair({
    required String refresh,
    required String access,
  }) = _TokenPair;

  const TokenPair._();

  @override
  String toString() {
    return '(Access: ...${tail(access, 5)}, Refresh: ...${tail(refresh, 5)})';
  }
}
