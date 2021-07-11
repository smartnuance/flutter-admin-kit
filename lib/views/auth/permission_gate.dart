import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/loading_view.dart';
import 'package:admin/views/permission_denied_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionGate extends ConsumerWidget {
  const PermissionGate({
    Key? key,
    required this.signedInBuilder,
    this.nonSignedInBuilder,
  }) : super(key: key);

  final WidgetBuilder signedInBuilder;
  final WidgetBuilder? nonSignedInBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return user.maybeWhen(
      data: (user) {
        if (user.isAnonymous) {
          if (nonSignedInBuilder != null) {
            return nonSignedInBuilder!(context);
          } else {
            return const PermissionDeniedView();
          }
        } else {
          return signedInBuilder(context);
        }
      },
      orElse: () => const LoadingView(),
    );
  }
}
