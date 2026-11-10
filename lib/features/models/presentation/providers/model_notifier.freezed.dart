// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ModelState {
  List<OllamaModel> get installedModels => throw _privateConstructorUsedError;
  String? get activeModel => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  String? get serverVersion => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  Map<String, PullProgress> get activePulls =>
      throw _privateConstructorUsedError;

  /// Create a copy of ModelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelStateCopyWith<ModelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelStateCopyWith<$Res> {
  factory $ModelStateCopyWith(
    ModelState value,
    $Res Function(ModelState) then,
  ) = _$ModelStateCopyWithImpl<$Res, ModelState>;
  @useResult
  $Res call({
    List<OllamaModel> installedModels,
    String? activeModel,
    bool isLoading,
    bool isConnected,
    String? serverVersion,
    String? errorMessage,
    Map<String, PullProgress> activePulls,
  });
}

/// @nodoc
class _$ModelStateCopyWithImpl<$Res, $Val extends ModelState>
    implements $ModelStateCopyWith<$Res> {
  _$ModelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? installedModels = null,
    Object? activeModel = freezed,
    Object? isLoading = null,
    Object? isConnected = null,
    Object? serverVersion = freezed,
    Object? errorMessage = freezed,
    Object? activePulls = null,
  }) {
    return _then(
      _value.copyWith(
            installedModels: null == installedModels
                ? _value.installedModels
                : installedModels // ignore: cast_nullable_to_non_nullable
                      as List<OllamaModel>,
            activeModel: freezed == activeModel
                ? _value.activeModel
                : activeModel // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isConnected: null == isConnected
                ? _value.isConnected
                : isConnected // ignore: cast_nullable_to_non_nullable
                      as bool,
            serverVersion: freezed == serverVersion
                ? _value.serverVersion
                : serverVersion // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            activePulls: null == activePulls
                ? _value.activePulls
                : activePulls // ignore: cast_nullable_to_non_nullable
                      as Map<String, PullProgress>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModelStateImplCopyWith<$Res>
    implements $ModelStateCopyWith<$Res> {
  factory _$$ModelStateImplCopyWith(
    _$ModelStateImpl value,
    $Res Function(_$ModelStateImpl) then,
  ) = __$$ModelStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<OllamaModel> installedModels,
    String? activeModel,
    bool isLoading,
    bool isConnected,
    String? serverVersion,
    String? errorMessage,
    Map<String, PullProgress> activePulls,
  });
}

/// @nodoc
class __$$ModelStateImplCopyWithImpl<$Res>
    extends _$ModelStateCopyWithImpl<$Res, _$ModelStateImpl>
    implements _$$ModelStateImplCopyWith<$Res> {
  __$$ModelStateImplCopyWithImpl(
    _$ModelStateImpl _value,
    $Res Function(_$ModelStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? installedModels = null,
    Object? activeModel = freezed,
    Object? isLoading = null,
    Object? isConnected = null,
    Object? serverVersion = freezed,
    Object? errorMessage = freezed,
    Object? activePulls = null,
  }) {
    return _then(
      _$ModelStateImpl(
        installedModels: null == installedModels
            ? _value._installedModels
            : installedModels // ignore: cast_nullable_to_non_nullable
                  as List<OllamaModel>,
        activeModel: freezed == activeModel
            ? _value.activeModel
            : activeModel // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isConnected: null == isConnected
            ? _value.isConnected
            : isConnected // ignore: cast_nullable_to_non_nullable
                  as bool,
        serverVersion: freezed == serverVersion
            ? _value.serverVersion
            : serverVersion // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        activePulls: null == activePulls
            ? _value._activePulls
            : activePulls // ignore: cast_nullable_to_non_nullable
                  as Map<String, PullProgress>,
      ),
    );
  }
}

/// @nodoc

class _$ModelStateImpl implements _ModelState {
  const _$ModelStateImpl({
    final List<OllamaModel> installedModels = const [],
    this.activeModel,
    this.isLoading = false,
    this.isConnected = false,
    this.serverVersion,
    this.errorMessage,
    final Map<String, PullProgress> activePulls = const {},
  }) : _installedModels = installedModels,
       _activePulls = activePulls;

  final List<OllamaModel> _installedModels;
  @override
  @JsonKey()
  List<OllamaModel> get installedModels {
    if (_installedModels is EqualUnmodifiableListView) return _installedModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_installedModels);
  }

  @override
  final String? activeModel;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isConnected;
  @override
  final String? serverVersion;
  @override
  final String? errorMessage;
  final Map<String, PullProgress> _activePulls;
  @override
  @JsonKey()
  Map<String, PullProgress> get activePulls {
    if (_activePulls is EqualUnmodifiableMapView) return _activePulls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_activePulls);
  }

  @override
  String toString() {
    return 'ModelState(installedModels: $installedModels, activeModel: $activeModel, isLoading: $isLoading, isConnected: $isConnected, serverVersion: $serverVersion, errorMessage: $errorMessage, activePulls: $activePulls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelStateImpl &&
            const DeepCollectionEquality().equals(
              other._installedModels,
              _installedModels,
            ) &&
            (identical(other.activeModel, activeModel) ||
                other.activeModel == activeModel) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.serverVersion, serverVersion) ||
                other.serverVersion == serverVersion) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(
              other._activePulls,
              _activePulls,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_installedModels),
    activeModel,
    isLoading,
    isConnected,
    serverVersion,
    errorMessage,
    const DeepCollectionEquality().hash(_activePulls),
  );

  /// Create a copy of ModelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelStateImplCopyWith<_$ModelStateImpl> get copyWith =>
      __$$ModelStateImplCopyWithImpl<_$ModelStateImpl>(this, _$identity);
}

abstract class _ModelState implements ModelState {
  const factory _ModelState({
    final List<OllamaModel> installedModels,
    final String? activeModel,
    final bool isLoading,
    final bool isConnected,
    final String? serverVersion,
    final String? errorMessage,
    final Map<String, PullProgress> activePulls,
  }) = _$ModelStateImpl;

  @override
  List<OllamaModel> get installedModels;
  @override
  String? get activeModel;
  @override
  bool get isLoading;
  @override
  bool get isConnected;
  @override
  String? get serverVersion;
  @override
  String? get errorMessage;
  @override
  Map<String, PullProgress> get activePulls;

  /// Create a copy of ModelState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelStateImplCopyWith<_$ModelStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
