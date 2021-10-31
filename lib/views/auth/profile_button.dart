import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/ui_model.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return user.when(
      data: (user) => user.isAnonymous
          ? IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () =>
                  ref.read(viewStackProvider.notifier).pushView(ViewId.login),
            )
          : SizedBox(
              height: 50,
              child: OutlinedButton.icon(
                label: Text(user.displayName ?? user.username),
                icon: const Icon(Icons.person),
                onPressed: () => ref
                    .read(viewStackProvider.notifier)
                    .pushView(ViewId.account),
              ),
            ),
      loading: (_) => const CircularProgressIndicator(strokeWidth: 2),
      error: (error, stackTrace, _) =>
          const IconButton(icon: Icon(Icons.person_outline), onPressed: null),
    );
  }
}
