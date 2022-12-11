///
//  Generated code. Do not modify.
//  source: proto/spec.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use modelInfoDescriptor instead')
const ModelInfo$json = const {
  '1': 'ModelInfo',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'service', '3': 2, '4': 1, '5': 9, '10': 'service'},
    const {'1': 'label', '3': 3, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'labelPlural', '3': 4, '4': 1, '5': 9, '10': 'labelPlural'},
    const {'1': 'idField', '3': 5, '4': 1, '5': 13, '10': 'idField'},
  ],
};

/// Descriptor for `ModelInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List modelInfoDescriptor = $convert.base64Decode('CglNb2RlbEluZm8SEgoEbmFtZRgBIAEoCVIEbmFtZRIYCgdzZXJ2aWNlGAIgASgJUgdzZXJ2aWNlEhQKBWxhYmVsGAMgASgJUgVsYWJlbBIgCgtsYWJlbFBsdXJhbBgEIAEoCVILbGFiZWxQbHVyYWwSGAoHaWRGaWVsZBgFIAEoDVIHaWRGaWVsZA==');
@$core.Deprecated('Use modelListInfoDescriptor instead')
const ModelListInfo$json = const {
  '1': 'ModelListInfo',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'service', '3': 2, '4': 1, '5': 9, '10': 'service'},
    const {'1': 'label', '3': 3, '4': 1, '5': 9, '10': 'label'},
  ],
};

