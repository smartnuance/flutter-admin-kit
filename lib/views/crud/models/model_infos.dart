import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_infos.freezed.dart';

@freezed
class ModelMeta with _$ModelMeta {
  factory ModelMeta({
    required String service,
    required String model,
  }) = _ModelMeta;

  const ModelMeta._();

  factory ModelMeta.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for ModelMeta');
    }
    final service = data['service'] as String?;
    if (service == null) {
      throw StateError('missing service for ModelMeta');
    }
    final model = data['model'] as String?;
    if (model == null) {
      throw StateError('missing model for ModelMeta');
    }
    return ModelMeta(
      service: service,
      model: model,
    );
  }
}

@freezed
class ModelSpec with _$ModelSpec {
  factory ModelSpec({
    required Map<ModelMeta, ModelInfo> infos,
  }) = _ModelSpec;

  const ModelSpec._();

  factory ModelSpec.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for ModelSpec');
    }
    final infos = data['infos'] as List<dynamic>?;
    if (infos == null) {
      throw StateError('missing infos for ModelSpec');
    }
    final infosList = infos
        .map<ModelInfo>((dynamic modelData) =>
            ModelInfo.fromMap(modelData as Map<String, dynamic>?))
        .toList(growable: false);
    return ModelSpec(
      infos: Map<ModelMeta, ModelInfo>.fromIterable(
        infosList,
        key: (dynamic info) => (info as ModelInfo).meta,
      ),
    );
  }
}

@freezed
class ModelInfo with _$ModelInfo {
  factory ModelInfo({
    required ModelMeta meta,
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
      meta: ModelMeta.fromMap(data),
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
  relationalID,
  relationalContent,
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
  factory FieldInfo.relationalID({
    required String label,
    String? helpText,
    required bool required,
    required bool readOnly,
    required ModelMeta meta,
  }) = RelationalID;
  factory FieldInfo.relationalContent({
    required String label,
    String? helpText,
    required bool required,
    required bool readOnly,
    required ModelMeta meta,
  }) = RelationalContent;

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
      case FieldType.relationalID:
        final service = data['service'] as String?;
        if (service == null) {
          throw StateError('missing service for FieldInfo with type==$typeStr');
        }
        final model = data['model'] as String?;
        if (model == null) {
          throw StateError('missing model for FieldInfo with type==$typeStr');
        }
        return FieldInfo.relationalID(
          label: label,
          helpText: data['help_text'] as String?,
          required: data['required'] as bool? ?? false,
          readOnly: data['read_only'] as bool? ?? false,
          meta: ModelMeta.fromMap(data),
        );
      case FieldType.relationalContent:
        final service = data['service'] as String?;
        if (service == null) {
          throw StateError('missing service for FieldInfo with type==$typeStr');
        }
        final model = data['model'] as String?;
        if (model == null) {
          throw StateError('missing model for FieldInfo with type==$typeStr');
        }
        return FieldInfo.relationalContent(
          label: label,
          helpText: data['help_text'] as String?,
          required: data['required'] as bool? ?? false,
          readOnly: data['read_only'] as bool? ?? false,
          meta: ModelMeta.fromMap(data),
        );
    }
  }
}
