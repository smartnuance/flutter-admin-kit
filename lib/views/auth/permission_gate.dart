import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/loading_view.dart';
import 'package:admin/views/not_authorized_view.dart';
import 'package:admin/views/permission_denied_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionGate extends ConsumerWidget {
  const PermissionGate({
    Key? key,
    this.requiredRole,
    required this.signedInBuilder,
    this.unauthorizedRoleBuilder,
    this.nonSignedInBuilder,
  }) : super(key: key);

  final String? requiredRole;
  final WidgetBuilder signedInBuilder;
  final WidgetBuilder? unauthorizedRoleBuilder;
  final WidgetBuilder? nonSignedInBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return user.maybeWhen(
      data: (user) {
        if (user.isAnonymous) {
          return (nonSignedInBuilder != null)
              ? nonSignedInBuilder!(context)
              : const NotAuthorizedView();
        } else if (requiredRole != null &&
            !user.currentInheritedRoles.contains(requiredRole!)) {
          return (unauthorizedRoleBuilder != null)
              ? unauthorizedRoleBuilder!(context)
              : PermissionDeniedView(
                  requiredRole: requiredRole,
                );
        } else {
          return signedInBuilder(context);
        }
      },
      orElse: () => const LoadingView(),
    );
  }
}
