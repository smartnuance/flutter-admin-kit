import 'package:admin/constants.dart';
import 'package:admin/views/auth/account_view.dart';
import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/messages/message_provider.dart';
import 'package:admin/views/ui_model.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DebugPanel extends ConsumerWidget {
  const DebugPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(userProvider.notifier);
    final user = ref.watch(userProvider);
    final accessToken = ref.watch(tokensProvider)?.access ?? '';
    final refreshToken = ref.watch(tokensProvider)?.refresh ?? '';
    final viewStack = ref.watch(viewStackProvider);
    final notFoundPath = ref.watch(notFoundPathProvider).state;

    return PhysicalModel(
      color: Colors.white,
      shadowColor: Colors.black,
      elevation: 50.0,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.black12,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(children: [
            const Text(
              'userProvider',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: defaultPadding),
            Flexible(
              flex: 0,
              child: Row(
                children: [
                  Expanded(
                    child: user.when(
                      data: (user) =>
                          _buildCopyableText('User:', user.toString()),
                      loading: (_) => const LinearProgressIndicator(),
                      error: (error, stackTrace, _) =>
                          _buildCopyableText('Error:', error.toString()),
                    ),
                  ),
                  const SizedBox(width: defaultPadding),
                  Flexible(
                    flex: 1,
                    child: RoleSwitch(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            Flexible(
              flex: 0,
              child: Row(
                children: [
                  Flexible(
                    flex: 0,
                    child: TextButton.icon(
                        onPressed: () => auth.signInWithCredential(
                            username: 'simon@smartnuance.com',
                            password: 'f00bartest'),
                        icon: const Icon(Icons.manage_accounts),
                        label: const Text('Login test super admin user')),
                  ),
                  const SizedBox(width: defaultPadding),
                  Flexible(
                    flex: 0,
                    child: TextButton.icon(
                        onPressed: () => auth.signOut(),
                        icon: const Icon(Icons.logout),
                        label: Text('Sign out'.i18n)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            Flexible(
              flex: 0,
              child: Row(
                children: [
                  Expanded(
                    child: _buildCopyableText('Access token:', accessToken),
                  ),
                  const SizedBox(width: defaultPadding),
                  Expanded(
                    child: _buildCopyableText('Refresh token:', refreshToken),
                  ),
                  const SizedBox(width: defaultPadding),
                  Flexible(
                    flex: 0,
                    child: TextButton.icon(
                        onPressed: () => auth.refreshToken(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh')),
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            const Text(
              'messagesProvider',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: defaultPadding),
            Flexible(
              flex: 0,
              child: Row(
                children: [
                  const Expanded(
                    child: Text('Publish message:'),
                  ),
                  const SizedBox(width: defaultPadding),
                  TextButton.icon(
                    label: const Text('Info message'),
                    icon: const Icon(Icons.info_outline),
                    onPressed: () async =>
                        ref.read(messagesProvider.notifier).info(
                              text: 'Test message',
                              detail:
                                  'This is a test message manually published by debug panel.',
                            ),
                  ),
                  const SizedBox(width: defaultPadding),
                  TextButton.icon(
                    label: const Text('Error message'),
                    icon: const Icon(Icons.warning_amber_outlined),
                    onPressed: () async =>
                        ref.read(messagesProvider.notifier).error(
                              text: 'Test error message',
                              error: Exception(
                                  'This is a test message manually published by debug panel.'),
                            ),
                  ),
                ],
              ),
            ),
            const Text(
              'viewStackProvider',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: defaultPadding),
            _buildViewStack(context, viewStack, notFoundPath),
          ]),
        ),
      ),
    );
  }

  Widget _buildCopyableText(String? label, String? value) {
    final text = value == null
        ? '-'
        : value.isEmpty
            ? '<zero-length>'
            : value;
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: value != null && value.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () => Clipboard.setData(ClipboardData(text: value)),
              )
            : null,
      ),
      readOnly: true,
      enableInteractiveSelection: true,
      controller: TextEditingController.fromValue(TextEditingValue(text: text)),
    );
  }

  Widget _buildViewStack(
      BuildContext context, List<View> viewStack, String? notFoundPath) {
    return Column(
      children: [
        if (notFoundPath != null)
          TimelineTile(
            alignment: TimelineAlign.start,
            isFirst: true,
            indicatorStyle: IndicatorStyle(
              width: 40,
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(8),
              iconStyle: IconStyle(
                color: Colors.white,
                iconData: Icons.layers_clear_outlined,
              ),
            ),
            endChild: Container(
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(
                minHeight: 60,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(defaultDensePadding),
                  child: _buildCopyableText('notFoundPath', notFoundPath),
                ),
              ),
            ),
          ),
        ListView.builder(
          itemCount: viewStack.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final view = viewStack[viewStack.length - index - 1];
            return TimelineTile(
              alignment: TimelineAlign.start,
              isFirst: index == 0 && notFoundPath == null,
              isLast: index == viewStack.length - 1,
              indicatorStyle: IndicatorStyle(
                width: 40,
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(8),
                iconStyle: IconStyle(
                  color: Colors.white,
                  iconData: Icons.layers_outlined,
                ),
              ),
              endChild: Container(
                alignment: Alignment.centerLeft,
                constraints: const BoxConstraints(
                  minHeight: 60,
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${view.title} - ${view.id}')),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class DebugButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDebugPanel = ref.watch(showDebugPanelProvider.notifier);

    return ToggleButtons(
      children: [
        Icon(showDebugPanel.state ? Icons.category : Icons.category_outlined)
      ],
      onPressed: (_) => showDebugPanel.state = !showDebugPanel.state,
      isSelected: [showDebugPanel.state],
    );
  }
}
