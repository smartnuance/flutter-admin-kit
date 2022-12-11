///
//  Generated code. Do not modify.
//  source: proto/auth.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use roleDescriptor instead')
const Role$json = const {
  '1': 'Role',
  '2': const [
    const {'1': 'NO_ROLE', '2': 0},
    const {'1': 'ROLE_SUPER_ADMIN', '2': 1},
    const {'1': 'ROLE_INSTANCE_ADMIN', '2': 2},
    const {'1': 'ROLE_EVENT_ORGANIZER', '2': 3},
    const {'1': 'ROLE_TEACHER', '2': 4},
  ],
};

/// Descriptor for `Role`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roleDescriptor = $convert.base64Decode('CgRSb2xlEgsKB05PX1JPTEUQABIUChBST0xFX1NVUEVSX0FETUlOEAESFwoTUk9MRV9JTlNUQU5DRV9BRE1JThACEhgKFFJPTEVfRVZFTlRfT1JHQU5JWkVSEAMSEAoMUk9MRV9URUFDSEVSEAQ=');
@$core.Deprecated('Use instanceDescriptor instead')
const Instance$json = const {
  '1': 'Instance',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'URL', '3': 3, '4': 1, '5': 9, '10': 'URL'},
  ],
};

/// Descriptor for `Instance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instanceDescriptor = $convert.base64Decode('CghJbnN0YW5jZRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIQCgNVUkwYAyABKAlSA1VSTA==');
