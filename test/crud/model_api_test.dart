import 'dart:convert';
import 'dart:io';

import 'package:admin/views/crud/models/model_infos.dart';
import 'package:admin/views/crud/models/model_instance.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Parse', () {
    test('parse ModelInfo', () async {
      final file = File('test/crud/modelSpecs.json');
      final jsonStr = await file.readAsString();
      final spec = ModelSpec.fromMap(json.decode(jsonStr));
      print(spec.infos.keys);
      expect(spec.infos[ModelMeta(service: 'event', model: 'workshop')]?.name,
          'Workshop');
      expect(
          spec.infos[ModelMeta(service: 'event', model: 'workshop')]
              ?.namePlural,
          'Workshops');
      expect(spec.infos[ModelMeta(service: 'event', model: 'event')]?.name,
          'Event');
      expect(
          spec.infos[ModelMeta(service: 'event', model: 'event')]?.namePlural,
          'Events');
    });

    test('parse ModelInstance', () async {
      final ModelSpec spec;
      {
        final file = File('test/crud/modelSpecs.json');
        final jsonStr = await file.readAsString();
        spec = ModelSpec.fromMap(json.decode(jsonStr));
      }

      {
        final file = File('test/crud/modelInstance.json');
        final jsonStr = await file.readAsString();
        final modelInstance = ModelInstance.fromMap(
            spec,
            ModelMeta(service: 'event', model: 'workshop'),
            json.decode(jsonStr));
        expect(modelInstance.fields['title']?.value, 'Salsa');
      }
    });
  });
}
