import 'package:admin/views/crud/models/model_infos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_instance.freezed.dart';

@freezed
class InfiniteList with _$InfiniteList {
  factory InfiniteList.notLoaded() = _NotLoadedInfiniteList;

  factory InfiniteList.loading({required ModelSpec modelSpec}) =
      _LoadingInfiniteList;

  factory InfiniteList.loaded({
    required ModelSpec modelSpec,
    required ModelItems modelItems,
  }) = _LoadedInfiniteList;

  factory InfiniteList.reloading({
    required ModelSpec modelSpec,
    required ModelItems modelItems,
  }) = _ReloadingInfiniteList;

  factory InfiniteList.extending({
    required ModelSpec modelSpec,
    required ModelItems modelItems,
  }) = _ExtendingInfiniteList;

  factory InfiniteList.error(Object error, [StackTrace? stackTrace]) =
      _ErrorInfiniteList;

  InfiniteList._();
}

@freezed
class PageSpec with _$PageSpec {
  factory PageSpec({
    String? start,
    String? end,
    required int pageSize,
  }) = _PageSpec;

  const PageSpec._();

  factory PageSpec.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for PageSpec');
    }

    return PageSpec(
      start: data['start'],
      end: data['end'],
      pageSize: data['size'],
    );
  }

  Map<String, String> queryParams() {
    final p = <String, String>{
      'l': pageSize.toString(),
    };

    if (start != null) {
      p['s'] = start!;
    }
    if (end != null) {
      p['e'] = end!;
    }
    return p;
  }

  PageSpec extend(PageSpec right) => PageSpec(
        start: start,
        end: right.end,
        pageSize: pageSize + right.pageSize,
      );
}

@freezed
class Paging with _$Paging {
  factory Paging({
    PageSpec? previous,
    required PageSpec current,
    PageSpec? next,
  }) = _Paging;

  const Paging._();

  factory Paging.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for Paging');
    }

    if (data['cur'] == null) {
      throw StateError('missing paging.current');
    }

    return Paging(
      previous: data['prev'] != null ? PageSpec.fromMap(data['prev']) : null,
      current: PageSpec.fromMap(data['cur']),
      next: data['next'] != null ? PageSpec.fromMap(data['next']) : null,
    );
  }
}

@freezed
class ModelItems with _$ModelItems {
  factory ModelItems({
    required List<ModelItem> items,
    required Paging paging,
  }) = _ModelItems;

  const ModelItems._();

  factory ModelItems.fromMap(
      ModelSpec spec, ModelMeta meta, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for ModelItems');
    }

    return ModelItems(
      items: List.from(data['items'] as List<dynamic>)
          .map<ModelItem>((dynamic m) => ModelItem.fromMap(spec, meta, m))
          .toList(growable: false),
      paging: Paging.fromMap(data['paging']),
    );
  }
}

@freezed
class ModelItem with _$ModelItem {
  factory ModelItem({
    required ModelInfo info,
    @Default({}) Map<String, FieldValue> fields,
  }) = _ModelItem;

  const ModelItem._();

  FieldValue? get id => fields[info.idField];

  factory ModelItem.fromMap(
      ModelSpec spec, ModelMeta meta, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for ModelItem');
    }
    final info = spec.infos[meta];
    if (info == null) {
      throw StateError('missing model info in spec for ModelItem');
    }

    final fields = <String, FieldValue>{};
    data.forEach((fieldName, dynamic m) {
      final fieldInfos = info.fieldInfos[fieldName];
      if (fieldInfos == null) {
        throw StateError(
            'encountered unknown field $fieldName in ModelItem not described in infos');
      }
      fields[fieldName] = FieldValue.fromMap(spec, fieldInfos, m);
    });
    return ModelItem(
      info: info,
      fields: fields,
    );
  }
}

@immutable
abstract class FieldValue {
  const FieldValue();

  FieldInfo get info;

  dynamic get value;

  factory FieldValue.fromMap(ModelSpec spec, FieldInfo info, dynamic data) {
    if (data == null) {
      if (info.required) {
        throw StateError('missing data of required field "${info.label}"');
      }
    }
    return info.map(
      string: (info) => StringValue(info: info, value: data as String?),
      slug: (info) => SlugValue(info: info, value: data as String?),
      boolean: (info) => BooleanValue(info: info, value: data as bool?),
      integer: (info) => IntegerValue(info: info, value: data as int?),
      float: (info) => FloatValue(info: info, value: data as num?),
      datetime: (info) => DatetimeValue.fromString(info, data as String?),
      duration: (info) => DurationValue.fromString(info, data as String?),
      choice: (info) => ChoiceValue(info: info, value: data as String?),
      relationalID: (info) =>
          RelationalIDValue(info: info, value: data as String?),
      relationalContent: (info) => RelationalContentValue(
          info: info, value: ModelItem.fromMap(spec, info.meta, data)),
    );
  }
}

@freezed
class StringValue extends FieldValue with _$StringValue {
  factory StringValue({required StringInfo info, String? value}) = _StringValue;

  const StringValue._();
}

@freezed
class SlugValue extends FieldValue with _$SlugValue {
  factory SlugValue({required SlugInfo info, String? value}) = _SlugValue;

  const SlugValue._();
}

@freezed
class BooleanValue extends FieldValue with _$BooleanValue {
  factory BooleanValue({required BooleanInfo info, bool? value}) =
      _BooleanValue;

  const BooleanValue._();
}

@freezed
class IntegerValue extends FieldValue with _$IntegerValue {
  factory IntegerValue({required IntegerInfo info, int? value}) = _IntegerValue;

  const IntegerValue._();
}

@freezed
class FloatValue extends FieldValue with _$FloatValue {
  factory FloatValue({required FloatInfo info, num? value}) = _FloatValue;

  const FloatValue._();
}

@freezed
class DatetimeValue extends FieldValue with _$DatetimeValue {
  factory DatetimeValue({required DatetimeInfo info, DateTime? value}) =
      _DatetimeValue;

  const DatetimeValue._();

  factory DatetimeValue.fromString(DatetimeInfo info, String? data) {
    return DatetimeValue(
      info: info,
      value: data != null ? DateTime.parse(data) : null,
    );
  }
}

@freezed
class DurationValue extends FieldValue with _$DurationValue {
  factory DurationValue({required DurationInfo info, Duration? value}) =
      _DurationValue;

  const DurationValue._();

  factory DurationValue.fromString(DurationInfo info, String? data) {
    return DurationValue(
        info: info, value: data != null ? parseDuration(data) : null);
  }

  static Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    final List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}

@freezed
class ChoiceValue extends FieldValue with _$ChoiceValue {
  factory ChoiceValue({required ChoiceInfo info, String? value}) = _ChoiceValue;

  const ChoiceValue._();
}

@freezed
class RelationalIDValue extends FieldValue with _$RelationalIDValue {
  factory RelationalIDValue({required RelationalID info, String? value}) =
      _RelationalIDValue;

  const RelationalIDValue._();
}

@freezed
class RelationalContentValue extends FieldValue with _$RelationalContentValue {
  factory RelationalContentValue(
      {required RelationalContent info,
      ModelItem? value}) = _RelationalContentValue;

  const RelationalContentValue._();
}
