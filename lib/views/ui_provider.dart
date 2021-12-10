import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:admin/main.dart';
import 'package:admin/views/menu/menu_model.dart';
import 'package:admin/views/models/ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaml/yaml.dart';

final dashboardView = View(
  id: ViewId.dashboard,
  title: 'Dashboard',
  menuItem: MenuItem(
    title: 'Dashboard',
    svgSrc: 'assets/icons/menu_dashboard.svg',
  ),
);

final loginView = View(
  id: ViewId.login,
  title: 'Login',
);

final messageView = View(
  id: ViewId.messages,
  title: 'Messages',
);

final accountView = View(
  id: ViewId.account,
  title: 'Account',
);

final defaultMenuGroups = <String, MenuGroup>{
  // Example:
  // 'events': const MenuGroup(title: 'Event System'),
};

final defaultViews = <View>[
  dashboardView,
  loginView,
  messageView,
  accountView,
];

/// Provides a toggle to show/hide the debug panel with information about global state.
final showDebugPanelProvider = StateProvider<bool>((ref) => true);

/// Provides a global [ViewRouterDelegate].
///
/// By defining the router delegate as a riverpod provider allows to parameterize it
/// with a [ProviderRef]. The reference can then be used to get access to
/// the fresh global state that keeps track of desired route changes
/// triggered from anywhere in the app:
///
/// ```dart
/// ref.read(viewStackProvider.notifier).switchView(viewId);
/// Scaffold.of(context).openEndDrawer();
/// ```
/// The `openEndDrawer()` is a necessary workaround to close drawer, since `pop()`
/// does not find a navigator up in the hierarchy.
///
/// This provider does not update based on other providers.
final routerDelegateProvider = Provider<ViewRouterDelegate>((ref) {
  return ViewRouterDelegate(ref);
});

final pageViewProvider = StateProvider<View>((_) => throw UnimplementedError());

/// Loads last opened, non-temporary view from local storage via shared preferences library.
Future<ViewId?> loadLastOpenView() async {
  final prefs = await SharedPreferences.getInstance();
  final lastView = prefs.getString('lastView');
  if (lastView == null) {
    return null;
  }
  final viewId = ViewId.fromMap(json.decode(lastView) as Map<String, dynamic>);
  developer.log('load last open view: $viewId');
  return viewId;
}

Future<void> storeLastOpenView(ViewId viewId) async {
  final prefs = await SharedPreferences.getInstance();
  final encoded = json.encode(viewId.toMap());
  await prefs.setString('lastView', encoded);
  developer.log('store last open view to $viewId');
}

final mainViewProvider = StateProvider<RoutedView?>((ref) {
  final viewStack = ref.watch(viewStackProvider);
  if (viewStack.isEmpty) {
    return null;
  }
  final mainView = viewStack.last;
  storeLastOpenView(mainView.id);

  final notFoundPath = ref.watch(notFoundPathProvider);
  if (notFoundPath != null) {
    return RoutedView.notFound(path: notFoundPath);
  }

  return RoutedView.loaded(path: canonicalPath(mainView), view: mainView);
});

final titleProvider = StateProvider<String>((ref) {
  final mainView = ref.watch(mainViewProvider);

  return mainView?.map(
        resolved: (view) => 'View Not loaded',
        loaded: (view) => view.view.title,
        notFound: (view) => 'Not found',
      ) ??
      '';
});

/// Provides the last requested URL that remained unresolved.
///
/// Should be reset to null whenever navigation to a resolvable view takes place.
final notFoundPathProvider = StateProvider<String?>((ref) {
  return null;
});

/// Provides the logical, hierarchy based stack of views.
///
/// The stack of views is hierarchy based because it the stack is derived solely
/// from the current main view and its canonical position in a logical hierarchy
/// of navigable views. The stack is the views on the path to the root of that hierarchy.
///
/// This means in turn, the stack can but doesn't have to represent the navigation
/// _history_.
///
/// This provider can be used for creating a secondary navigation aid with breadcrumbs.
final viewStackProvider =
    StateNotifierProvider<ViewStackState, List<View>>((ref) {
  final ui = ref.watch(uiProvider);
  return ui.maybeWhen(
    data: (ui) {
      final stack = ViewStackState(ref, ui);
      return stack;
    },
    orElse: () => ViewStackState.loading(ref),
  );
});

class ViewStackState extends StateNotifier<List<View>> {
  ViewStackState(this.ref, UI ui)
      // ignore: prefer_initializing_formals
      : ui = ui,
        super(_canonicalStack(ui, ui.initialViewId ?? ViewId.dashboard));

