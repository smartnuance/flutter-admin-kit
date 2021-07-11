import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:admin/views/auth/auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  AuthService(this.unauthClient);

  final http.Client unauthClient;
  final Uri baseURI = Uri.parse('http://localhost:8000/a/token/');

  Map<String, String> _headers() {
    return {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    };
  }

  Future<TokenPair> signIn(String username, String password) async {
    final url = baseURI;
    final response = await unauthClient.post(
      url,
      headers: _headers(),
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == HttpStatus.ok) {
      final bodyJson = json.decode(response.body) as Map<String, dynamic>;
      final refreshToken = bodyJson['refresh'] as String?;
      final accessToken = bodyJson['access'] as String?;
      if (refreshToken == null) {
        throw Exception(
            'Did not found refresh token in response to successful login call to $url');
      }
      if (accessToken == null) {
        throw Exception(
            'Did not found access token in response to successful login call to $url');
      }
      return TokenPair(refresh: refreshToken, access: accessToken);
    } else {
      throw Exception(
          'Failed with status code ${response.statusCode} to login $url');
    }
  }

  Future<TokenPair> refreshTokens(TokenPair tokens) async {
    final url = baseURI.resolve('refresh/');
    final response = await unauthClient.post(
      url,
      headers: _headers(),
      body: json.encode(<String, String>{
        'refresh': tokens.refresh,
      }),
    );
    if (response.statusCode == HttpStatus.ok) {
      final bodyJson = json.decode(response.body) as Map<String, dynamic>;
      final newAccessToken = bodyJson['access'] as String?;
      if (newAccessToken == null) {
        throw Exception(
            'Did not found access token in successful token refresh call to $url');
      }

      final newTokens = tokens.copyWith(access: newAccessToken);
      developer.log('refreshed tokens: ${newTokens.toString()}');
      return newTokens;
    } else {
      throw Exception(
          'Failed with status code ${response.statusCode} to refresh token via $url');
    }
  }
}
