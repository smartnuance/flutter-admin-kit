import 'package:admin/responsive.dart';
import 'package:admin/views/auth/profile_button.dart';
import 'package:admin/views/debug_panel.dart';
import 'package:admin/views/messages/message_button.dart';
import 'package:admin/views/shared_scaffold.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class Header extends ConsumerWidget {
  const Header({
    this.title = 'title!!',
    this.showMenuButton = true,
    this.showBackButton = true,
    this.showTitle = true,
    this.showSearchField = true,
    this.showButtons = true,
  });

  final String title;
  final bool showMenuButton,
      showBackButton,
      showTitle,
      showSearchField,
      showButtons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultDensePadding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              width: 1.0, color: Theme.of(context).primaryColorLight),
        ),
      ),
      child: Row(
        children: [
          if (showMenuButton && !DeviceSize.isDesktop(context))
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => drawerKey.currentState?.openDrawer(),
            ),
          // TODO remove back button for non-mobile devices
          if (showBackButton && ref.watch(viewStackProvider.notifier).canPop())
            const BackButton(),
          if (showTitle && !DeviceSize.isMobile(context))
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          if (!DeviceSize.isMobile(context))
            Spacer(flex: DeviceSize.isDesktop(context) ? 2 : 1),
          if (showSearchField)
            Expanded(child: SearchField())
          else
            const Spacer(),
          if (showButtons) ...[
            const SizedBox(width: defaultDensePadding),
            DebugButton(),
            const SizedBox(width: defaultDensePadding),
            MessageButton(),
            const SizedBox(width: defaultDensePadding),
            ProfileButton(compact: DeviceSize.isMobile(context)),
          ]
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        fillColor: Theme.of(context).cardColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset('assets/icons/Search.svg'),
          ),
        ),
      ),
    );
  }
}
