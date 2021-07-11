import 'package:admin/responsive.dart';
import 'package:admin/views/messages/message_model.dart';
import 'package:admin/views/messages/message_provider.dart';
import 'package:admin/views/ui_model.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/i18n_widget.dart';

import 'menu/side_menu.dart';

const drawerKey = GlobalObjectKey<ScaffoldState>('drawer');

class SharedScaffold extends ConsumerWidget {
  const SharedScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<Message>>(
      snackStreamProvider,
      (state) {
        state.whenData(
          (m) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 3),
              content: Text(
                m.text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: m.isError
                        ? Theme.of(context).errorColor
                        : Colors.white),
              ),
              action: SnackBarAction(
                label: 'View',
                onPressed: () => ref
                    .read(viewStackProvider.notifier)
                    .pushView(ViewId.messages),
              ),
            ),
          ),
        );
      },
    );

    return I18n(
      child: Scaffold(
        key: drawerKey,
        drawer: SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (DeviceSize.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
