import 'package:admin/views/messages/message_provider.dart';
import 'package:admin/views/models/ui.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasErrors = ref
        .watch(messagesProvider.select((messageList) => messageList.hasErrors));
    final hasActions = ref.watch(
        messagesProvider.select((messageList) => messageList.hasActions));
    final IconData iconData;
    if (hasErrors && hasActions) {
      iconData = Icons.notification_important;
    } else if (hasErrors) {
      iconData = Icons.notification_important_outlined;
    } else if (hasActions) {
      iconData = Icons.notification_important;
    } else {
      iconData = Icons.notifications_none;
    }

    return IconButton(
      icon: Icon(iconData),
      onPressed: () =>
          ref.watch(viewStackProvider.notifier).pushView(ViewId.messages),
    );
  }
}
