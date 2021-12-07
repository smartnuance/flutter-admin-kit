import 'package:admin/views/menu/menu_model.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(menuEntriesProvider);
    final mainView = ref.watch(mainViewProvider);
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(children: [
          DrawerHeader(
            child: SvgPicture.asset(
              'assets/icons/flutter-admin-kit.svg',
              height: 80,
            ),
          ),
          ...entries
              .map((entry) => entry.map(
                    single: (entry) => _buildMenuTile(
                      context,
                      ref,
                      entry,
                      selected: mainView?.maybeWhen(
                            loaded: (path, view) => entry.viewId == view.id,
                            orElse: () => false,
                          ) ??
                          false,
                    ),
                    group: (entry) => GroupTile(
                      title: entry.group.title,
                      description: entry.group.description,
                      children: entry.items
                          .map<Widget>((item) => _buildMenuTile(
                                context,
                                ref,
                                item,
                                selected: mainView?.maybeWhen(
                                      loaded: (path, view) =>
                                          item.viewId == view.id,
                                      orElse: () => false,
                                    ) ??
                                    false,
                              ))
                          .toList(growable: false),
                      initiallyExpanded: entry.group.initiallyExpanded,
                    ),
                  ))
              .toList(growable: false)
        ]),
      ),
    );
  }
}

Widget _buildMenuTile(
    BuildContext context, WidgetRef ref, SingleMenuEntry entry,
    {bool selected = false}) {
  return MenuTile(
      title: entry.item.title,
      svgSrc: entry.item.svgSrc ?? 'assets/icons/unknown.svg',
      selected: selected,
      press: () {
        ref.read(viewStackProvider.notifier).switchView(entry.viewId);
        // Workaround to close drawer since context has no navigator to call .pop() on
        Scaffold.of(context).openEndDrawer();
      });
}

class MenuTile extends StatelessWidget {
  const MenuTile({
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    this.selected = false,
    required this.press,
  });

  final String title, svgSrc;
  final bool selected;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        height: 16,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: selected ? const TextStyle(fontWeight: FontWeight.bold) : null,
      ),
    );
  }
}

class GroupTile extends StatelessWidget {
  const GroupTile({
    required this.title,
    this.description,
    required this.children,
    this.initiallyExpanded = false,
  });

  final String title;
  final String? description;
  final List<Widget> children;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          if (description != null)
            Text(
              description!,
              style: Theme.of(context).textTheme.caption,
            )
        ],
      ),
      children: children,
      initiallyExpanded: initiallyExpanded,
    );
  }
}
