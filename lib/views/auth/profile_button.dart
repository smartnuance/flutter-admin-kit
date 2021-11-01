import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/ui_model.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileButton extends ConsumerWidget {
  const ProfileButton({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    void onPressed() =>
        ref.read(viewStackProvider.notifier).pushView(ViewId.account);
    return user.when(
      data: (user) => user.isAnonymous
          ? IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () =>
                  ref.read(viewStackProvider.notifier).pushView(ViewId.login),
            )
          : SizedBox(
              height: 50,
              child: compact
                  ? IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: onPressed,
                    )
                  : OutlinedButton.icon(
                      label: Text(user.toString()),
                      icon: const Icon(Icons.person),
                      onPressed: onPressed,
                    ),
            ),
      loading: (_) => const CircularProgressIndicator(strokeWidth: 2),
      error: (error, stackTrace, _) =>
          const IconButton(icon: Icon(Icons.person_outline), onPressed: null),
    );
  }
}
