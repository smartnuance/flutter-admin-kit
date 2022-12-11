///
//  Generated code. Do not modify.
//  source: proto/event.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'paging.pb.dart' as $2;
import 'event.pb.dart' as $3;
import 'event.pbjson.dart';

export 'event.pb.dart';

abstract class EventServiceBase extends $pb.GeneratedService {
  $async.Future<$3.WorkshopList> getWorkshops($pb.ServerContext ctx, $2.Paging request);
  $async.Future<$3.Workshop> createWorkshop($pb.ServerContext ctx, $3.Workshop request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'GetWorkshops': return $2.Paging();
      case 'CreateWorkshop': return $3.Workshop();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'GetWorkshops': return this.getWorkshops(ctx, request as $2.Paging);
      case 'CreateWorkshop': return this.createWorkshop(ctx, request as $3.Workshop);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => EventServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => EventServiceBase$messageJson;
}

