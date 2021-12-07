import 'package:admin/common_widgets/error_actions.dart';
import 'package:admin/common_widgets/progress_status.dart';
import 'package:admin/views/crud/model_provider.dart';
import 'package:admin/views/crud/models/model_infos.dart';
import 'package:admin/views/crud/models/model_instance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:intl/intl.dart';

class ModelObjectList extends ConsumerStatefulWidget {
  const ModelObjectList({Key? key}) : super(key: key);

  @override
  _ModelObjectListState createState() => _ModelObjectListState();
}

class _ModelObjectListState extends ConsumerState<ModelObjectList> {
  final _scrollController = ScrollController();
  final _scrollControllerHorizontal = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final Set<int> selected = {};
  bool multiSelectMode = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollControllerHorizontal.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meta = ModelMeta(
      service: 'event',
      model: 'workshop',
    );
    final spec = ref.watch(modelSpecProvider(meta));
    final modelItems = ref.watch(modelItemsProvider(meta));
    final modelItemsNotifier = ref.watch(modelItemsProvider(meta).notifier);

    return spec.when(
      data: (spec) {
        return RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              Future.delayed(const Duration(seconds: 1)),
              modelItemsNotifier.reload(),
            ]);
          },
          child: modelItems.when(
            notLoaded: () => const ProgressStatus(message: 'not loaded'),
            loading: (_) =>
                const ProgressStatus(message: 'loading model items'),
            loaded: (_, modelItems) => _buildTable(
              context,
              modelItems,
              spec,
              meta,
              modelItemsNotifier,
              footer: modelItems.paging.next != null
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: OutlinedButton(
                        child: Text('Load more'.i18n),
                        onPressed: () => {modelItemsNotifier.extend()},
                      ),
                    )
                  : null,
            ),
            reloading: (_, modelItems) => _buildTable(
              context,
              modelItems,
              spec,
              meta,
              modelItemsNotifier,
            ),
            extending: (_, modelItems) => _buildTable(
              context,
              modelItems,
              spec,
              meta,
              modelItemsNotifier,
              footer: const ProgressStatus(message: 'loading more items'),
            ),
            error: (error, _) {
              return ErrorActions(
                error,
                onRetry: () async => modelItemsNotifier.load(spec),
              );
            },
          ),
        );
      },
      loading: () => const ProgressStatus(message: 'loading model spec'),
      error: (error, stackTrace) {
        return ErrorActions(
          error,
          onRetry: () => ref.refresh(modelSpecProvider(meta)),
        );
      },
    );
  }

  Widget _buildTable(BuildContext context, ModelItems modelItems,
      ModelSpec spec, ModelMeta meta, ModelItemsNotifier modelItemsNotifier,
      {Widget? footer}) {
    if (modelItems.items.isNotEmpty) {
      return GestureDetector(
        onTap: () {
          _focusNode.requestFocus();
        },
        child: RawKeyboardListener(
          focusNode: _focusNode,
          onKey: (event) {
            if (event.runtimeType == RawKeyDownEvent &&
                [
                  LogicalKeyboardKey.controlLeft,
                  LogicalKeyboardKey.controlRight
                ].contains(event.logicalKey)) {
              setState(() {
                multiSelectMode = true;
              });
            }
            if (event.runtimeType == RawKeyUpEvent &&
                [
                  LogicalKeyboardKey.controlLeft,
                  LogicalKeyboardKey.controlRight
                ].contains(event.logicalKey)) {
              setState(() {
                multiSelectMode = false || selected.isNotEmpty;
              });
            }
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            // ensure scrolling is also enabled when list fits into parent to show refresh indicator on pull-on-top
            physics: const AlwaysScrollableScrollPhysics(),
            child: Scrollbar(
              controller: _scrollControllerHorizontal,
              interactive: true,
              isAlwaysShown: true,
              showTrackOnHover: true,
              scrollbarOrientation: ScrollbarOrientation.top,
              child: Column(
                children: [
                  SingleChildScrollView(
                    controller: _scrollControllerHorizontal,
                    scrollDirection: Axis.horizontal,
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          multiSelectMode = true;
                        });
                      },
                      child: DataTable(
                        showCheckboxColumn: multiSelectMode,
                        columns: spec.infos[meta]!.fieldInfos.values
                            .map(
                              (info) => DataColumn(
                                numeric: [IntegerInfo, FloatInfo]
                                    .contains(info.runtimeType),
                                label: Text(
                                  info.label,
                                ),
                              ),
                            )
                            .toList(growable: false),
                        rows: modelItems.items
                            .map<DataRow>((e) => _buildRow(context, e))
                            .toList(growable: false),
                      ),
                    ),
                  ),
                  if (footer != null)
                    Flexible(
                      flex: 0,
                      child: footer,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const Center(
        child: SizedBox(
          height: 20,
          child: Center(
            child: Text('No results found.'),
          ),
        ),
      );
    }
  }

  DataRow _buildRow(BuildContext context, ModelItem instance) {
    final dynamic idHashCode = instance.id?.value.hashCode;

    return DataRow(
      cells: instance.info.fieldInfos.entries
          .map<DataCell>((entry) =>
              _buildCell(context, entry.key, instance.fields[entry.key]))
          .toList(growable: false),
      selected: selected.contains(idHashCode),
      onSelectChanged: multiSelectMode
          ? idHashCode != null
              ? (value) {
                  setState(() {
                    if (idHashCode == null) {
                      return;
                    }
                    if (value ?? false) {
                      selected.add(idHashCode);
                    } else {
                      selected.remove(idHashCode);
                      if (selected.isEmpty) {
                        setState(() {
                          multiSelectMode = false;
                        });
                      }
                    }
                  });
                }
              : null
          : null,
    );
  }

  DataCell _buildCell(BuildContext context, String id, FieldValue? fieldValue) {
    if (fieldValue == null) {
      return const DataCell(
        Text(''),
      );
    }
    return fieldValue.info.map(
      string: (_) {
        final value = (fieldValue as StringValue).value;
        return DataCell(
          Text(value ?? ''),
        );
      },
      slug: (_) {
        final value = (fieldValue as SlugValue).value;
        return DataCell(
          Text(
            value ?? '',
            style: GoogleFonts.robotoMono(
              color: Colors.grey,
            ),
          ),
        );
      },
      boolean: (_) {
        final value = (fieldValue as BooleanValue).value;
        return DataCell(
          value != null
              ? value
                  ? Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                    )
                  : Icon(
                      Icons.remove_circle,
                      color: Theme.of(context).errorColor,
                    )
              : const Text(''),
        );
      },
      integer: (_) {
        final value = (fieldValue as IntegerValue).value;
        return DataCell(
          value != null ? Text(value.toString()) : const Text(''),
        );
      },
      float: (_) {
        final value = (fieldValue as FloatValue).value;
        return DataCell(
          value != null
              ? Text(value
                  .toStringAsFixed(value.truncateToDouble() == value ? 0 : 2))
              : const Text(''),
        );
      },
      datetime: (_) {
        final value = (fieldValue as DatetimeValue).value;
        return DataCell(
          value != null
              ? Column(children: [
                  Text(formatDate(value)),
                  Text(formatTimeOfDay(context, value)),
                ])
              : const Text(''),
        );
      },
      duration: (_) {
        final value = (fieldValue as DurationValue).value;
        return DataCell(
          Text(
            value != null ? formatDuration(value) : '',
          ),
        );
      },
      choice: (_) {
        final value = (fieldValue as ChoiceValue).value;
        return DataCell(
          Text(value ?? ''),
        );
      },
      relationalID: (_) {
        final value = (fieldValue as RelationalIDValue).value;
        return DataCell(
          Text(value?.toString() ?? ''),
        );
      },
      relationalContent: (_) {
        final value = (fieldValue as RelationalContentValue).value;
        return DataCell(
          Text(value?.info.meta.toString() ?? ''),
        );
      },
    );
  }
}

String formatDuration(Duration? duration) {
  if (duration == null) {
    return '';
  }
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
}

String formatDate(DateTime date) {
  return DateFormat.yMMMd().format(date);
}

String formatTimeOfDay(BuildContext context, DateTime date) {
  return MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(date),
      alwaysUse24HourFormat: true);
}

String formatDayOfWeek(DateTime date) {
  return DateFormat.E().format(date);
}
