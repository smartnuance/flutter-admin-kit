import 'dart:async';
import 'dart:developer' as developer;

import 'package:admin/proto/event.pb.dart';
import 'package:admin/proto/event.pbjson.dart';
import 'package:admin/proto/spec.pb.dart' as $spec;
import 'package:admin/views/crud/api_provider.dart';
import 'package:admin/views/crud/api_service.dart';
import 'package:admin/views/crud/models/model_infos.dart';
import 'package:admin/views/crud/models/model_instance.dart';
import 'package:admin/views/messages/message_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protoc_plugin/src/generated/descriptor.pb.dart';

final modelSpecProvider =
    FutureProvider.autoDispose.family<ModelSpec, ModelMeta>((ref, meta) async {
  final apiService = ref.watch(apiServiceProvider);
  final ModelSpec modelInfo;

  // see https://github.com/google/protobuf.dart/blob/master/protoc_plugin/test/descriptor_test.dart
  // final $pb.GeneratedMessage msg = Workshop_Info();
  final msg = Workshop();

  developer.log(msg.info_.byName.keys
      .join(', ')); // -> title, slug, locationName, locationURL, couples
  developer.log(msg.info_.byName["couples"]?.type.toString() ??
      "<no type>"); // -> title, slug, locationName, locationURL, couples
  developer.log(msg.eventID);
  final registry = $pb.ExtensionRegistry();
  $spec.Spec.registerAllExtensions(registry);
  final descriptor = DescriptorProto.fromBuffer(workshopDescriptor, registry);
  final option =
      descriptor.options.getExtension($spec.Spec.model) as $spec.ModelInfo;
  developer.log("OPTION:::: ${option}");

  final fi = descriptor.field[msg.info_.byName["id"]?.index ?? -1].options;
  final d = fi.getExtension($spec.Spec.field_50002) as $spec.FieldInfo;
  developer.log("OPTION FIELD:::: ${d}");

  try {
    modelInfo = await apiService.fetchModelSpec(meta);
  } catch (error, stackTrace) {
    developer.log(
      'retrieveModelSpec',
      error: error,
      stackTrace: stackTrace,
    );
    ref.read(messagesProvider.notifier).error(
          text: 'Error loading model info.',
          error: error,
          stackTrace: stackTrace,
        );
    return Future.error(error);
  }
  return modelInfo;
});

final modelItemsProvider = StateNotifierProvider.autoDispose
    .family<ModelItemsNotifier, InfiniteList, ModelMeta>((ref, meta) {
  final apiService = ref.watch(apiServiceProvider);
  final notifier =
      ModelItemsNotifier(ref, apiService, meta, InfiniteList.notLoaded());
  ref.watch(modelSpecProvider(meta)).maybeWhen(
        data: (modelSpec) {
          // trigger initial load
          unawaited(notifier.load(modelSpec));
          return notifier;
        },
        orElse: () {},
      );
  return notifier;
});

class ModelItemsNotifier extends StateNotifier<InfiniteList> {
  ModelItemsNotifier(this.ref, this.apiService, this.meta, InfiniteList state)
      : super(state);

  final AutoDisposeStateNotifierProviderRef<ModelItemsNotifier, InfiniteList>
      ref;
  final APIService apiService;
  final ModelMeta meta;

  /// load starts loading the model list from scratch, whatever the state was before, clearing previous loaded list items and a potential error state
  Future<void> load(ModelSpec modelSpec) async {
    state = InfiniteList.loading(modelSpec: modelSpec);
    try {
      state = InfiniteList.loaded(
        modelSpec: modelSpec,
        modelItems: await apiService.fetchItems(modelSpec, meta),
      );
    } catch (error, stackTrace) {
      ref.read(messagesProvider.notifier).error(
            text: 'Error loading list of model instances.',
            error: error,
            stackTrace: stackTrace,
          );
      state = InfiniteList.error(error, stackTrace);
    }
  }

  Future<void> reload() async {
    await state.maybeWhen(
      notLoaded: () {
        state =
            InfiniteList.error("can't reload when not yet loaded initially");
      },
      loaded: (modelSpec, _) async {
        state = InfiniteList.loading(modelSpec: modelSpec);
        try {
          state = InfiniteList.loaded(
            modelSpec: modelSpec,
            modelItems: await apiService.fetchItems(modelSpec, meta),
          );
        } catch (error, stackTrace) {
          ref.read(messagesProvider.notifier).error(
                text: 'Error loading list of model instances.',
                error: error,
                stackTrace: stackTrace,
              );
          state = InfiniteList.error(error, stackTrace);
        }
      },
      orElse: () {},
    );
  }

  Future<void> delete(Set<String> ids) async {
    await state.maybeWhen(
      loaded: (modelSpec, oldItems) async {
        state = InfiniteList.loading(modelSpec: modelSpec);
        try {
          await apiService.deleteItems(meta, ids);
          state = InfiniteList.loaded(
            modelSpec: modelSpec,
            modelItems: oldItems.copyWith(
                items: oldItems.items
                    .where(
                      (element) =>
                          !ids.contains((element.id as StringValue).value),
                    )
                    .toList(growable: false)),
          );
        } catch (error, stackTrace) {
          ref.read(messagesProvider.notifier).error(
                text: 'Error deleting model instances.',
                error: error,
                stackTrace: stackTrace,
              );
          state = InfiniteList.error(error, stackTrace);
        }
      },
      orElse: () {},
    );
  }

  Future<void> extend() async {
    await state.maybeWhen(
      notLoaded: () {
        state =
            InfiniteList.error("can't extend when not yet loaded initially");
      },
      loaded: (modelSpec, modelItems) async {
        final next = modelItems.paging.next;

        if (next != null) {
          state = InfiniteList.extending(
              modelSpec: modelSpec, modelItems: modelItems);
          try {
            final nextPageItems =
                await apiService.fetchItems(modelSpec, meta, next);

            final items = modelItems.items + nextPageItems.items;
            final unifiedPaging = modelItems.paging.copyWith(
                current: modelItems.paging.current
                    .extend(nextPageItems.paging.current),
                next: nextPageItems.paging.next);

            state = InfiniteList.loaded(
              modelSpec: modelSpec,
              modelItems:
                  nextPageItems.copyWith(items: items, paging: unifiedPaging),
            );
          } catch (error, stackTrace) {
            ref.read(messagesProvider.notifier).error(
                  text: 'Error loading list of model instances.',
                  error: error,
                  stackTrace: stackTrace,
                );
            state = InfiniteList.error(error, stackTrace);
          }
        }
      },
      orElse: () {},
    );
  }
}
