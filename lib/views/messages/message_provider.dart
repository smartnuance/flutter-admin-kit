import 'dart:async';

import 'package:admin/views/messages/message_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _snackStreamControllerProvider =
    StateProvider<StreamController<Message>>((ref) {
  final streamController = StreamController<Message>();
  ref.onDispose(() {
    // Closes the StreamController when the state of this provider is destroyed.
    streamController.close();
  });

  return streamController;
});

/// Provides the messages emitted as a stream.
final snackStreamProvider = StreamProvider.autoDispose<Message>((ref) {
  final controller = ref.watch(_snackStreamControllerProvider);

  return controller.state.stream;
});

final messagesProvider =
    StateNotifierProvider<MessagesState, MessageList>((ref) {
  return MessagesState(ref);
});

class MessagesState extends StateNotifier<MessageList> {
  MessagesState(this.ref) : super(MessageList(List.empty()));

  late final ProviderRefBase ref;

  void publish(Message m) {
    state = state.copyWith(items: [...state.items, m]);
    if (m.showSnack) {
      ref.read(_snackStreamControllerProvider).state.sink.add(m);
    }
  }

  void delete(int index) {
    state.items.removeAt(index);
    state = state;
  }
}
