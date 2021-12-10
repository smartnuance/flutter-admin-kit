import 'package:admin/views/models/ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_model.freezed.dart';

@freezed
class MenuItem with _$MenuItem {
  factory MenuItem({required String title, String? svgSrc, String? group}) =
      _MenuItem;

  const MenuItem._();

  factory MenuItem.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for MenuItem');
    }
    final title = data['title'] as String?;
    if (title == null) {
      throw StateError('missing title for MenuItem');
    }
    return MenuItem(
      title: title,
      svgSrc: data['svgSrc'] as String?,
      group: data['group'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'svgSrc': svgSrc,
      'group': group,
    };
  }
}

@freezed
class MenuEntry with _$MenuEntry {
  /// Represents a single menu item.
  factory MenuEntry.single(ViewId viewId, MenuItem item) = SingleMenuEntry;

  /// Represents a menu group.
  factory MenuEntry.group(MenuGroup group, List<SingleMenuEntry> items) =
      MenuEntryGroup;

  MenuEntry._();
}

@freezed
class MenuGroup with _$MenuGroup {
  factory MenuGroup({
    required String title,
    String? description,
    @Default(false) bool initiallyExpanded,
  }) = _MenuGroup;

  const MenuGroup._();

  factory MenuGroup.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for MenuGroup');
    }
    final title = data['title'] as String?;
    if (title == null) {
      throw StateError('missing title for MenuGroup');
    }
    return MenuGroup(
      title: title,
      description: data['description'] as String?,
      initiallyExpanded: data['initiallyExpanded'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'initiallyExpanded': initiallyExpanded,
    };
  }
}
