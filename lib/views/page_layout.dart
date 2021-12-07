import 'package:admin/common_widgets/header.dart';
import 'package:admin/views/debug_panel.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageLayout extends ConsumerWidget {
  const PageLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDebugPanel = ref.watch(showDebugPanelProvider);

    final mainContainer = Column(
      children: [const Header(), Flexible(child: child)],
    );

    if (showDebugPanel) {
      return Column(
        children: [
          Expanded(
            flex: 5,
            child: mainContainer,
          ),
          const Expanded(flex: 3, child: DebugPanel()),
        ],
      );
    } else {
      return mainContainer;
    }
  }
}
