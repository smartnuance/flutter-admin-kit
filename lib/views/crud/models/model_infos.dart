import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_infos.freezed.dart';

@freezed
class ModelMeta with _$ModelMeta {
  factory ModelMeta({
    required String id,
    required String listAPI,
    required ModelInfo modelInfo,
  }) = _ModelMeta;

  const ModelMeta._();
}

@freezed
class ModelInfo with _$ModelInfo {
  factory ModelInfo({
    required String name,
    String? namePlural,
    @Default('') String? description,
    required Map<String, FieldInfo> fieldInfos,
    @Default('id') String? idField,
  }) = _ModelInfo;

  const ModelInfo._();

  factory ModelInfo.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for ModelInfo');
    }
    final name = data['name'] as String?;
    if (name == null) {
      throw StateError('missing name for ModelInfo');
    }
    final fields = data['fields'] as Map<String, dynamic>?;
    if (fields == null) {
      throw StateError('missing fields for ModelInfo');
    }
    final fieldInfos = fields.map((fieldName, dynamic m) =>
        MapEntry(fieldName, FieldInfo.fromMap(m as Map<String, dynamic>?)));
    return ModelInfo(
      name: name,
      namePlural: data['name_plural'] as String?,
      description: data['description'] as String?,
      fieldInfos: fieldInfos,
      idField: data['idField'] as String? ?? 'id',
    );
  }
}

enum FieldType {
  string,
  slug,
  boolean,
  integer,
  float,
  datetime,
  duration,
  choice,
  field,
}

@freezed
class FieldInfo with _$FieldInfo {
  factory FieldInfo.string({
    required String label,
    String? helpText,
    required bool required,
    required bool readOnly,
    int? maxLength,
  }) = StringInfo;
  factory FieldInfo.slug({
    required String label,
    String? helpText,
    required bool required,
    required bool readOnly,
    int? maxLength,
  }) = SlugInfo;
  factory FieldInfo.boolean({
    required String label,
    String? helpText,
    required bool required,
    required bool readOnly,
  }) = BooleanInfo;
  factory FieldInfo.integer({
    required String label,
    String? helpText,
    required bool required,
    required bool readOnly,
  }) = IntegerInfo;
  factory FieldInfo.float({
    required String label,
    String? helpText,
    required bool required,
    required bool readOnly,
  }) = FloatInfo;
  factory FieldInfo.datetime({
    required String label,
    String? helpText,
    required bool required,
    required bool readOnly,
  }) = DatetimeInfo;
  factory FieldInfo.duration({
    required String label,
    String? helpText,
    required bool required,
    required bool readOnly,
  }) = DurationInfo;
  factory FieldInfo.choice({
    required String label,
    String? helpText,
    required bool required,
    required bool readOnly,
  }) = ChoiceInfo;
  factory FieldInfo.relationalField({
    required String label,
    String? helpText,
    required bool required,
    required bool readOnly,
  }) = RelationalFieldInfo;

  const FieldInfo._();

  factory FieldInfo.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for FieldInfo');
    }
    final label = data['label'] as String?;
    if (label == null) {
      throw StateError('missing label for FieldInfo');
    }
    final typeStr = data['type'] as String?;
    if (typeStr == null) {
      throw StateError('missing type for FieldInfo');
    }
    final type = FieldType.values.firstWhere((e) => describeEnum(e) == typeStr,
        orElse: () {
      throw StateError('unknown field type $typeStr');
    });
    switch (type) {
      case FieldType.string:
        return FieldInfo.string(
          label: label,
          helpText: data['help_text'] as String?,
          required: data['required'] as bool? ?? false,
          readOnly: data['read_only'] as bool? ?? false,
          maxLength: data['max_length'] as int?,
        );
      case FieldType.slug:
        return FieldInfo.slug(
          label: label,
          helpText: data['help_text'] as String?,
          required: data['required'] as bool? ?? false,
          readOnly: data['read_only'] as bool? ?? false,
          maxLength: data['max_length'] as int?,
        );
      case FieldType.boolean:
        return FieldInfo.boolean(
          label: label,
          helpText: data['help_text'] as String?,
          required: data['required'] as bool? ?? false,
          readOnly: data['read_only'] as bool? ?? false,
        );
      case FieldType.integer:
        return FieldInfo.integer(
          label: label,
          helpText: data['help_text'] as String?,
          required: data['required'] as bool? ?? false,
          readOnly: data['read_only'] as bool? ?? false,
        );
      case FieldType.float:
        return FieldInfo.float(
          label: label,
          helpText: data['help_text'] as String?,
          required: data['required'] as bool? ?? false,
          readOnly: data['read_only'] as bool? ?? false,
        );
      case FieldType.datetime:
        return FieldInfo.datetime(
          label: label,
          helpText: data['help_text'] as String?,
          required: data['required'] as bool? ?? false,
          readOnly: data['read_only'] as bool? ?? false,
        );
      case FieldType.duration:
        return FieldInfo.duration(
          label: label,
          helpText: data['help_text'] as String?,
          required: data['required'] as bool? ?? false,
          readOnly: data['read_only'] as bool? ?? false,
        );
      case FieldType.choice:
        return FieldInfo.choice(
          label: label,
          helpText: data['help_text'] as String?,
          required: data['required'] as bool? ?? false,
          readOnly: data['read_only'] as bool? ?? false,
        );
      case FieldType.field:
        return FieldInfo.relationalField(
          label: label,
          helpText: data['help_text'] as String?,
          required: data['required'] as bool? ?? false,
          readOnly: data['read_only'] as bool? ?? false,
        );
    }
  }
}
