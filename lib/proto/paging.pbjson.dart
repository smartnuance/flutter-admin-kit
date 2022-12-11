///
//  Generated code. Do not modify.
//  source: proto/paging.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use pageSpecDescriptor instead')
const PageSpec$json = const {
  '1': 'PageSpec',
  '2': const [
    const {'1': 'first', '3': 1, '4': 1, '5': 11, '6': '.Paging.First', '9': 0, '10': 'first'},
    const {'1': 'prev', '3': 2, '4': 1, '5': 11, '6': '.Paging.Previous', '9': 0, '10': 'prev'},
    const {'1': 'next', '3': 3, '4': 1, '5': 11, '6': '.Paging.Next', '9': 0, '10': 'next'},
    const {'1': 'cur', '3': 4, '4': 1, '5': 11, '6': '.Paging.Current', '9': 0, '10': 'cur'},
  ],
  '8': const [
    const {'1': 'page'},
  ],
};

/// Descriptor for `PageSpec`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pageSpecDescriptor = $convert.base64Decode('CghQYWdlU3BlYxIlCgVmaXJzdBgBIAEoCzINLlBhZ2luZy5GaXJzdEgAUgVmaXJzdBImCgRwcmV2GAIgASgLMhAuUGFnaW5nLlByZXZpb3VzSABSBHByZXYSIgoEbmV4dBgDIAEoCzIMLlBhZ2luZy5OZXh0SABSBG5leHQSIwoDY3VyGAQgASgLMg8uUGFnaW5nLkN1cnJlbnRIAFIDY3VyQgYKBHBhZ2U=');
@$core.Deprecated('Use pagingDescriptor instead')
const Paging$json = const {
  '1': 'Paging',
  '2': const [
    const {'1': 'prev', '3': 1, '4': 1, '5': 11, '6': '.Paging.Previous', '10': 'prev'},
    const {'1': 'cur', '3': 2, '4': 1, '5': 11, '6': '.Paging.Current', '10': 'cur'},
    const {'1': 'next', '3': 3, '4': 1, '5': 11, '6': '.Paging.Next', '10': 'next'},
  ],
  '3': const [Paging_First$json, Paging_Previous$json, Paging_Next$json, Paging_Current$json],
};

@$core.Deprecated('Use pagingDescriptor instead')
const Paging_First$json = const {
  '1': 'First',
  '2': const [
    const {'1': 'pageSize', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

@$core.Deprecated('Use pagingDescriptor instead')
const Paging_Previous$json = const {
  '1': 'Previous',
  '2': const [
    const {'1': 'end', '3': 1, '4': 1, '5': 9, '10': 'end'},
    const {'1': 'pageSize', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

@$core.Deprecated('Use pagingDescriptor instead')
const Paging_Next$json = const {
  '1': 'Next',
  '2': const [
    const {'1': 'start', '3': 1, '4': 1, '5': 9, '10': 'start'},
    const {'1': 'pageSize', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

@$core.Deprecated('Use pagingDescriptor instead')
const Paging_Current$json = const {
  '1': 'Current',
  '2': const [
    const {'1': 'start', '3': 1, '4': 1, '5': 9, '10': 'start'},
    const {'1': 'end', '3': 2, '4': 1, '5': 9, '10': 'end'},
    const {'1': 'pageSize', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `Paging`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pagingDescriptor = $convert.base64Decode('CgZQYWdpbmcSJAoEcHJldhgBIAEoCzIQLlBhZ2luZy5QcmV2aW91c1IEcHJldhIhCgNjdXIYAiABKAsyDy5QYWdpbmcuQ3VycmVudFIDY3VyEiAKBG5leHQYAyABKAsyDC5QYWdpbmcuTmV4dFIEbmV4dBojCgVGaXJzdBIaCghwYWdlU2l6ZRgBIAEoBVIIcGFnZVNpemUaOAoIUHJldmlvdXMSEAoDZW5kGAEgASgJUgNlbmQSGgoIcGFnZVNpemUYAiABKAVSCHBhZ2VTaXplGjgKBE5leHQSFAoFc3RhcnQYASABKAlSBXN0YXJ0EhoKCHBhZ2VTaXplGAIgASgFUghwYWdlU2l6ZRpNCgdDdXJyZW50EhQKBXN0YXJ0GAEgASgJUgVzdGFydBIQCgNlbmQYAiABKAlSA2VuZBIaCghwYWdlU2l6ZRgDIAEoBVIIcGFnZVNpemU=');
