import 'dart:convert';
import 'dart:io';

import 'package:admin/views/crud/models/model_infos.dart';
import 'package:admin/views/crud/models/model_instance.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Parse', () {
    test('parse ModelInfo', () async {
      final file = File('test/crud/modelInfo.json');
      final jsonStr = await file.readAsString();
      final modelInfo = ModelInfo.fromMap(json.decode(jsonStr));
      expect(modelInfo.name, 'Event');
      expect(modelInfo.namePlural, 'Events');
    });

    test('parse ModelInstance', () async {
      final ModelInfo modelInfo;
      {
        final file = File('test/crud/modelInfo.json');
        final jsonStr = await file.readAsString();
        modelInfo = ModelInfo.fromMap(json.decode(jsonStr));
      }

      {
        final file = File('test/crud/modelInstance.json');
        final jsonStr = await file.readAsString();
        final modelInstance =
            ModelInstance.fromMap(modelInfo, json.decode(jsonStr));
        expect(modelInstance.fields['name']?.value, 'Bachata');
      }
    });
  });
}
