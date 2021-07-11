import 'dart:math';

import 'package:admin/common_widgets/progress_status.dart';
import 'package:admin/dialogs/show_exception_alert_dialog.dart';
import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/auth/sign_in/buttons.dart';
import 'package:admin/views/ui_model.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/default.i18n.dart';

class SignInOptionsView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(userProvider.notifier);
    final user = ref.watch(userProvider);

    auth.stream.handleError((dynamic error) {
      showExceptionAlertDialog(
        context: context,
        title: 'Exception in Stream',
        exception: error,
      );
    });

    return user.when(
      data: (user) {
        if (user.isAnonymous) {
          return _buildSignIn(context, ref);
        }

        return Center(
          child: Text('Welcome ${user.username}'),
        );
      },
      loading: () => const ProgressStatus(),
      error: (error, stackTrace) => Center(
        child: Text('Error: ${error.toString()}'),
      ),
    );
  }
}

Widget _buildSignIn(BuildContext context, WidgetRef ref) {
  return Center(
    child: LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: min(constraints.maxWidth, 600),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 32.0),
            SignInButton(
              text: 'Sign in with email and password'.i18n,
              onPressed: () =>
                  ref.read(viewStackProvider.notifier).pushView(ViewId.login),
            ),
            const SizedBox(height: 8),
            Text(
              'or'.i18n,
              style: const TextStyle(fontSize: 14.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            SignInButton(
              text: 'Go anonymous'.i18n,
              onPressed: ref.read(userProvider.notifier).signInAnonymously,
            ),
          ],
        ),
      );
    }),
  );
}
