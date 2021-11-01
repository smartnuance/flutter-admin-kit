import 'package:admin/common_widgets/my_files_model.dart';
import 'package:admin/views/auth/auth_provider.dart';
import 'package:admin/views/crud/api_service.dart';
import 'package:admin/views/ui_model.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/default.i18n.dart';

import '../constants.dart';
import 'file_info_card.dart';

class ErrorActions extends ConsumerWidget {
  const ErrorActions(this.error, {this.onRetry, this.widget, Key? key})
      : super(key: key);

  final Object error;
  final VoidCallback? onRetry;
  final Widget? widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                color: Theme.of(context).errorColor,
                width: 10,
                style: BorderStyle.solid),
            right: BorderSide(
                color: Theme.of(context).errorColor,
                width: 10,
                style: BorderStyle.solid),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (error.runtimeType == NotAuthorizedException) ...[
              const Text('You are not authorized to open this view.'),
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (user.asData?.value.isAnonymous ?? true)
                    OutlinedButton(
                      child: Text(
                        'Sign in'.i18n,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () => ref
                          .read(viewStackProvider.notifier)
                          .pushView(ViewId.login),
                    ),
                  const SizedBox(width: defaultPadding),
                  if (onRetry != null)
                    OutlinedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text(
                        'Retry',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: onRetry,
                    ),
                ],
              )
            ] else if (error.runtimeType == PermissionException) ...[
              const Text('You do not have permission to open this view.'),
              if (widget != null) ...[
                const SizedBox(height: defaultPadding),
                widget!
              ]
            ] else
              Text(error.toString()),
          ],
        ),
      ),
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  });

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    final fields = demoFields(context);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: fields.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: fields[index]),
    );
  }
}
