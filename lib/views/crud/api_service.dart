import 'dart:convert';
import 'dart:io';

import 'package:admin/views/crud/models/model_infos.dart';
import 'package:admin/views/crud/models/model_instance.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class APIService {
  APIService(this.tokenClient);

  final http.Client tokenClient;
  final Uri baseURI = Uri.parse('http://localhost:8000/a/api/');
  final Uri tokenURI = Uri.parse('http://localhost:8000/a/token/');

  Map<String, String> _headers() {
    return {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    };
  }

  Future<ModelInfo> retrieveModelInfo(String modelPath) async {
    final url = baseURI.resolve(p.join(modelPath, 'info/'));
    final response = await tokenClient.get(
      url,
      headers: _headers(),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        return ModelInfo.fromMap(
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

  Future<Iterable<ModelInstance>> retrieveList(
      ModelInfo info, String modelPath) async {
    final url = baseURI.resolve(modelPath);
    final response = await tokenClient.get(
      url,
      headers: _headers(),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        return List<Map<String, dynamic>>.from(json.decode(response.body))
            .map<ModelInstance>((m) => ModelInstance.fromMap(info, m));
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

class NotAuthorizedException implements Exception {}

class PermissionException implements Exception {}
