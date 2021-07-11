import 'package:admin/common_widgets/navigation_breadcrumb.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModelCreateView extends ConsumerWidget {
  const ModelCreateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              NavigationBreadcrumb(),
              Text('Create'),
            ],
          ),
        ],
      ),
    );
  }
}
