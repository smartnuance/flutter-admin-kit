import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';

@freezed
class Message with _$Message {
  factory Message.info({
    required String text,
    required DateTime timestamp,
    String? detail,
    @Default(true) bool showSnack,
  }) = _Message;

  factory Message.error({
    required String text,
    required DateTime timestamp,
    Object? error,
    StackTrace? stackTrace,
    @Default(false) bool canRetry,
    @Default(true) bool showSnack,
  }) = _ErrorMessage;

  Message._();

  bool get isError => maybeMap(error: (_) => true, orElse: () => false);
  bool get canRetry => maybeMap(error: (m) => m.canRetry, orElse: () => false);
}

@freezed
class MessageList with _$MessageList {
  factory MessageList(List<Message> items) = _MessageList;

  const MessageList._();

  bool get hasErrors => items.where((m) => m.isError).isNotEmpty;

  bool get hasActions => items.where((m) => m.canRetry).isNotEmpty;
}
