///
//  Generated code. Do not modify.
//  source: proto/event.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
import 'paging.pbjson.dart' as $2;
import '../google/protobuf/timestamp.pbjson.dart' as $1;
import 'auth.pbjson.dart' as $0;

@$core.Deprecated('Use eventDescriptor instead')
const Event$json = const {
  '1': 'Event',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'id'},
    const {'1': 'instance', '3': 2, '4': 1, '5': 11, '6': '.Instance', '8': const {}, '10': 'instance'},
    const {'1': 'eventInfo', '3': 3, '4': 1, '5': 11, '6': '.Event.Info', '8': const {}, '10': 'eventInfo'},
    const {'1': 'starts', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '8': const {}, '10': 'starts'},
    const {'1': 'ends', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '8': const {}, '10': 'ends'},
    const {'1': 'workshops', '3': 6, '4': 3, '5': 11, '6': '.Workshop', '8': const {}, '10': 'workshops'},
  ],
  '3': const [Event_Info$json],
  '7': const {},
};

@$core.Deprecated('Use eventDescriptor instead')
const Event_Info$json = const {
  '1': 'Info',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'title'},
    const {'1': 'slug', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'slug'},
    const {'1': 'locationName', '3': 3, '4': 1, '5': 9, '8': const {}, '10': 'locationName'},
    const {'1': 'locationURL', '3': 4, '4': 1, '5': 9, '8': const {}, '10': 'locationURL'},
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode('CgVFdmVudBIaCgJpZBgBIAEoCUIKkrUYBloEEAEYFFICaWQSLwoIaW5zdGFuY2UYAiABKAsyCS5JbnN0YW5jZUIIkrUYBFoCCAFSCGluc3RhbmNlEjEKCWV2ZW50SW5mbxgDIAEoCzILLkV2ZW50LkluZm9CBpK1GAJKAFIJZXZlbnRJbmZvEjoKBnN0YXJ0cxgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCBpK1GAIyAFIGc3RhcnRzEjYKBGVuZHMYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wQgaStRgCMgBSBGVuZHMSLwoJd29ya3Nob3BzGAYgAygLMgkuV29ya3Nob3BCBpK1GAJSAFIJd29ya3Nob3BzGqMBCgRJbmZvEh8KBXRpdGxlGAEgASgJQgmStRgFWgMY/wFSBXRpdGxlEh4KBHNsdWcYAiABKAlCCpK1GAZaBBABGDJSBHNsdWcSLQoMbG9jYXRpb25OYW1lGAMgASgJQgmStRgFWgMY/wFSDGxvY2F0aW9uTmFtZRIrCgtsb2NhdGlvblVSTBgEIAEoCUIJkrUYBVoDGP8BUgtsb2NhdGlvblVSTDojgrUYHwoFZXZlbnQSBWV2ZW50GgVFdmVudCIGRXZlbnRzKAE=');
@$core.Deprecated('Use workshopDescriptor instead')
const Workshop$json = const {
  '1': 'Workshop',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'id'},
    const {'1': 'instance', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'instance'},
    const {'1': 'workshopInfo', '3': 3, '4': 1, '5': 11, '6': '.Workshop.Info', '8': const {}, '10': 'workshopInfo'},
    const {'1': 'starts', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '8': const {}, '10': 'starts'},
    const {'1': 'ends', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '8': const {}, '10': 'ends'},
    const {'1': 'event', '3': 6, '4': 1, '5': 11, '6': '.Event', '9': 0, '10': 'event'},
    const {'1': 'eventID', '3': 7, '4': 1, '5': 9, '9': 0, '10': 'eventID'},
  ],
  '3': const [Workshop_Info$json],
  '7': const {},
  '8': const [
    const {'1': 'belongsTo', '2': const {}},
  ],
};

@$core.Deprecated('Use workshopDescriptor instead')
const Workshop_Info$json = const {
  '1': 'Info',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'title'},
    const {'1': 'slug', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'slug'},
    const {'1': 'locationName', '3': 3, '4': 1, '5': 9, '8': const {}, '10': 'locationName'},
    const {'1': 'locationURL', '3': 4, '4': 1, '5': 9, '8': const {}, '10': 'locationURL'},
    const {'1': 'couples', '3': 5, '4': 1, '5': 8, '8': const {}, '10': 'couples'},
  ],
};