  ViewStackState.loading(this.ref)
      : ui = null,
        super([]);

  final UI? ui;
  late final StateNotifierProviderRef<ViewStackState, List<View>> ref;

  static Iterable<ViewId> _canonical(ViewId viewId) {
    Iterable<ViewId> _buildViewStack() sync* {
      yield ViewId.dashboard;

      if (viewId == ViewId.dashboard) {
        return;
      }

      yield* viewId.maybeWhen(
        modelCreate: (id) sync* {
          // add the list view corresponding to this model create view before in the stack
          yield ViewId.modelList(id);
        },
        orElse: () => {},
      );

      yield viewId;
    }

    return _buildViewStack();
  }

  static List<View> _canonicalStack(UI? ui, ViewId viewId) {
    return List<View>.from(_canonical(viewId)
        .map((viewId) => _lookupView(ui, viewId))
        .where((element) => element != null));
  }

  static View? _lookupView(UI? ui, ViewId viewId) {
    if (ui == null) {
      return null;
    }
    return ui.views[viewId];
  }

  void pushView(ViewId id) {
    developer.log('push view $id');
    final pushedView = _lookupView(ui, id);
    if (pushedView == null) {
      throw StateError('try to push unknown view  $id');
    }

    final Iterable<View> modifiedStack;
    modifiedStack = state.where((view) => view.id != id);
    state = [...modifiedStack, pushedView];

    ref.read(notFoundPathProvider.state).state = null;
  }

  bool canPop() {
    return state.length > 1 || ref.read(notFoundPathProvider) != null;
  }

  bool pop() {
    // first check if there is a not found view
    if (ref.read(notFoundPathProvider) != null) {
      ref.read(notFoundPathProvider.state).state = null;
      return true;
    }

    if (state.length <= 1) {
      return false;
    }
    state = state.sublist(0, state.length - 1);
    ref.read(notFoundPathProvider.state).state = null;
    return true;
  }

  /// Switches to view with [id].
  ///
  /// With the switch, the logical, hierarchy based stack
  /// of views gets replaced by the canonical stack for new view.
  void switchView(ViewId id) {
    developer.log('switch view to $id');
    state = _canonicalStack(ui, id);
    ref.read(notFoundPathProvider.state).state = null;
  }
}

String canonicalPath(View view) {
  return view.id.when(
    custom: (id) => '/${view.id.id}',
    modelList: (id) => '/list/${view.id.id}',
    modelCreate: (id) => '/create/${view.id.id}',
  );
}

/// Provides the configuration for the UI from a config file bundled with the app.
///
/// The config is read from the configured source, see [uiConfigSourceProvider].
final fileUIConfigProvider = FutureProvider<UI>((ref) async {
  final configStr = await rootBundle.loadString('assets/config/ui.yaml');
  final dynamic config = loadYaml(configStr);
  if (config.runtimeType != YamlMap) {
    throw StateError(
        "The 'ui.yaml' config file has an invalid format, there has to be a map at the root level.");
  }
  final encoded = json.encode(config as YamlMap);
  return UI.fromMap(json.decode(encoded));
});

/// Provides the source for the UI configuration.
final uiConfigSourceProvider =
    StateProvider<ConfigSource>((ref) => ConfigSource.file);

/// Provides the configuration for the UI depending on different sources.
///
/// The config is read from the configured source, see [uiConfigSourceProvider].
final uiProvider = FutureProvider<UI>((ref) async {
  final configSource = ref.watch(uiConfigSourceProvider);
  final UI ui;
  switch (configSource) {
    case ConfigSource.file:
      final fileUI = await ref.watch(fileUIConfigProvider.future);
      // merge with default views while views defined in file take precedence (allows overwriting default views)
      ui = fileUI.withDefaultViews(defaultViews);
      break;
    case ConfigSource.api:
    // TODO: Handle this case.
    case ConfigSource.fallback:
      ui = UI(
          views: LinkedHashMap<ViewId, View>.fromIterable(defaultViews,
              key: (dynamic view) => (view as View).id),
          menuGroups: defaultMenuGroups);
  }

  final lastOpenView = await loadLastOpenView();
  if (lastOpenView != null) {
    return ui.copyWith(initialViewId: lastOpenView);
  }
  return ui;
});

/// Provides the menu entries depending on the UI configuration.
///
/// See [uiProvider].
final menuEntriesProvider = StateProvider<List<MenuEntry>>((ref) {
  final ui = ref.watch(uiProvider);
  return ui.maybeWhen(
    data: (ui) => ui.menuEntries,
    orElse: () => [],
  );
});
