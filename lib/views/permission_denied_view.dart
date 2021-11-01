import 'package:admin/common_widgets/error_actions.dart';
import 'package:admin/views/auth/account_view.dart';
import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/crud/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionDeniedView extends ConsumerWidget {
  const PermissionDeniedView({
    Key? key,
    this.requiredRole,
  }) : super(key: key);

  final String? requiredRole;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = ref.watch(tokensProvider);
    return ErrorActions(
      PermissionException(),
      widget: tokens?.switchRoles
                  .where((r) => tokens.inheritedRoles(r).contains(requiredRole))
                  .isNotEmpty ??
              false
          ? Column(
              children: [const Text('Try switching role:'), RoleSwitch()],
            )
          : null,
    );
  }
}
