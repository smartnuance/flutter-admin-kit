import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/my_files.dart';
import '../../common_widgets/recent_files.dart';
import '../../common_widgets/storage_details.dart';
import '../../constants.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    MyFiles(),
                    const SizedBox(height: defaultPadding),
                    RecentFiles(),
                    if (DeviceSize.isMobile(context))
                      const SizedBox(height: defaultPadding),
                    if (DeviceSize.isMobile(context)) StorageDetails(),
                  ],
                ),
              ),
              if (!DeviceSize.isMobile(context))
                const SizedBox(width: defaultPadding),
              // On Mobile means if the screen is less than 850 we don't want to show it
              if (!DeviceSize.isMobile(context))
                Expanded(
                  flex: 2,
                  child: StorageDetails(),
                ),
            ],
          )
        ],
      ),
    );
  }
}
