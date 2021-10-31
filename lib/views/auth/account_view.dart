import 'dart:async';

import 'package:admin/common_widgets/error_actions.dart';
import 'package:admin/constants.dart';
import 'package:admin/dialogs/show_alert_dialog.dart';
import 'package:admin/views/auth/auth.dart';
import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/auth/permission_gate.dart';
import 'package:admin/views/auth/sign_in/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/default.i18n.dart';

final roles = <String, String>{
  'super admin': 'Super Admin'.i18n,
  'instance admin': 'Instance Admin'.i18n,
  'event organizer': 'Event Organizer'.i18n,
  'teacher': 'Teacher'.i18n,
  noRole: 'Anonymous'.i18n,
};

class AccountView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(userProvider.notifier);
    final user = ref.watch(userProvider);

    return PermissionGate(
      signedInBuilder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            ...user.maybeWhen(
                data: (user) => user.isAnonymous
                    ? [
                        const ErrorActions(
                            'You cannot access the account page.')
                      ]
                    : [
                        _buildUserInfo(user),
                        const SizedBox(height: defaultPadding),
                        RoleSwitch(),
                        const SizedBox(height: defaultPadding),
                        _buildButtons(context, auth),
                      ],
                orElse: () => [Container()])
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        if (user.displayName != null)
          Text(
            user.displayName!,
            style: const TextStyle(color: Colors.white),
          ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildButtons(BuildContext context, Auth auth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(),
        Flexible(
          child: SignOutButton(
            key: const Key('logout-button'),
            text: 'Sign out'.i18n,
            onPressed: () => _confirmSignOut(context, auth),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmSignOut(BuildContext context, Auth auth) async {
    final bool confirmed = await showAlertDialog(
          context: context,
          title: 'Sign out'.i18n,
          content: 'Are you sure that you want to sign out?'.i18n,
          cancelActionText: 'Cancel'.i18n,
          defaultActionText: 'Sign out'.i18n,
        ) ??
        false;
    if (confirmed) {
      await auth.signOut();
    }
  }
}

final switchRolesProvider = Provider<List<String>>(
  (ref) {
    return ref.watch(userProvider
        .select((user) => user.asData?.value.tokens?.switchRoles ?? [noRole]));
  },
);

class RoleSwitch extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(currentRoleProvider);
    final switchRoles = ref.watch(switchRolesProvider);

    final items = switchRoles.map<DropdownMenuItem<String>>((role) {
      return DropdownMenuItem<String>(
        value: role,
        child: Text(roles[role] ?? role),
      );
    }).toList();
    return DropdownButtonFormField<String>(
      value: role,
      icon: const Icon(Icons.arrow_drop_down),
      decoration: const InputDecoration(
        label: Text('Current role'),
        border: OutlineInputBorder(),
      ),
      iconSize: 24,
      elevation: 16,
      onChanged: (newRole) {
        ref.read(userProvider.notifier).switchRole(newRole);
      },
      items: items,
    );
  }
}
