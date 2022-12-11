///
//  Generated code. Do not modify.
//  source: proto/paging.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

enum PageSpec_Page {
  first, 
  prev, 
  next, 
  cur, 
  notSet
}

class PageSpec extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, PageSpec_Page> _PageSpec_PageByTag = {
    1 : PageSpec_Page.first,
    2 : PageSpec_Page.prev,
    3 : PageSpec_Page.next,
    4 : PageSpec_Page.cur,
    0 : PageSpec_Page.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PageSpec', createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<Paging_First>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'first', subBuilder: Paging_First.create)
    ..aOM<Paging_Previous>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'prev', subBuilder: Paging_Previous.create)
    ..aOM<Paging_Next>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'next', subBuilder: Paging_Next.create)
    ..aOM<Paging_Current>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cur', subBuilder: Paging_Current.create)
    ..hasRequiredFields = false
  ;

  PageSpec._() : super();
  factory PageSpec({
    Paging_First? first,
    Paging_Previous? prev,
    Paging_Next? next,
    Paging_Current? cur,
  }) {
    final _result = create();
    if (first != null) {
      _result.first = first;
    }
    if (prev != null) {
      _result.prev = prev;
    }
    if (next != null) {
      _result.next = next;
    }
    if (cur != null) {
      _result.cur = cur;
    }
    return _result;
  }
  factory PageSpec.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PageSpec.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PageSpec clone() => PageSpec()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PageSpec copyWith(void Function(PageSpec) updates) => super.copyWith((message) => updates(message as PageSpec)) as PageSpec; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PageSpec create() => PageSpec._();
  PageSpec createEmptyInstance() => create();
  static $pb.PbList<PageSpec> createRepeated() => $pb.PbList<PageSpec>();
  @$core.pragma('dart2js:noInline')
  static PageSpec getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PageSpec>(create);
  static PageSpec? _defaultInstance;

  PageSpec_Page whichPage() => _PageSpec_PageByTag[$_whichOneof(0)]!;
  void clearPage() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Paging_First get first => $_getN(0);
  @$pb.TagNumber(1)
  set first(Paging_First v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFirst() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirst() => clearField(1);
  @$pb.TagNumber(1)
  Paging_First ensureFirst() => $_ensure(0);

  @$pb.TagNumber(2)
  Paging_Previous get prev => $_getN(1);
  @$pb.TagNumber(2)
  set prev(Paging_Previous v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPrev() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrev() => clearField(2);
  @$pb.TagNumber(2)
  Paging_Previous ensurePrev() => $_ensure(1);

  @$pb.TagNumber(3)
  Paging_Next get next => $_getN(2);
  @$pb.TagNumber(3)
  set next(Paging_Next v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasNext() => $_has(2);
  @$pb.TagNumber(3)
  void clearNext() => clearField(3);
  @$pb.TagNumber(3)
  Paging_Next ensureNext() => $_ensure(2);

  @$pb.TagNumber(4)
  Paging_Current get cur => $_getN(3);
  @$pb.TagNumber(4)
  set cur(Paging_Current v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCur() => $_has(3);
  @$pb.TagNumber(4)
  void clearCur() => clearField(4);
  @$pb.TagNumber(4)
  Paging_Current ensureCur() => $_ensure(3);
}

class Paging_First extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paging.First', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3, protoName: 'pageSize')
    ..hasRequiredFields = false
  ;

  Paging_First._() : super();
  factory Paging_First({
    $core.int? pageSize,
  }) {
    final _result = create();
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory Paging_First.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paging_First.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paging_First clone() => Paging_First()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paging_First copyWith(void Function(Paging_First) updates) => super.copyWith((message) => updates(message as Paging_First)) as Paging_First; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paging_First create() => Paging_First._();
  Paging_First createEmptyInstance() => create();
  static $pb.PbList<Paging_First> createRepeated() => $pb.PbList<Paging_First>();
  @$core.pragma('dart2js:noInline')
  static Paging_First getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paging_First>(create);
  static Paging_First? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => clearField(1);
}

class Paging_Previous extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paging.Previous', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'end')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3, protoName: 'pageSize')
    ..hasRequiredFields = false
  ;

  Paging_Previous._() : super();
  factory Paging_Previous({
    $core.String? end,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (end != null) {
      _result.end = end;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory Paging_Previous.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paging_Previous.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paging_Previous clone() => Paging_Previous()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paging_Previous copyWith(void Function(Paging_Previous) updates) => super.copyWith((message) => updates(message as Paging_Previous)) as Paging_Previous; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paging_Previous create() => Paging_Previous._();
  Paging_Previous createEmptyInstance() => create();
  static $pb.PbList<Paging_Previous> createRepeated() => $pb.PbList<Paging_Previous>();
  @$core.pragma('dart2js:noInline')
  static Paging_Previous getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paging_Previous>(create);
  static Paging_Previous? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get end => $_getSZ(0);
  @$pb.TagNumber(1)
  set end($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEnd() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnd() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);
}

class Paging_Next extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paging.Next', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'start')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3, protoName: 'pageSize')
    ..hasRequiredFields = false
  ;

  Paging_Next._() : super();
  factory Paging_Next({
    $core.String? start,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (start != null) {
      _result.start = start;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory Paging_Next.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paging_Next.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paging_Next clone() => Paging_Next()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paging_Next copyWith(void Function(Paging_Next) updates) => super.copyWith((message) => updates(message as Paging_Next)) as Paging_Next; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paging_Next create() => Paging_Next._();
  Paging_Next createEmptyInstance() => create();
  static $pb.PbList<Paging_Next> createRepeated() => $pb.PbList<Paging_Next>();
  @$core.pragma('dart2js:noInline')
  static Paging_Next getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paging_Next>(create);
  static Paging_Next? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get start => $_getSZ(0);
  @$pb.TagNumber(1)
  set start($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);
}

class Paging_Current extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paging.Current', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'start')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'end')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3, protoName: 'pageSize')
    ..hasRequiredFields = false
  ;

  Paging_Current._() : super();
  factory Paging_Current({
    $core.String? start,
    $core.String? end,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (start != null) {
      _result.start = start;
    }
    if (end != null) {
      _result.end = end;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory Paging_Current.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paging_Current.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paging_Current clone() => Paging_Current()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paging_Current copyWith(void Function(Paging_Current) updates) => super.copyWith((message) => updates(message as Paging_Current)) as Paging_Current; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paging_Current create() => Paging_Current._();
  Paging_Current createEmptyInstance() => create();
  static $pb.PbList<Paging_Current> createRepeated() => $pb.PbList<Paging_Current>();
  @$core.pragma('dart2js:noInline')
  static Paging_Current getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paging_Current>(create);
  static Paging_Current? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get start => $_getSZ(0);
  @$pb.TagNumber(1)
  set start($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get end => $_getSZ(1);
  @$pb.TagNumber(2)
  set end($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => clearField(3);
}

class Paging extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paging', createEmptyInstance: create)
    ..aOM<Paging_Previous>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'prev', subBuilder: Paging_Previous.create)
    ..aOM<Paging_Current>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cur', subBuilder: Paging_Current.create)
    ..aOM<Paging_Next>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'next', subBuilder: Paging_Next.create)
    ..hasRequiredFields = false
  ;

  Paging._() : super();
  factory Paging({
    Paging_Previous? prev,
    Paging_Current? cur,
    Paging_Next? next,
  }) {
    final _result = create();
    if (prev != null) {
      _result.prev = prev;
    }
    if (cur != null) {
      _result.cur = cur;
    }
    if (next != null) {
      _result.next = next;
    }
    return _result;
  }
  factory Paging.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paging.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paging clone() => Paging()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paging copyWith(void Function(Paging) updates) => super.copyWith((message) => updates(message as Paging)) as Paging; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paging create() => Paging._();
  Paging createEmptyInstance() => create();
  static $pb.PbList<Paging> createRepeated() => $pb.PbList<Paging>();
  @$core.pragma('dart2js:noInline')
  static Paging getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paging>(create);
  static Paging? _defaultInstance;

  @$pb.TagNumber(1)
  Paging_Previous get prev => $_getN(0);
  @$pb.TagNumber(1)
  set prev(Paging_Previous v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPrev() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrev() => clearField(1);
  @$pb.TagNumber(1)
  Paging_Previous ensurePrev() => $_ensure(0);

  @$pb.TagNumber(2)
  Paging_Current get cur => $_getN(1);
  @$pb.TagNumber(2)
  set cur(Paging_Current v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCur() => $_has(1);
  @$pb.TagNumber(2)
  void clearCur() => clearField(2);
  @$pb.TagNumber(2)
  Paging_Current ensureCur() => $_ensure(1);

  @$pb.TagNumber(3)
  Paging_Next get next => $_getN(2);
  @$pb.TagNumber(3)
  set next(Paging_Next v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasNext() => $_has(2);
  @$pb.TagNumber(3)
  void clearNext() => clearField(3);
  @$pb.TagNumber(3)
  Paging_Next ensureNext() => $_ensure(2);
}

