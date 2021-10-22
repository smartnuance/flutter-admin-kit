import 'dart:developer' as developer;

import 'package:admin/views/crud/api_provider.dart';
import 'package:admin/views/crud/models/model_infos.dart';
import 'package:admin/views/crud/models/model_instance.dart';
import 'package:admin/views/messages/message_model.dart';
import 'package:admin/views/messages/message_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final modelInfoProvider =
    FutureProvider.autoDispose.family<ModelInfo, ModelMeta>((ref, meta) async {
  final apiService = ref.watch(apiServiceProvider);
  final ModelInfo modelInfo;
  try {
    modelInfo = await apiService.retrieveModelInfo(meta);
  } catch (error, stackTrace) {
    developer.log(
      'retrieveModelInfo',
      error: error,
      stackTrace: stackTrace,
    );
    ref.read(messagesProvider.notifier).publish(Message(
          text: 'Error loading model info.',
          error: error,
          stackTrace: stackTrace,
        ));
    return Future.error(error);
  }
  return modelInfo;
});

final modelListProvider = StreamProvider.autoDispose
    .family<List<ModelInstance>, ModelMeta>((ref, meta) async* {
  final apiService = ref.watch(apiServiceProvider);
  final modelInfo = await ref.watch(modelInfoProvider(meta).future);
  try {
    final list = List<ModelInstance>.from(
        await apiService.retrieveList(modelInfo, meta));
    yield list;
  } catch (error, stackTrace) {
    ref.read(messagesProvider.notifier).publish(Message(
          text: 'Error loading list of model instances.',
          detail: error.toString(),
          error: error,
          stackTrace: stackTrace,
        ));
    rethrow;
  }
});