/// Descriptor for `Workshop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workshopDescriptor = $convert.base64Decode('CghXb3Jrc2hvcBIaCgJpZBgBIAEoCUIKkrUYBloEEAEYFFICaWQSJAoIaW5zdGFuY2UYAiABKAlCCJK1GARaAggBUghpbnN0YW5jZRI6Cgx3b3Jrc2hvcEluZm8YAyABKAsyDi5Xb3Jrc2hvcC5JbmZvQgaStRgCSgBSDHdvcmtzaG9wSW5mbxI6CgZzdGFydHMYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wQgaStRgCMgBSBnN0YXJ0cxI2CgRlbmRzGAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcEIGkrUYAjIAUgRlbmRzEh4KBWV2ZW50GAYgASgLMgYuRXZlbnRIAFIFZXZlbnQSGgoHZXZlbnRJRBgHIAEoCUgAUgdldmVudElEGscBCgRJbmZvEh8KBXRpdGxlGAEgASgJQgmStRgFWgMY/wFSBXRpdGxlEh4KBHNsdWcYAiABKAlCCpK1GAZaBBABGDJSBHNsdWcSLQoMbG9jYXRpb25OYW1lGAMgASgJQgmStRgFWgMY/wFSDGxvY2F0aW9uTmFtZRIrCgtsb2NhdGlvblVSTBgEIAEoCUIJkrUYBVoDGP8BUgtsb2NhdGlvblVSTBIiCgdjb3VwbGVzGAUgASgIQgiStRgEGgIIAVIHY291cGxlczovgrUYKwoId29ya3Nob3ASCHdvcmtzaG9wGghXb3Jrc2hvcCIJV29ya3Nob3BzKAFCFQoJYmVsb25nc1RvEgiatRgEUgIIAQ==');
@$core.Deprecated('Use workshopListDescriptor instead')
const WorkshopList$json = const {
  '1': 'WorkshopList',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.Workshop', '10': 'items'},
    const {'1': 'paging', '3': 2, '4': 1, '5': 11, '6': '.Paging', '10': 'paging'},
  ],
  '7': const {},
};

/// Descriptor for `WorkshopList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workshopListDescriptor = $convert.base64Decode('CgxXb3Jrc2hvcExpc3QSHwoFaXRlbXMYASADKAsyCS5Xb3Jrc2hvcFIFaXRlbXMSHwoGcGFnaW5nGAIgASgLMgcuUGFnaW5nUgZwYWdpbmc6Hoq1GBoKBWV2ZW50EgVldmVudBoKRXZlbnQgTGlzdA==');
const $core.Map<$core.String, $core.dynamic> EventServiceBase$json = const {
  '1': 'EventService',
  '2': const [
    const {'1': 'GetWorkshops', '2': '.Paging', '3': '.WorkshopList', '4': const {}},
    const {'1': 'CreateWorkshop', '2': '.Workshop', '3': '.Workshop', '4': const {}},
  ],
};

@$core.Deprecated('Use eventServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> EventServiceBase$messageJson = const {
  '.Paging': $2.Paging$json,
  '.Paging.Previous': $2.Paging_Previous$json,
  '.Paging.Current': $2.Paging_Current$json,
  '.Paging.Next': $2.Paging_Next$json,
  '.WorkshopList': WorkshopList$json,
  '.Workshop': Workshop$json,
  '.Workshop.Info': Workshop_Info$json,
  '.google.protobuf.Timestamp': $1.Timestamp$json,
  '.Event': Event$json,
  '.Instance': $0.Instance$json,
  '.Event.Info': Event_Info$json,
};

/// Descriptor for `EventService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List eventServiceDescriptor = $convert.base64Decode('CgxFdmVudFNlcnZpY2USKAoMR2V0V29ya3Nob3BzEgcuUGFnaW5nGg0uV29ya3Nob3BMaXN0IgASKAoOQ3JlYXRlV29ya3Nob3ASCS5Xb3Jrc2hvcBoJLldvcmtzaG9wIgA=');
