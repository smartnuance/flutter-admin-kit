import 'package:admin/common_widgets/error_actions.dart';
import 'package:admin/common_widgets/progress_status.dart';
import 'package:admin/views/crud/model_provider.dart';
import 'package:admin/views/crud/models/model_infos.dart';
import 'package:admin/views/crud/models/model_instance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ModelObjectList extends ConsumerWidget {
  const ModelObjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelInfo = ref.watch(modelInfoProvider('events/event'));

    return modelInfo.when(
      data: (modelInfo) {
        final modelList = ref.watch(modelListProvider('events/event'));
        return modelList.when(
          data: (instances) {
            return instances.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: modelInfo.fieldInfos.values
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
                      rows: instances
                          .map<DataRow>((e) => _buildRow(context, e))
                          .toList(growable: false),
                    ),
                  )
                : const Center(
                    child: SizedBox(
                      height: 20,
                      child: Center(
                        child: Text('No results found.'),
                      ),
                    ),
                  );
          },
          loading: () =>
              const ProgressStatus(message: 'loading model instances'),
          error: (error, stackTrace) {
            return ErrorActions(
              error,
              onRetry: () => ref.refresh(modelListProvider('events/event')),
            );
          },
        );
      },
      loading: () => const ProgressStatus(message: 'loading model info'),
      error: (error, stackTrace) {
        return ErrorActions(
          error,
          onRetry: () => ref.refresh(modelInfoProvider('events/event')),
        );
      },
    );
  }
}

DataRow _buildRow(BuildContext context, ModelInstance instance) {
  return DataRow(
      cells: instance.fields.entries
          .map<DataCell>(
            (entry) => _buildCell(context, entry.key, entry.value),
          )
          .toList(growable: false));
}

DataCell _buildCell(BuildContext context, String id, FieldValue fieldValue) {
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
    relationalField: (_) {
      final value = (fieldValue as RelationalFieldValue).value;
      return DataCell(
        Text(value?.toString() ?? ''),
      );
    },
  );
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
