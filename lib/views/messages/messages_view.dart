import 'package:admin/dialogs/show_alert_dialog.dart';
import 'package:admin/views/messages/message_model.dart';
import 'package:admin/views/messages/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesView extends ConsumerWidget {
  const MessagesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messagesProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: messages.items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final m = messages.items[index];
              void delete() =>
                  ref.read(messagesProvider.notifier).delete(index);
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  delete();
                },
                background: Container(color: Theme.of(context).backgroundColor),
                confirmDismiss: (direction) async =>
                    direction == DismissDirection.startToEnd,
                child: _buildMessage(context, index, m, delete),
              );
            },
          )
        ],
      ),
    );
  }
}

Widget _buildMessage(
    BuildContext context, int index, Message message, VoidCallback delete) {
  return message.when(
      info: (text, timestamp, detail, showSnack) => ListTile(
            title: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              detail ?? '',
            ),
            leading: const Icon(
              Icons.info_outline,
              size: 30,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: delete,
            ),
            onTap: () => showAlertDialog(
              context: context,
              title: text,
              content: detail ?? '',
              defaultActionText: 'OK',
            ),
            hoverColor: Colors.grey,
          ),
      error: (text, timestamp, error, stackTrace, canRetry, showSnack) =>
          ListTile(
            title: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).errorColor,
              ),
            ),
            subtitle: Text(
              error?.toString() ?? '',
            ),
            leading: Icon(
              Icons.warning_amber_outlined,
              color: Theme.of(context).errorColor,
              size: 30,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: delete,
            ),
            onTap: () => showAlertDialog(
              context: context,
              title: error?.toString() ?? '',
              content: stackTrace?.toString() ?? '',
              defaultActionText: 'OK',
            ),
            hoverColor: Colors.grey,
          ));
}