/// Descriptor for `ModelListInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List modelListInfoDescriptor = $convert.base64Decode('Cg1Nb2RlbExpc3RJbmZvEhIKBG5hbWUYASABKAlSBG5hbWUSGAoHc2VydmljZRgCIAEoCVIHc2VydmljZRIUCgVsYWJlbBgDIAEoCVIFbGFiZWw=');
@$core.Deprecated('Use fieldInfoDescriptor instead')
const FieldInfo$json = const {
  '1': 'FieldInfo',
  '2': const [
    const {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'labelPlural', '3': 2, '4': 1, '5': 9, '10': 'labelPlural'},
    const {'1': 'bool', '3': 3, '4': 1, '5': 11, '6': '.spec.SingleFieldInfo', '9': 0, '10': 'bool'},
    const {'1': 'integer', '3': 4, '4': 1, '5': 11, '6': '.spec.SingleFieldInfo', '9': 0, '10': 'integer'},
    const {'1': 'float', '3': 5, '4': 1, '5': 11, '6': '.spec.SingleFieldInfo', '9': 0, '10': 'float'},
    const {'1': 'datetime', '3': 6, '4': 1, '5': 11, '6': '.spec.SingleFieldInfo', '9': 0, '10': 'datetime'},
    const {'1': 'duration', '3': 7, '4': 1, '5': 11, '6': '.spec.SingleFieldInfo', '9': 0, '10': 'duration'},
    const {'1': 'content', '3': 9, '4': 1, '5': 11, '6': '.spec.SingleFieldInfo', '9': 0, '10': 'content'},
    const {'1': 'relational', '3': 10, '4': 1, '5': 11, '6': '.spec.SingleFieldInfo', '9': 0, '10': 'relational'},
    const {'1': 'string', '3': 11, '4': 1, '5': 11, '6': '.spec.StringFieldInfo', '9': 0, '10': 'string'},
    const {'1': 'slug', '3': 12, '4': 1, '5': 11, '6': '.spec.StringFieldInfo', '9': 0, '10': 'slug'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `FieldInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fieldInfoDescriptor = $convert.base64Decode('CglGaWVsZEluZm8SFAoFbGFiZWwYASABKAlSBWxhYmVsEiAKC2xhYmVsUGx1cmFsGAIgASgJUgtsYWJlbFBsdXJhbBIrCgRib29sGAMgASgLMhUuc3BlYy5TaW5nbGVGaWVsZEluZm9IAFIEYm9vbBIxCgdpbnRlZ2VyGAQgASgLMhUuc3BlYy5TaW5nbGVGaWVsZEluZm9IAFIHaW50ZWdlchItCgVmbG9hdBgFIAEoCzIVLnNwZWMuU2luZ2xlRmllbGRJbmZvSABSBWZsb2F0EjMKCGRhdGV0aW1lGAYgASgLMhUuc3BlYy5TaW5nbGVGaWVsZEluZm9IAFIIZGF0ZXRpbWUSMwoIZHVyYXRpb24YByABKAsyFS5zcGVjLlNpbmdsZUZpZWxkSW5mb0gAUghkdXJhdGlvbhIxCgdjb250ZW50GAkgASgLMhUuc3BlYy5TaW5nbGVGaWVsZEluZm9IAFIHY29udGVudBI3CgpyZWxhdGlvbmFsGAogASgLMhUuc3BlYy5TaW5nbGVGaWVsZEluZm9IAFIKcmVsYXRpb25hbBIvCgZzdHJpbmcYCyABKAsyFS5zcGVjLlN0cmluZ0ZpZWxkSW5mb0gAUgZzdHJpbmcSKwoEc2x1ZxgMIAEoCzIVLnNwZWMuU3RyaW5nRmllbGRJbmZvSABSBHNsdWdCBgoEdHlwZQ==');
@$core.Deprecated('Use singleFieldInfoDescriptor instead')
const SingleFieldInfo$json = const {
  '1': 'SingleFieldInfo',
  '2': const [
    const {'1': 'required', '3': 1, '4': 1, '5': 8, '10': 'required'},
    const {'1': 'readOnly', '3': 2, '4': 1, '5': 8, '10': 'readOnly'},
  ],
};

/// Descriptor for `SingleFieldInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List singleFieldInfoDescriptor = $convert.base64Decode('Cg9TaW5nbGVGaWVsZEluZm8SGgoIcmVxdWlyZWQYASABKAhSCHJlcXVpcmVkEhoKCHJlYWRPbmx5GAIgASgIUghyZWFkT25seQ==');
@$core.Deprecated('Use stringFieldInfoDescriptor instead')
const StringFieldInfo$json = const {
  '1': 'StringFieldInfo',
  '2': const [
    const {'1': 'required', '3': 1, '4': 1, '5': 8, '10': 'required'},
    const {'1': 'readOnly', '3': 2, '4': 1, '5': 8, '10': 'readOnly'},
    const {'1': 'maxLength', '3': 3, '4': 1, '5': 13, '10': 'maxLength'},
  ],
};

/// Descriptor for `StringFieldInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stringFieldInfoDescriptor = $convert.base64Decode('Cg9TdHJpbmdGaWVsZEluZm8SGgoIcmVxdWlyZWQYASABKAhSCHJlcXVpcmVkEhoKCHJlYWRPbmx5GAIgASgIUghyZWFkT25seRIcCgltYXhMZW5ndGgYAyABKA1SCW1heExlbmd0aA==');
@$core.Deprecated('Use relationalContentDescriptor instead')
const RelationalContent$json = const {
  '1': 'RelationalContent',
  '2': const [
    const {'1': 'required', '3': 1, '4': 1, '5': 8, '10': 'required'},
    const {'1': 'readOnly', '3': 2, '4': 1, '5': 8, '10': 'readOnly'},
    const {'1': 'service', '3': 3, '4': 1, '5': 9, '10': 'service'},
    const {'1': 'model', '3': 4, '4': 1, '5': 9, '10': 'model'},
  ],
};

/// Descriptor for `RelationalContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List relationalContentDescriptor = $convert.base64Decode('ChFSZWxhdGlvbmFsQ29udGVudBIaCghyZXF1aXJlZBgBIAEoCFIIcmVxdWlyZWQSGgoIcmVhZE9ubHkYAiABKAhSCHJlYWRPbmx5EhgKB3NlcnZpY2UYAyABKAlSB3NlcnZpY2USFAoFbW9kZWwYBCABKAlSBW1vZGVs');
