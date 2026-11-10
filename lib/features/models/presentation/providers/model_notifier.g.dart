// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$modelRepositoryHash() => r'acec8955ec5c6970f2b989ac1d0ead6e5beaf44b';

/// See also [modelRepository].
@ProviderFor(modelRepository)
final modelRepositoryProvider = Provider<ModelRepository>.internal(
  modelRepository,
  name: r'modelRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$modelRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ModelRepositoryRef = ProviderRef<ModelRepository>;
String _$modelHash() => r'a6780dcefed7ff7e642012039a110de6bacfed11';

/// See also [Model].
@ProviderFor(Model)
final modelProvider = NotifierProvider<Model, ModelState>.internal(
  Model.new,
  name: r'modelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$modelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Model = Notifier<ModelState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
