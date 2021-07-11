import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';

@freezed
class Message with _$Message {
  factory Message({
    required String text,
    String? detail,
    Object? error,
    StackTrace? stackTrace,
    @Default(false) bool canRetry,
    @Default(true) bool showSnack,
  }) = _Message;

  Message._();

  bool get isError => error != null;
}

@freezed
class MessageList with _$MessageList {
  factory MessageList(List<Message> items) = _MessageList;

  const MessageList._();

  bool get hasErrors => items.where((m) => m.isError).isNotEmpty;

  bool get hasActions => items.where((m) => m.canRetry).isNotEmpty;
}
