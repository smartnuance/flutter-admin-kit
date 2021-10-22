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
  'admin': 'Admin'.i18n,
  'event organizer': 'Event Organizer'.i18n,
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
                        RoleSwitch(),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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

class RoleSwitch extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider).state;

    final items = roles.entries.map<DropdownMenuItem<String>>((entry) {
      return DropdownMenuItem<String>(
        value: entry.key,
        child: Text(entry.value),
      );
    }).toList();
    return DropdownButton<String>(
      value: role,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (newRole) {
        ref.read(roleProvider).state = newRole ?? noRole;
      },
      items: items,
    );
  }
}
