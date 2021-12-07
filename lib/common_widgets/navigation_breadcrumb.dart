import 'package:admin/views/ui_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBreadcrumb extends ConsumerWidget {
  const NavigationBreadcrumb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final views = ref.watch(viewStackProvider);
    final mainView = ref.watch(mainViewProvider);
    return BreadCrumb(
      items: views.map(
        (stackView) {
          final label = Text(
            stackView.title,
            style: Theme.of(context).textTheme.subtitle1,
          );
          final onPressed = mainView?.maybeWhen(
            loaded: (path, view) => view.id != stackView.id
                ? () {
                    ref
                        .read(viewStackProvider.notifier)
                        .switchView(stackView.id);
                  }
                : null,
            orElse: () => null,
          );

          return BreadCrumbItem(
            content: stackView.menuItem?.svgSrc != null
                ? TextButton.icon(
                    icon: SvgPicture.asset(
                      stackView.menuItem?.svgSrc ?? 'assets/icons/unknown.svg',
                      color: Theme.of(context).primaryColor,
                    ),
                    label: label,
                    onPressed: onPressed,
                  )
                : TextButton(
                    child: label,
                    onPressed: onPressed,
                  ),
          );
        },
      ).toList(growable: false),
      divider: const Icon(Icons.chevron_right),
      overflow: ScrollableOverflow(
        keepLastDivider: false,
        reverse: false,
        direction: Axis.horizontal,
      ),
    );
  }
}
