///
//  Generated code. Do not modify.
//  source: proto/event.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'auth.pb.dart' as $0;
import '../google/protobuf/timestamp.pb.dart' as $1;
import 'paging.pb.dart' as $2;

class Event_Info extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Event.Info', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'slug')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locationName', protoName: 'locationName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locationURL', protoName: 'locationURL')
    ..hasRequiredFields = false
  ;

  Event_Info._() : super();
  factory Event_Info({
    $core.String? title,
    $core.String? slug,
    $core.String? locationName,
    $core.String? locationURL,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (slug != null) {
      _result.slug = slug;
    }
    if (locationName != null) {
      _result.locationName = locationName;
    }
    if (locationURL != null) {
      _result.locationURL = locationURL;
    }
    return _result;
  }
  factory Event_Info.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Event_Info.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Event_Info clone() => Event_Info()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Event_Info copyWith(void Function(Event_Info) updates) => super.copyWith((message) => updates(message as Event_Info)) as Event_Info; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Event_Info create() => Event_Info._();
  Event_Info createEmptyInstance() => create();
  static $pb.PbList<Event_Info> createRepeated() => $pb.PbList<Event_Info>();
  @$core.pragma('dart2js:noInline')
  static Event_Info getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event_Info>(create);
  static Event_Info? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get slug => $_getSZ(1);
  @$pb.TagNumber(2)
  set slug($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSlug() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlug() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get locationName => $_getSZ(2);
  @$pb.TagNumber(3)
  set locationName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocationName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocationName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get locationURL => $_getSZ(3);
  @$pb.TagNumber(4)
  set locationURL($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLocationURL() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocationURL() => clearField(4);
}

class Event extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Event', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<$0.Instance>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'instance', subBuilder: $0.Instance.create)
    ..aOM<Event_Info>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'eventInfo', protoName: 'eventInfo', subBuilder: Event_Info.create)
    ..aOM<$1.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'starts', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ends', subBuilder: $1.Timestamp.create)
    ..pc<Workshop>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workshops', $pb.PbFieldType.PM, subBuilder: Workshop.create)
    ..hasRequiredFields = false
  ;

  Event._() : super();
  factory Event({
    $core.String? id,
    $0.Instance? instance,
    Event_Info? eventInfo,
    $1.Timestamp? starts,
    $1.Timestamp? ends,
    $core.Iterable<Workshop>? workshops,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (instance != null) {
      _result.instance = instance;
    }
    if (eventInfo != null) {
      _result.eventInfo = eventInfo;
    }
    if (starts != null) {
      _result.starts = starts;
    }
    if (ends != null) {
      _result.ends = ends;
    }
    if (workshops != null) {
      _result.workshops.addAll(workshops);
    }
    return _result;
  }
  factory Event.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Event.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Event clone() => Event()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Event copyWith(void Function(Event) updates) => super.copyWith((message) => updates(message as Event)) as Event; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Event create() => Event._();
  Event createEmptyInstance() => create();
  static $pb.PbList<Event> createRepeated() => $pb.PbList<Event>();
  @$core.pragma('dart2js:noInline')
  static Event getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event>(create);
  static Event? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $0.Instance get instance => $_getN(1);
  @$pb.TagNumber(2)
  set instance($0.Instance v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasInstance() => $_has(1);
  @$pb.TagNumber(2)
  void clearInstance() => clearField(2);
  @$pb.TagNumber(2)
  $0.Instance ensureInstance() => $_ensure(1);

  @$pb.TagNumber(3)
  Event_Info get eventInfo => $_getN(2);
  @$pb.TagNumber(3)
  set eventInfo(Event_Info v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEventInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventInfo() => clearField(3);
  @$pb.TagNumber(3)
  Event_Info ensureEventInfo() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Timestamp get starts => $_getN(3);
  @$pb.TagNumber(4)
  set starts($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStarts() => $_has(3);
  @$pb.TagNumber(4)
  void clearStarts() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureStarts() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Timestamp get ends => $_getN(4);
  @$pb.TagNumber(5)
  set ends($1.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEnds() => $_has(4);
  @$pb.TagNumber(5)
  void clearEnds() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureEnds() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.List<Workshop> get workshops => $_getList(5);
}

class Workshop_Info extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Workshop.Info', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'slug')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locationName', protoName: 'locationName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locationURL', protoName: 'locationURL')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'couples')
    ..hasRequiredFields = false
  ;

  Workshop_Info._() : super();
  factory Workshop_Info({
    $core.String? title,
    $core.String? slug,
    $core.String? locationName,
    $core.String? locationURL,
    $core.bool? couples,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (slug != null) {
      _result.slug = slug;
    }
    if (locationName != null) {
      _result.locationName = locationName;
    }
    if (locationURL != null) {
      _result.locationURL = locationURL;
    }
    if (couples != null) {
      _result.couples = couples;
    }
    return _result;
  }
  factory Workshop_Info.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Workshop_Info.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Workshop_Info clone() => Workshop_Info()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Workshop_Info copyWith(void Function(Workshop_Info) updates) => super.copyWith((message) => updates(message as Workshop_Info)) as Workshop_Info; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Workshop_Info create() => Workshop_Info._();
  Workshop_Info createEmptyInstance() => create();
  static $pb.PbList<Workshop_Info> createRepeated() => $pb.PbList<Workshop_Info>();
  @$core.pragma('dart2js:noInline')
  static Workshop_Info getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Workshop_Info>(create);
  static Workshop_Info? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get slug => $_getSZ(1);
  @$pb.TagNumber(2)
  set slug($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSlug() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlug() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get locationName => $_getSZ(2);
  @$pb.TagNumber(3)
  set locationName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocationName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocationName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get locationURL => $_getSZ(3);
  @$pb.TagNumber(4)
  set locationURL($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLocationURL() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocationURL() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get couples => $_getBF(4);
  @$pb.TagNumber(5)
  set couples($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCouples() => $_has(4);
  @$pb.TagNumber(5)
  void clearCouples() => clearField(5);
}

enum Workshop_BelongsTo {
  event, 
  eventID, 
  notSet
}

class Workshop extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Workshop_BelongsTo> _Workshop_BelongsToByTag = {
    6 : Workshop_BelongsTo.event,
    7 : Workshop_BelongsTo.eventID,
    0 : Workshop_BelongsTo.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Workshop', createEmptyInstance: create)
    ..oo(0, [6, 7])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'instance')
    ..aOM<Workshop_Info>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workshopInfo', protoName: 'workshopInfo', subBuilder: Workshop_Info.create)
    ..aOM<$1.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'starts', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ends', subBuilder: $1.Timestamp.create)
    ..aOM<Event>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'event', subBuilder: Event.create)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'eventID', protoName: 'eventID')
    ..hasRequiredFields = false
  ;

  Workshop._() : super();
  factory Workshop({
    $core.String? id,
    $core.String? instance,
    Workshop_Info? workshopInfo,
    $1.Timestamp? starts,
    $1.Timestamp? ends,
    Event? event,
    $core.String? eventID,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (instance != null) {
      _result.instance = instance;
    }
    if (workshopInfo != null) {
      _result.workshopInfo = workshopInfo;
    }
    if (starts != null) {
      _result.starts = starts;
    }
    if (ends != null) {
      _result.ends = ends;
    }
    if (event != null) {
      _result.event = event;
    }
    if (eventID != null) {
      _result.eventID = eventID;
    }
    return _result;
  }
  factory Workshop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Workshop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Workshop clone() => Workshop()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Workshop copyWith(void Function(Workshop) updates) => super.copyWith((message) => updates(message as Workshop)) as Workshop; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Workshop create() => Workshop._();
  Workshop createEmptyInstance() => create();
  static $pb.PbList<Workshop> createRepeated() => $pb.PbList<Workshop>();
  @$core.pragma('dart2js:noInline')
  static Workshop getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Workshop>(create);
  static Workshop? _defaultInstance;

  Workshop_BelongsTo whichBelongsTo() => _Workshop_BelongsToByTag[$_whichOneof(0)]!;
  void clearBelongsTo() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get instance => $_getSZ(1);
  @$pb.TagNumber(2)
  set instance($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInstance() => $_has(1);
  @$pb.TagNumber(2)
  void clearInstance() => clearField(2);

  @$pb.TagNumber(3)
  Workshop_Info get workshopInfo => $_getN(2);
  @$pb.TagNumber(3)
  set workshopInfo(Workshop_Info v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasWorkshopInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearWorkshopInfo() => clearField(3);
  @$pb.TagNumber(3)
  Workshop_Info ensureWorkshopInfo() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Timestamp get starts => $_getN(3);
  @$pb.TagNumber(4)
  set starts($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStarts() => $_has(3);
  @$pb.TagNumber(4)
  void clearStarts() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureStarts() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Timestamp get ends => $_getN(4);
  @$pb.TagNumber(5)
  set ends($1.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEnds() => $_has(4);
  @$pb.TagNumber(5)
  void clearEnds() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureEnds() => $_ensure(4);

  @$pb.TagNumber(6)
  Event get event => $_getN(5);
  @$pb.TagNumber(6)
  set event(Event v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasEvent() => $_has(5);
  @$pb.TagNumber(6)
  void clearEvent() => clearField(6);
  @$pb.TagNumber(6)
  Event ensureEvent() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get eventID => $_getSZ(6);
  @$pb.TagNumber(7)
  set eventID($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEventID() => $_has(6);
  @$pb.TagNumber(7)
  void clearEventID() => clearField(7);
}

class WorkshopList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WorkshopList', createEmptyInstance: create)
    ..pc<Workshop>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: Workshop.create)
    ..aOM<$2.Paging>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paging', subBuilder: $2.Paging.create)
    ..hasRequiredFields = false
  ;

  WorkshopList._() : super();
  factory WorkshopList({
    $core.Iterable<Workshop>? items,
    $2.Paging? paging,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    if (paging != null) {
      _result.paging = paging;
    }
    return _result;
  }
  factory WorkshopList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkshopList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WorkshopList clone() => WorkshopList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WorkshopList copyWith(void Function(WorkshopList) updates) => super.copyWith((message) => updates(message as WorkshopList)) as WorkshopList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkshopList create() => WorkshopList._();
  WorkshopList createEmptyInstance() => create();
  static $pb.PbList<WorkshopList> createRepeated() => $pb.PbList<WorkshopList>();
  @$core.pragma('dart2js:noInline')
  static WorkshopList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkshopList>(create);
  static WorkshopList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Workshop> get items => $_getList(0);

  @$pb.TagNumber(2)
  $2.Paging get paging => $_getN(1);
  @$pb.TagNumber(2)
  set paging($2.Paging v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaging() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaging() => clearField(2);
  @$pb.TagNumber(2)
  $2.Paging ensurePaging() => $_ensure(1);
}

class EventServiceApi {
  $pb.RpcClient _client;
  EventServiceApi(this._client);

  $async.Future<WorkshopList> getWorkshops($pb.ClientContext? ctx, $2.Paging request) {
    var emptyResponse = WorkshopList();
    return _client.invoke<WorkshopList>(ctx, 'EventService', 'GetWorkshops', request, emptyResponse);
  }
  $async.Future<Workshop> createWorkshop($pb.ClientContext? ctx, Workshop request) {
    var emptyResponse = Workshop();
    return _client.invoke<Workshop>(ctx, 'EventService', 'CreateWorkshop', request, emptyResponse);
  }
}

