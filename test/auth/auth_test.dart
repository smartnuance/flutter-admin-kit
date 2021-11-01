import 'dart:convert';
import 'dart:io';

import 'package:admin/views/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Parse', () {
    test('parse TokenPair', () async {
      final file = File('test/auth/loginResponse.json');
      final jsonStr = await file.readAsString();
      final tokens = TokenPair.fromMap(json.decode(jsonStr));
      expect(tokens.access, 'accessDummy');
      expect(tokens.refresh, 'refreshDummy');

      tokens.toMap();
      expect(tokens.toMap(), json.decode(jsonStr));
    });
  });
}
