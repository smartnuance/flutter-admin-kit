///
//  Generated code. Do not modify.
//  source: proto/spec.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ModelInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ModelInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spec'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'service')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'labelPlural', protoName: 'labelPlural')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idField', $pb.PbFieldType.OU3, protoName: 'idField')
    ..hasRequiredFields = false
  ;

  ModelInfo._() : super();
  factory ModelInfo({
    $core.String? name,
    $core.String? service,
    $core.String? label,
    $core.String? labelPlural,
    $core.int? idField,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (service != null) {
      _result.service = service;
    }
    if (label != null) {
      _result.label = label;
    }
    if (labelPlural != null) {
      _result.labelPlural = labelPlural;
    }
    if (idField != null) {
      _result.idField = idField;
    }
    return _result;
  }
  factory ModelInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ModelInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ModelInfo clone() => ModelInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ModelInfo copyWith(void Function(ModelInfo) updates) => super.copyWith((message) => updates(message as ModelInfo)) as ModelInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ModelInfo create() => ModelInfo._();
  ModelInfo createEmptyInstance() => create();
  static $pb.PbList<ModelInfo> createRepeated() => $pb.PbList<ModelInfo>();
  @$core.pragma('dart2js:noInline')
  static ModelInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ModelInfo>(create);
  static ModelInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get service => $_getSZ(1);
  @$pb.TagNumber(2)
  set service($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasService() => $_has(1);
  @$pb.TagNumber(2)
  void clearService() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get label => $_getSZ(2);
  @$pb.TagNumber(3)
  set label($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLabel() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get labelPlural => $_getSZ(3);
  @$pb.TagNumber(4)
  set labelPlural($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLabelPlural() => $_has(3);
  @$pb.TagNumber(4)
  void clearLabelPlural() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get idField => $_getIZ(4);
  @$pb.TagNumber(5)
  set idField($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdField() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdField() => clearField(5);
}

class ModelListInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ModelListInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spec'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'service')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..hasRequiredFields = false
  ;

  ModelListInfo._() : super();
  factory ModelListInfo({
    $core.String? name,
    $core.String? service,
    $core.String? label,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (service != null) {
      _result.service = service;
    }
    if (label != null) {
      _result.label = label;
    }
    return _result;
  }
  factory ModelListInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ModelListInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ModelListInfo clone() => ModelListInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ModelListInfo copyWith(void Function(ModelListInfo) updates) => super.copyWith((message) => updates(message as ModelListInfo)) as ModelListInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ModelListInfo create() => ModelListInfo._();
  ModelListInfo createEmptyInstance() => create();
  static $pb.PbList<ModelListInfo> createRepeated() => $pb.PbList<ModelListInfo>();
  @$core.pragma('dart2js:noInline')
  static ModelListInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ModelListInfo>(create);
  static ModelListInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get service => $_getSZ(1);
  @$pb.TagNumber(2)
  set service($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasService() => $_has(1);
  @$pb.TagNumber(2)
  void clearService() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get label => $_getSZ(2);
  @$pb.TagNumber(3)
  set label($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLabel() => clearField(3);
}

enum FieldInfo_Type {
  bool_3, 
  integer, 
  float, 
  datetime, 
  duration, 
  content, 
  relational, 
  string, 
  slug, 
  notSet
}

class FieldInfo extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, FieldInfo_Type> _FieldInfo_TypeByTag = {
    3 : FieldInfo_Type.bool_3,
    4 : FieldInfo_Type.integer,
    5 : FieldInfo_Type.float,
    6 : FieldInfo_Type.datetime,
    7 : FieldInfo_Type.duration,
    9 : FieldInfo_Type.content,
    10 : FieldInfo_Type.relational,
    11 : FieldInfo_Type.string,
    12 : FieldInfo_Type.slug,
    0 : FieldInfo_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FieldInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spec'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6, 7, 9, 10, 11, 12])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'labelPlural', protoName: 'labelPlural')
    ..aOM<SingleFieldInfo>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bool', subBuilder: SingleFieldInfo.create)
    ..aOM<SingleFieldInfo>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'integer', subBuilder: SingleFieldInfo.create)
    ..aOM<SingleFieldInfo>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'float', subBuilder: SingleFieldInfo.create)
    ..aOM<SingleFieldInfo>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'datetime', subBuilder: SingleFieldInfo.create)
    ..aOM<SingleFieldInfo>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'duration', subBuilder: SingleFieldInfo.create)
    ..aOM<SingleFieldInfo>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content', subBuilder: SingleFieldInfo.create)
    ..aOM<SingleFieldInfo>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'relational', subBuilder: SingleFieldInfo.create)
    ..aOM<StringFieldInfo>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'string', subBuilder: StringFieldInfo.create)
    ..aOM<StringFieldInfo>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'slug', subBuilder: StringFieldInfo.create)
    ..hasRequiredFields = false
  ;

  FieldInfo._() : super();
  factory FieldInfo({
    $core.String? label,
    $core.String? labelPlural,
    SingleFieldInfo? bool_3,
    SingleFieldInfo? integer,
    SingleFieldInfo? float,
    SingleFieldInfo? datetime,
    SingleFieldInfo? duration,
    SingleFieldInfo? content,
    SingleFieldInfo? relational,
    StringFieldInfo? string,
    StringFieldInfo? slug,
  }) {
    final _result = create();
    if (label != null) {
      _result.label = label;
    }
    if (labelPlural != null) {
      _result.labelPlural = labelPlural;
    }
    if (bool_3 != null) {
      _result.bool_3 = bool_3;
    }
    if (integer != null) {
      _result.integer = integer;
    }
    if (float != null) {
      _result.float = float;
    }
    if (datetime != null) {
      _result.datetime = datetime;
    }
    if (duration != null) {
      _result.duration = duration;
    }
    if (content != null) {
      _result.content = content;
    }
    if (relational != null) {
      _result.relational = relational;
    }
    if (string != null) {
      _result.string = string;
    }
    if (slug != null) {
      _result.slug = slug;
    }
    return _result;
  }
  factory FieldInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FieldInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FieldInfo clone() => FieldInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FieldInfo copyWith(void Function(FieldInfo) updates) => super.copyWith((message) => updates(message as FieldInfo)) as FieldInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FieldInfo create() => FieldInfo._();
  FieldInfo createEmptyInstance() => create();
  static $pb.PbList<FieldInfo> createRepeated() => $pb.PbList<FieldInfo>();
  @$core.pragma('dart2js:noInline')
  static FieldInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FieldInfo>(create);
  static FieldInfo? _defaultInstance;

  FieldInfo_Type whichType() => _FieldInfo_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get labelPlural => $_getSZ(1);
  @$pb.TagNumber(2)
  set labelPlural($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabelPlural() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabelPlural() => clearField(2);

  @$pb.TagNumber(3)
  SingleFieldInfo get bool_3 => $_getN(2);
  @$pb.TagNumber(3)
  set bool_3(SingleFieldInfo v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasBool_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearBool_3() => clearField(3);
  @$pb.TagNumber(3)
  SingleFieldInfo ensureBool_3() => $_ensure(2);

  @$pb.TagNumber(4)
  SingleFieldInfo get integer => $_getN(3);
  @$pb.TagNumber(4)
  set integer(SingleFieldInfo v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasInteger() => $_has(3);
  @$pb.TagNumber(4)
  void clearInteger() => clearField(4);
  @$pb.TagNumber(4)
  SingleFieldInfo ensureInteger() => $_ensure(3);

  @$pb.TagNumber(5)
  SingleFieldInfo get float => $_getN(4);
  @$pb.TagNumber(5)
  set float(SingleFieldInfo v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFloat() => $_has(4);
  @$pb.TagNumber(5)
  void clearFloat() => clearField(5);
  @$pb.TagNumber(5)
  SingleFieldInfo ensureFloat() => $_ensure(4);

  @$pb.TagNumber(6)
  SingleFieldInfo get datetime => $_getN(5);
  @$pb.TagNumber(6)
  set datetime(SingleFieldInfo v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDatetime() => $_has(5);
  @$pb.TagNumber(6)
  void clearDatetime() => clearField(6);
  @$pb.TagNumber(6)
  SingleFieldInfo ensureDatetime() => $_ensure(5);

  @$pb.TagNumber(7)
  SingleFieldInfo get duration => $_getN(6);
  @$pb.TagNumber(7)
  set duration(SingleFieldInfo v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDuration() => $_has(6);
  @$pb.TagNumber(7)
  void clearDuration() => clearField(7);
  @$pb.TagNumber(7)
  SingleFieldInfo ensureDuration() => $_ensure(6);

  @$pb.TagNumber(9)
  SingleFieldInfo get content => $_getN(7);
  @$pb.TagNumber(9)
  set content(SingleFieldInfo v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasContent() => $_has(7);
  @$pb.TagNumber(9)
  void clearContent() => clearField(9);
  @$pb.TagNumber(9)
  SingleFieldInfo ensureContent() => $_ensure(7);

  @$pb.TagNumber(10)
  SingleFieldInfo get relational => $_getN(8);
  @$pb.TagNumber(10)
  set relational(SingleFieldInfo v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasRelational() => $_has(8);
  @$pb.TagNumber(10)
  void clearRelational() => clearField(10);
  @$pb.TagNumber(10)
  SingleFieldInfo ensureRelational() => $_ensure(8);

  @$pb.TagNumber(11)
  StringFieldInfo get string => $_getN(9);
  @$pb.TagNumber(11)
  set string(StringFieldInfo v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasString() => $_has(9);
  @$pb.TagNumber(11)
  void clearString() => clearField(11);
  @$pb.TagNumber(11)
  StringFieldInfo ensureString() => $_ensure(9);

  @$pb.TagNumber(12)
  StringFieldInfo get slug => $_getN(10);
  @$pb.TagNumber(12)
  set slug(StringFieldInfo v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasSlug() => $_has(10);
  @$pb.TagNumber(12)
  void clearSlug() => clearField(12);
  @$pb.TagNumber(12)
  StringFieldInfo ensureSlug() => $_ensure(10);
}

class SingleFieldInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SingleFieldInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spec'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'required')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'readOnly', protoName: 'readOnly')
    ..hasRequiredFields = false
  ;

  SingleFieldInfo._() : super();
  factory SingleFieldInfo({
    $core.bool? required,
    $core.bool? readOnly,
  }) {
    final _result = create();
    if (required != null) {
      _result.required = required;
    }
    if (readOnly != null) {
      _result.readOnly = readOnly;
    }
    return _result;
  }
  factory SingleFieldInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SingleFieldInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SingleFieldInfo clone() => SingleFieldInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SingleFieldInfo copyWith(void Function(SingleFieldInfo) updates) => super.copyWith((message) => updates(message as SingleFieldInfo)) as SingleFieldInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SingleFieldInfo create() => SingleFieldInfo._();
  SingleFieldInfo createEmptyInstance() => create();
  static $pb.PbList<SingleFieldInfo> createRepeated() => $pb.PbList<SingleFieldInfo>();
  @$core.pragma('dart2js:noInline')
  static SingleFieldInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SingleFieldInfo>(create);
  static SingleFieldInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get required => $_getBF(0);
  @$pb.TagNumber(1)
  set required($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequired() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequired() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get readOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set readOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReadOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearReadOnly() => clearField(2);
}

class StringFieldInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StringFieldInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spec'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'required')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'readOnly', protoName: 'readOnly')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxLength', $pb.PbFieldType.OU3, protoName: 'maxLength')
    ..hasRequiredFields = false
  ;

  StringFieldInfo._() : super();
  factory StringFieldInfo({
    $core.bool? required,
    $core.bool? readOnly,
    $core.int? maxLength,
  }) {
    final _result = create();
    if (required != null) {
      _result.required = required;
    }
    if (readOnly != null) {
      _result.readOnly = readOnly;
    }
    if (maxLength != null) {
      _result.maxLength = maxLength;
    }
    return _result;
  }
  factory StringFieldInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StringFieldInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StringFieldInfo clone() => StringFieldInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StringFieldInfo copyWith(void Function(StringFieldInfo) updates) => super.copyWith((message) => updates(message as StringFieldInfo)) as StringFieldInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StringFieldInfo create() => StringFieldInfo._();
  StringFieldInfo createEmptyInstance() => create();
  static $pb.PbList<StringFieldInfo> createRepeated() => $pb.PbList<StringFieldInfo>();
  @$core.pragma('dart2js:noInline')
  static StringFieldInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StringFieldInfo>(create);
  static StringFieldInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get required => $_getBF(0);
  @$pb.TagNumber(1)
  set required($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequired() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequired() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get readOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set readOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReadOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearReadOnly() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get maxLength => $_getIZ(2);
  @$pb.TagNumber(3)
  set maxLength($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMaxLength() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxLength() => clearField(3);
}

class RelationalContent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RelationalContent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'spec'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'required')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'readOnly', protoName: 'readOnly')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'service')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'model')
    ..hasRequiredFields = false
  ;

  RelationalContent._() : super();
  factory RelationalContent({
    $core.bool? required,
    $core.bool? readOnly,
    $core.String? service,
    $core.String? model,
  }) {
    final _result = create();
    if (required != null) {
      _result.required = required;
    }
    if (readOnly != null) {
      _result.readOnly = readOnly;
    }
    if (service != null) {
      _result.service = service;
    }
    if (model != null) {
      _result.model = model;
    }
    return _result;
  }
  factory RelationalContent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RelationalContent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RelationalContent clone() => RelationalContent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RelationalContent copyWith(void Function(RelationalContent) updates) => super.copyWith((message) => updates(message as RelationalContent)) as RelationalContent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RelationalContent create() => RelationalContent._();
  RelationalContent createEmptyInstance() => create();
  static $pb.PbList<RelationalContent> createRepeated() => $pb.PbList<RelationalContent>();
  @$core.pragma('dart2js:noInline')
  static RelationalContent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RelationalContent>(create);
  static RelationalContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get required => $_getBF(0);
  @$pb.TagNumber(1)
  set required($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequired() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequired() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get readOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set readOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReadOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearReadOnly() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get service => $_getSZ(2);
  @$pb.TagNumber(3)
  set service($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasService() => $_has(2);
  @$pb.TagNumber(3)
  void clearService() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get model => $_getSZ(3);
  @$pb.TagNumber(4)
  set model($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasModel() => $_has(3);
  @$pb.TagNumber(4)
  void clearModel() => clearField(4);
}

class Spec {
  static final model = $pb.Extension<ModelInfo>(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'google.protobuf.MessageOptions', const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'model', 50000, $pb.PbFieldType.OM, defaultOrMaker: ModelInfo.getDefault, subBuilder: ModelInfo.create);
  static final modelList = $pb.Extension<ModelInfo>(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'google.protobuf.MessageOptions', const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'modelList', 50001, $pb.PbFieldType.OM, defaultOrMaker: ModelInfo.getDefault, subBuilder: ModelInfo.create);
  static final field_50002 = $pb.Extension<FieldInfo>(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'google.protobuf.FieldOptions', const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'field_50002', 50002, $pb.PbFieldType.OM, defaultOrMaker: FieldInfo.getDefault, subBuilder: FieldInfo.create);
  static final choices = $pb.Extension<FieldInfo>(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'google.protobuf.OneofOptions', const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'choices', 50003, $pb.PbFieldType.OM, defaultOrMaker: FieldInfo.getDefault, subBuilder: FieldInfo.create);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(model);
    registry.add(modelList);
    registry.add(field_50002);
    registry.add(choices);
  }
}

