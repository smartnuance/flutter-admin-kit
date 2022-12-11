///
//  Generated code. Do not modify.
//  source: proto/auth.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Role extends $pb.ProtobufEnum {
  static const Role NO_ROLE = Role._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NO_ROLE');
  static const Role ROLE_SUPER_ADMIN = Role._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROLE_SUPER_ADMIN');
  static const Role ROLE_INSTANCE_ADMIN = Role._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROLE_INSTANCE_ADMIN');
  static const Role ROLE_EVENT_ORGANIZER = Role._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROLE_EVENT_ORGANIZER');
  static const Role ROLE_TEACHER = Role._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROLE_TEACHER');

  static const $core.List<Role> values = <Role> [
    NO_ROLE,
    ROLE_SUPER_ADMIN,
    ROLE_INSTANCE_ADMIN,
    ROLE_EVENT_ORGANIZER,
    ROLE_TEACHER,
  ];

  static final $core.Map<$core.int, Role> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Role? valueOf($core.int value) => _byValue[value];

  const Role._($core.int v, $core.String n) : super(v, n);
}

