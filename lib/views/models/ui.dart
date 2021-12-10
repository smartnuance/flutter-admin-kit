import 'dart:collection';

import 'package:admin/views/menu/menu_model.dart';
import 'package:admin/views/models/layout.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui.freezed.dart';

enum ConfigSource { file, api, fallback }

/// Defines the UI spec.
@freezed
class UI with _$UI {
  factory UI({
    required Map<ViewId, View> views,
    @Default(<String, MenuGroup>{}) Map<String, MenuGroup> menuGroups,
    ViewId? initialViewId,
  }) = _UI;

  UI._();

  late final menuEntries = _initMenuEntries().toList(growable: false);

  /// Constructs menu entries from the view and group specs.
  ///
  /// Views with no `menuItem` defined are omitted from menu.
  /// Views without a `menuItem.group` are added as top level entries.
  /// Whenever a `menuItem.group.id` is first mention on a view spec, the group appears in the menu.
  Iterable<MenuEntry> _initMenuEntries() sync* {
    // filter views that define a menu item
    final drawerViews = views.values.where((view) => view.menuItem != null);

    // collect by groups in first iteration over view specs
    final groups = <String, List<View>>{};
    for (final view in drawerViews) {
      final group = view.menuItem!.group;
      if (group != null) {
        groups.putIfAbsent(group, () => []);
        groups[group]!.add(view);
      }
    }

    // construct entries in second iteration over view specs
    final groupsAdded = <String>{};
    for (final view in drawerViews) {
      final group = view.menuItem!.group;
      if (group != null && menuGroups.containsKey(group)) {
        if (!groupsAdded.contains(group)) {
          // since we created the groups from the drawerViews in first iteration, we know this map key always exists
          final groupItems = groups[group]!;
          yield MenuEntry.group(
              menuGroups[group]!,
              groupItems
                  .map((v) => SingleMenuEntry(v.id, v.menuItem!))
                  .toList(growable: false));
          groupsAdded.add(group);
        }
      } else {
        yield MenuEntry.single(view.id, view.menuItem!);
      }
    }
  }

  /// Creates the UI spec from a map.
  ///
  /// A yaml file as an input source,
  /// corresponding to a valid [data] map could look like this:
  ///
  /// ```yaml
  /// views:
  ///   - id:
  ///       id: dashboard
  ///       type: custom
  ///     title: Dashboard
  ///     menuItem:
  ///       title: Home
  ///       svgSrc: assets/icons/menu_dashboard.svg
  ///   - id:
  ///       id: events
  ///       type: modelList
  ///     title: Events
  ///     menuItem:
  ///       title: All Events
  ///       svgSrc: assets/icons/menu_doc.svg
  ///       group: event-system
  /// menuGroups:
  ///   event-system:
  ///     title: Event System
  ///     description: Manage events & subscriptions
  /// ```
  factory UI.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for UI');
    }

    final viewsIterable = List<Map<String, dynamic>>.from(
            data['views'] ?? <Map<String, dynamic>>[])
        .map((m) => View.fromMap(m));
    final viewsMap = LinkedHashMap<ViewId, View>.fromIterable(viewsIterable,
        key: (dynamic view) => (view as View).id);

    final menuGroups = data['menuGroups'] as Map<String, dynamic>? ?? {};
    final menuGroupsMap = menuGroups.map((key, dynamic value) =>
        MapEntry(key, MenuGroup.fromMap(value as Map<String, dynamic>)));

    return UI(
      // order of views in input list matters; transform to ordered map
      views: viewsMap,
      menuGroups: menuGroupsMap,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'views': views.map((id, view) => MapEntry(id, view.toMap())),
      'menuGroups': menuGroups.map((id, group) => MapEntry(id, group.toMap())),
    };
  }

  UI withDefaultViews(List<View> defaults) {
    final updated = LinkedHashMap<ViewId, View>.fromIterable(defaults,
        key: (dynamic view) => (view as View).id);
    for (final view in views.values) {
      updated[view.id] = view;
    }
    return copyWith(
      views: updated,
    );
  }
}

const dashboardId = 'dashboard';

@freezed
class RoutedView with _$RoutedView {
  /// A resolved RoutedView is a route that could be translated into a valid view id.
  factory RoutedView.resolved({
    required String path,
    required ViewId viewId,
  }) = Resolved;

  /// A loaded RoutedView is a progression of a [RoutedView.resolved],
  /// where not only the view id is valid, but also a view definition could be resolved.
  factory RoutedView.loaded({
    required String path,
    required View view,
  }) = Loaded;

  /// A not found RoutedView is either a completely unknown view or a progression
  /// of a [RoutedView.resolved] where the resolved viewId could not be used to load a view.
  factory RoutedView.notFound({
    required String path,
  }) = NotFound;
}

@freezed
class ViewId with _$ViewId {
  factory ViewId.custom(String id) = Custom;

  factory ViewId.modelList(String id) = ModelList;

  factory ViewId.modelCreate(String id) = ModelCreate;

  ViewId._();

  static final dashboard = ViewId.custom(dashboardId);
  static final login = ViewId.custom('login');
  static final messages = ViewId.custom('messages');
  static final account = ViewId.custom('account');

  factory ViewId.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for View');
    }

    switch (data['type'] as String) {
      case 'modelList':
        return ViewId.modelList(data['id'] as String);
      case 'modelCreate':
        return ViewId.modelCreate(data['id'] as String);
      case 'custom':
      default:
        return ViewId.custom(data['id'] as String);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': when(
        custom: (id) => 'custom',
        modelList: (id) => 'modelList',
        modelCreate: (id) => 'modelCreate',
      ),
    };
  }
}

@freezed
class View with _$View {
  factory View({
    required ViewId id,
    required String title,
    MenuItem? menuItem,
    @Default({}) Map<String, Layout> layouts,
  }) = _View;

  View._();

  factory View.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for View');
    }
    final viewId = data['id'] as Map<String, dynamic>?;
    if (viewId == null) {
      throw StateError('missing id for View');
    }
    final layoutsData = data['layouts'] as Map<String, dynamic>? ?? {};
    final layouts = layoutsData.map((layoutName, dynamic m) =>
        MapEntry(layoutName, Layout.fromMap(m as Map<String, dynamic>?)));
    return View(
      id: ViewId.fromMap(viewId),
      title: data['title'] as String,
      menuItem: MenuItem.fromMap(data['menuItem']),
      layouts: layouts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id.toMap(),
      'title': title,
      'menuItem': menuItem?.toMap(),
    };
  }
}
