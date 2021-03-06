import 'package:admin/common_widgets/navigation_breadcrumb.dart';
import 'package:admin/responsive.dart';
import 'package:admin/views/auth/permission_gate.dart';
import 'package:admin/views/crud/model_list.dart';
import 'package:admin/views/crud/model_provider.dart';
import 'package:admin/views/crud/models/model_infos.dart';
import 'package:admin/views/models/ui.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';

class ModelListView extends ConsumerWidget {
  const ModelListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meta = ModelMeta(
      service: 'event',
      model: 'workshop',
    );
    return PermissionGate(
      requiredRole: 'event organizer',
      signedInBuilder: (context) => Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const NavigationBreadcrumb(),
                IconButton(
                  iconSize: 20,
                  splashRadius: 30,
                  icon: const Icon(Icons.refresh),
                  onPressed: () =>
                      ref.read(modelItemsProvider(meta).notifier).reload(),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (DeviceSize.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    ref
                        .read(viewStackProvider.notifier)
                        .pushView(ViewId.modelCreate('events'));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const Expanded(child: ModelObjectList()),
          ],
        ),
      ),
    );
  }
}
