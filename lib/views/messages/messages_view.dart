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
    BuildContext context, int index, Message m, VoidCallback delete) {
  return ListTile(
    title: Text(
      m.text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: m.isError ? Theme.of(context).errorColor : Colors.black),
    ),
    subtitle: Text(
      m.detail ?? (m.isError ? m.error.toString() : ''),
    ),
    leading: m.isError
        ? Icon(
            Icons.warning_amber_outlined,
            color: Theme.of(context).errorColor,
            size: 30,
          )
        : const Icon(
            Icons.info_outline,
            size: 30,
          ),
    trailing: IconButton(
      icon: const Icon(Icons.delete),
      onPressed: delete,
    ),
    onTap: () => showAlertDialog(
      context: context,
      title: m.isError ? m.error.toString() : m.text,
      content: m.isError
          ? (m.stackTrace?.toString() ?? m.detail ?? '')
          : (m.detail ?? ''),
      defaultActionText: 'OK',
    ),
    hoverColor: Colors.grey,
  );
}
