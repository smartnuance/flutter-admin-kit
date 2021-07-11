import 'package:admin/views/crud/models/model_infos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_instance.freezed.dart';

@freezed
class ModelInstance with _$ModelInstance {
  factory ModelInstance({
    required ModelInfo info,
    @Default({}) Map<String, FieldValue> fields,
  }) = _ModelInstance;

  const ModelInstance._();

  factory ModelInstance.fromMap(ModelInfo info, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for ModelInstance');
    }
    final fields = <String, FieldValue>{};
    data.forEach((fieldName, dynamic m) {
      final fieldInfos = info.fieldInfos[fieldName];
      if (fieldInfos == null) {
        throw StateError(
            'encountered unknown field in ModelInstance not described in infos');
      }
      fields[fieldName] = FieldValue.fromMap(fieldInfos, m);
    });
    return ModelInstance(
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

  factory FieldValue.fromMap(FieldInfo info, dynamic data) {
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
      relationalField: (info) =>
          RelationalFieldValue(info: info, value: data as int?),
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
class RelationalFieldValue extends FieldValue with _$RelationalFieldValue {
  factory RelationalFieldValue(
      {required RelationalFieldInfo info, int? value}) = _RelationalFieldValue;

  const RelationalFieldValue._();
}
