// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OllamaModel _$OllamaModelFromJson(Map<String, dynamic> json) {
  return _OllamaModel.fromJson(json);
}

/// @nodoc
mixin _$OllamaModel {
  String get name => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  @JsonKey(name: 'modified_at')
  DateTime? get modifiedAt => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String? get digest => throw _privateConstructorUsedError;
  ModelDetails? get details => throw _privateConstructorUsedError;

  /// Serializes this OllamaModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OllamaModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OllamaModelCopyWith<OllamaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OllamaModelCopyWith<$Res> {
  factory $OllamaModelCopyWith(
    OllamaModel value,
    $Res Function(OllamaModel) then,
  ) = _$OllamaModelCopyWithImpl<$Res, OllamaModel>;
  @useResult
  $Res call({
    String name,
    String? model,
    @JsonKey(name: 'modified_at') DateTime? modifiedAt,
    int size,
    String? digest,
    ModelDetails? details,
  });

  $ModelDetailsCopyWith<$Res>? get details;
}

/// @nodoc
class _$OllamaModelCopyWithImpl<$Res, $Val extends OllamaModel>
    implements $OllamaModelCopyWith<$Res> {
  _$OllamaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OllamaModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? model = freezed,
    Object? modifiedAt = freezed,
    Object? size = null,
    Object? digest = freezed,
    Object? details = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            model: freezed == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
                      as String?,
            modifiedAt: freezed == modifiedAt
                ? _value.modifiedAt
                : modifiedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            size: null == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as int,
            digest: freezed == digest
                ? _value.digest
                : digest // ignore: cast_nullable_to_non_nullable
                      as String?,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as ModelDetails?,
          )
          as $Val,
    );
  }

  /// Create a copy of OllamaModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ModelDetailsCopyWith<$Res>? get details {
    if (_value.details == null) {
      return null;
    }

    return $ModelDetailsCopyWith<$Res>(_value.details!, (value) {
      return _then(_value.copyWith(details: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OllamaModelImplCopyWith<$Res>
    implements $OllamaModelCopyWith<$Res> {
  factory _$$OllamaModelImplCopyWith(
    _$OllamaModelImpl value,
    $Res Function(_$OllamaModelImpl) then,
  ) = __$$OllamaModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String? model,
    @JsonKey(name: 'modified_at') DateTime? modifiedAt,
    int size,
    String? digest,
    ModelDetails? details,
  });

  @override
  $ModelDetailsCopyWith<$Res>? get details;
}

/// @nodoc
class __$$OllamaModelImplCopyWithImpl<$Res>
    extends _$OllamaModelCopyWithImpl<$Res, _$OllamaModelImpl>
    implements _$$OllamaModelImplCopyWith<$Res> {
  __$$OllamaModelImplCopyWithImpl(
    _$OllamaModelImpl _value,
    $Res Function(_$OllamaModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OllamaModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? model = freezed,
    Object? modifiedAt = freezed,
    Object? size = null,
    Object? digest = freezed,
    Object? details = freezed,
  }) {
    return _then(
      _$OllamaModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        model: freezed == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
                  as String?,
        modifiedAt: freezed == modifiedAt
            ? _value.modifiedAt
            : modifiedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        size: null == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as int,
        digest: freezed == digest
            ? _value.digest
            : digest // ignore: cast_nullable_to_non_nullable
                  as String?,
        details: freezed == details
            ? _value.details
            : details // ignore: cast_nullable_to_non_nullable
                  as ModelDetails?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OllamaModelImpl implements _OllamaModel {
  const _$OllamaModelImpl({
    required this.name,
    this.model,
    @JsonKey(name: 'modified_at') this.modifiedAt,
    this.size = 0,
    this.digest,
    this.details,
  });

  factory _$OllamaModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OllamaModelImplFromJson(json);

  @override
  final String name;
  @override
  final String? model;
  @override
  @JsonKey(name: 'modified_at')
  final DateTime? modifiedAt;
  @override
  @JsonKey()
  final int size;
  @override
  final String? digest;
  @override
  final ModelDetails? details;

  @override
  String toString() {
    return 'OllamaModel(name: $name, model: $model, modifiedAt: $modifiedAt, size: $size, digest: $digest, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OllamaModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.digest, digest) || other.digest == digest) &&
            (identical(other.details, details) || other.details == details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, model, modifiedAt, size, digest, details);

  /// Create a copy of OllamaModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OllamaModelImplCopyWith<_$OllamaModelImpl> get copyWith =>
      __$$OllamaModelImplCopyWithImpl<_$OllamaModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OllamaModelImplToJson(this);
  }
}

abstract class _OllamaModel implements OllamaModel {
  const factory _OllamaModel({
    required final String name,
    final String? model,
    @JsonKey(name: 'modified_at') final DateTime? modifiedAt,
    final int size,
    final String? digest,
    final ModelDetails? details,
  }) = _$OllamaModelImpl;

  factory _OllamaModel.fromJson(Map<String, dynamic> json) =
      _$OllamaModelImpl.fromJson;

  @override
  String get name;
  @override
  String? get model;
  @override
  @JsonKey(name: 'modified_at')
  DateTime? get modifiedAt;
  @override
  int get size;
  @override
  String? get digest;
  @override
  ModelDetails? get details;

  /// Create a copy of OllamaModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OllamaModelImplCopyWith<_$OllamaModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ModelDetails _$ModelDetailsFromJson(Map<String, dynamic> json) {
  return _ModelDetails.fromJson(json);
}

/// @nodoc
mixin _$ModelDetails {
  @JsonKey(name: 'parent_model')
  String? get parentModel => throw _privateConstructorUsedError;
  String? get format => throw _privateConstructorUsedError;
  String? get family => throw _privateConstructorUsedError;
  List<String>? get families => throw _privateConstructorUsedError;
  @JsonKey(name: 'parameter_size')
  String? get parameterSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantization_level')
  String? get quantizationLevel => throw _privateConstructorUsedError;

  /// Serializes this ModelDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModelDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelDetailsCopyWith<ModelDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelDetailsCopyWith<$Res> {
  factory $ModelDetailsCopyWith(
    ModelDetails value,
    $Res Function(ModelDetails) then,
  ) = _$ModelDetailsCopyWithImpl<$Res, ModelDetails>;
  @useResult
  $Res call({
    @JsonKey(name: 'parent_model') String? parentModel,
    String? format,
    String? family,
    List<String>? families,
    @JsonKey(name: 'parameter_size') String? parameterSize,
    @JsonKey(name: 'quantization_level') String? quantizationLevel,
  });
}

/// @nodoc
class _$ModelDetailsCopyWithImpl<$Res, $Val extends ModelDetails>
    implements $ModelDetailsCopyWith<$Res> {
  _$ModelDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parentModel = freezed,
    Object? format = freezed,
    Object? family = freezed,
    Object? families = freezed,
    Object? parameterSize = freezed,
    Object? quantizationLevel = freezed,
  }) {
    return _then(
      _value.copyWith(
            parentModel: freezed == parentModel
                ? _value.parentModel
                : parentModel // ignore: cast_nullable_to_non_nullable
                      as String?,
            format: freezed == format
                ? _value.format
                : format // ignore: cast_nullable_to_non_nullable
                      as String?,
            family: freezed == family
                ? _value.family
                : family // ignore: cast_nullable_to_non_nullable
                      as String?,
            families: freezed == families
                ? _value.families
                : families // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            parameterSize: freezed == parameterSize
                ? _value.parameterSize
                : parameterSize // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantizationLevel: freezed == quantizationLevel
                ? _value.quantizationLevel
                : quantizationLevel // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModelDetailsImplCopyWith<$Res>
    implements $ModelDetailsCopyWith<$Res> {
  factory _$$ModelDetailsImplCopyWith(
    _$ModelDetailsImpl value,
    $Res Function(_$ModelDetailsImpl) then,
  ) = __$$ModelDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'parent_model') String? parentModel,
    String? format,
    String? family,
    List<String>? families,
    @JsonKey(name: 'parameter_size') String? parameterSize,
    @JsonKey(name: 'quantization_level') String? quantizationLevel,
  });
}

/// @nodoc
class __$$ModelDetailsImplCopyWithImpl<$Res>
    extends _$ModelDetailsCopyWithImpl<$Res, _$ModelDetailsImpl>
    implements _$$ModelDetailsImplCopyWith<$Res> {
  __$$ModelDetailsImplCopyWithImpl(
    _$ModelDetailsImpl _value,
    $Res Function(_$ModelDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModelDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parentModel = freezed,
    Object? format = freezed,
    Object? family = freezed,
    Object? families = freezed,
    Object? parameterSize = freezed,
    Object? quantizationLevel = freezed,
  }) {
    return _then(
      _$ModelDetailsImpl(
        parentModel: freezed == parentModel
            ? _value.parentModel
            : parentModel // ignore: cast_nullable_to_non_nullable
                  as String?,
        format: freezed == format
            ? _value.format
            : format // ignore: cast_nullable_to_non_nullable
                  as String?,
        family: freezed == family
            ? _value.family
            : family // ignore: cast_nullable_to_non_nullable
                  as String?,
        families: freezed == families
            ? _value._families
            : families // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        parameterSize: freezed == parameterSize
            ? _value.parameterSize
            : parameterSize // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantizationLevel: freezed == quantizationLevel
            ? _value.quantizationLevel
            : quantizationLevel // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ModelDetailsImpl implements _ModelDetails {
  const _$ModelDetailsImpl({
    @JsonKey(name: 'parent_model') this.parentModel,
    this.format,
    this.family,
    final List<String>? families,
    @JsonKey(name: 'parameter_size') this.parameterSize,
    @JsonKey(name: 'quantization_level') this.quantizationLevel,
  }) : _families = families;

  factory _$ModelDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModelDetailsImplFromJson(json);

  @override
  @JsonKey(name: 'parent_model')
  final String? parentModel;
  @override
  final String? format;
  @override
  final String? family;
  final List<String>? _families;
  @override
  List<String>? get families {
    final value = _families;
    if (value == null) return null;
    if (_families is EqualUnmodifiableListView) return _families;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'parameter_size')
  final String? parameterSize;
  @override
  @JsonKey(name: 'quantization_level')
  final String? quantizationLevel;

  @override
  String toString() {
    return 'ModelDetails(parentModel: $parentModel, format: $format, family: $family, families: $families, parameterSize: $parameterSize, quantizationLevel: $quantizationLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelDetailsImpl &&
            (identical(other.parentModel, parentModel) ||
                other.parentModel == parentModel) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.family, family) || other.family == family) &&
            const DeepCollectionEquality().equals(other._families, _families) &&
            (identical(other.parameterSize, parameterSize) ||
                other.parameterSize == parameterSize) &&
            (identical(other.quantizationLevel, quantizationLevel) ||
                other.quantizationLevel == quantizationLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    parentModel,
    format,
    family,
    const DeepCollectionEquality().hash(_families),
    parameterSize,
    quantizationLevel,
  );

  /// Create a copy of ModelDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelDetailsImplCopyWith<_$ModelDetailsImpl> get copyWith =>
      __$$ModelDetailsImplCopyWithImpl<_$ModelDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModelDetailsImplToJson(this);
  }
}

abstract class _ModelDetails implements ModelDetails {
  const factory _ModelDetails({
    @JsonKey(name: 'parent_model') final String? parentModel,
    final String? format,
    final String? family,
    final List<String>? families,
    @JsonKey(name: 'parameter_size') final String? parameterSize,
    @JsonKey(name: 'quantization_level') final String? quantizationLevel,
  }) = _$ModelDetailsImpl;

  factory _ModelDetails.fromJson(Map<String, dynamic> json) =
      _$ModelDetailsImpl.fromJson;

  @override
  @JsonKey(name: 'parent_model')
  String? get parentModel;
  @override
  String? get format;
  @override
  String? get family;
  @override
  List<String>? get families;
  @override
  @JsonKey(name: 'parameter_size')
  String? get parameterSize;
  @override
  @JsonKey(name: 'quantization_level')
  String? get quantizationLevel;

  /// Create a copy of ModelDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelDetailsImplCopyWith<_$ModelDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PullProgress _$PullProgressFromJson(Map<String, dynamic> json) {
  return _PullProgress.fromJson(json);
}

/// @nodoc
mixin _$PullProgress {
  String get modelName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int? get completed => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this PullProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PullProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PullProgressCopyWith<PullProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PullProgressCopyWith<$Res> {
  factory $PullProgressCopyWith(
    PullProgress value,
    $Res Function(PullProgress) then,
  ) = _$PullProgressCopyWithImpl<$Res, PullProgress>;
  @useResult
  $Res call({
    String modelName,
    String status,
    int? completed,
    int? total,
    bool isDone,
    String? error,
  });
}

/// @nodoc
class _$PullProgressCopyWithImpl<$Res, $Val extends PullProgress>
    implements $PullProgressCopyWith<$Res> {
  _$PullProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PullProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelName = null,
    Object? status = null,
    Object? completed = freezed,
    Object? total = freezed,
    Object? isDone = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            modelName: null == modelName
                ? _value.modelName
                : modelName // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            completed: freezed == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as int?,
            total: freezed == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int?,
            isDone: null == isDone
                ? _value.isDone
                : isDone // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PullProgressImplCopyWith<$Res>
    implements $PullProgressCopyWith<$Res> {
  factory _$$PullProgressImplCopyWith(
    _$PullProgressImpl value,
    $Res Function(_$PullProgressImpl) then,
  ) = __$$PullProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String modelName,
    String status,
    int? completed,
    int? total,
    bool isDone,
    String? error,
  });
}

/// @nodoc
class __$$PullProgressImplCopyWithImpl<$Res>
    extends _$PullProgressCopyWithImpl<$Res, _$PullProgressImpl>
    implements _$$PullProgressImplCopyWith<$Res> {
  __$$PullProgressImplCopyWithImpl(
    _$PullProgressImpl _value,
    $Res Function(_$PullProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PullProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelName = null,
    Object? status = null,
    Object? completed = freezed,
    Object? total = freezed,
    Object? isDone = null,
    Object? error = freezed,
  }) {
    return _then(
      _$PullProgressImpl(
        modelName: null == modelName
            ? _value.modelName
            : modelName // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        completed: freezed == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as int?,
        total: freezed == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int?,
        isDone: null == isDone
            ? _value.isDone
            : isDone // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PullProgressImpl implements _PullProgress {
  const _$PullProgressImpl({
    required this.modelName,
    required this.status,
    this.completed,
    this.total,
    this.isDone = false,
    this.error,
  });

  factory _$PullProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$PullProgressImplFromJson(json);

  @override
  final String modelName;
  @override
  final String status;
  @override
  final int? completed;
  @override
  final int? total;
  @override
  @JsonKey()
  final bool isDone;
  @override
  final String? error;

  @override
  String toString() {
    return 'PullProgress(modelName: $modelName, status: $status, completed: $completed, total: $total, isDone: $isDone, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PullProgressImpl &&
            (identical(other.modelName, modelName) ||
                other.modelName == modelName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.isDone, isDone) || other.isDone == isDone) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    modelName,
    status,
    completed,
    total,
    isDone,
    error,
  );

  /// Create a copy of PullProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PullProgressImplCopyWith<_$PullProgressImpl> get copyWith =>
      __$$PullProgressImplCopyWithImpl<_$PullProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PullProgressImplToJson(this);
  }
}

abstract class _PullProgress implements PullProgress {
  const factory _PullProgress({
    required final String modelName,
    required final String status,
    final int? completed,
    final int? total,
    final bool isDone,
    final String? error,
  }) = _$PullProgressImpl;

  factory _PullProgress.fromJson(Map<String, dynamic> json) =
      _$PullProgressImpl.fromJson;

  @override
  String get modelName;
  @override
  String get status;
  @override
  int? get completed;
  @override
  int? get total;
  @override
  bool get isDone;
  @override
  String? get error;

  /// Create a copy of PullProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PullProgressImplCopyWith<_$PullProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
