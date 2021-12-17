import 'dart:convert';
import 'dart:io';

import 'package:admin/views/crud/models/model_infos.dart';
import 'package:admin/views/crud/models/model_instance.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class APIService {
  APIService(this.baseURI, this.tokenClient);

  final Uri baseURI;
  final http.Client tokenClient;

  Map<String, String> _headers() {
    return {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    };
  }

  Future<ModelSpec> fetchModelSpec(ModelMeta meta) async {
    final url = baseURI.resolve(p.join(meta.service, 'info', meta.model));
    final response = await tokenClient.get(
      url,
      headers: _headers(),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        return ModelSpec.fromMap(
            json.decode(response.body) as Map<String, dynamic>);
      case HttpStatus.unauthorized:
        throw NotAuthorizedException();
      case HttpStatus.forbidden:
        throw PermissionException();
      default:
        throw Exception(
            'Failed with status code ${response.statusCode} to retrieve model info from $url');
    }
  }

  Future<ModelItems> fetchItems(ModelSpec spec, ModelMeta meta,
      [PageSpec? page]) async {
    final url = baseURI
        .resolve(p.join(meta.service, meta.model, 'list'))
        .replace(queryParameters: page?.queryParams() ?? {});
    final response = await tokenClient.get(
      url,
      headers: _headers(),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        return ModelItems.fromMap(spec, meta, json.decode(response.body));
      case HttpStatus.unauthorized:
        throw NotAuthorizedException();
      case HttpStatus.forbidden:
        throw PermissionException();
      default:
        throw Exception(
            'Failed with status code ${response.statusCode} to retrieve model list from $url');
    }
  }

  Future<void> deleteItems(ModelMeta meta, Set<String> ids) async {
    for (final id in ids) {
      final url = baseURI.resolve(p.join(meta.service, meta.model, id));
      final response = await tokenClient.delete(
        url,
        headers: _headers(),
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
          continue;
        case HttpStatus.unauthorized:
          throw NotAuthorizedException();
        case HttpStatus.forbidden:
          throw PermissionException();
        default:
          throw Exception(
              'Failed with status code ${response.statusCode} to retrieve model list from $url');
      }
    }
  }
}

class NotAuthorizedException implements Exception {}

class PermissionException implements Exception {}
