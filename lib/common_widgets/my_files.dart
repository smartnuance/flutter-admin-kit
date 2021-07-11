import 'package:admin/common_widgets/my_files_model.dart';
import 'package:admin/common_widgets/navigation_breadcrumb.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/default.i18n.dart';

import '../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const NavigationBreadcrumb(),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (DeviceSize.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: Text('Add Widget'.i18n),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: LayoutBuilder(
            builder: (context, constraints) {
              return FileInfoCardGridView(
                crossAxisCount: constraints.maxWidth < 550 ? 2 : 4,
                childAspectRatio: constraints.maxWidth < 550 ? 1.3 : 1,
              );
            },
          ),
          tablet: const FileInfoCardGridView(),
          desktop: LayoutBuilder(
            builder: (context, constraints) {
              return FileInfoCardGridView(
                childAspectRatio: constraints.maxWidth < 1000 ? 1.1 : 1.4,
              );
            },
          ),
        ),
      ],
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
