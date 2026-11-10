// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatState {
  Conversation? get conversation => throw _privateConstructorUsedError;
  bool get isGenerating => throw _privateConstructorUsedError;
  String? get activeModel => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatStateCopyWith<ChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
  @useResult
  $Res call({
    Conversation? conversation,
    bool isGenerating,
    String? activeModel,
    String? errorMessage,
  });

  $ConversationCopyWith<$Res>? get conversation;
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversation = freezed,
    Object? isGenerating = null,
    Object? activeModel = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            conversation: freezed == conversation
                ? _value.conversation
                : conversation // ignore: cast_nullable_to_non_nullable
                      as Conversation?,
            isGenerating: null == isGenerating
                ? _value.isGenerating
                : isGenerating // ignore: cast_nullable_to_non_nullable
                      as bool,
            activeModel: freezed == activeModel
                ? _value.activeModel
                : activeModel // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConversationCopyWith<$Res>? get conversation {
    if (_value.conversation == null) {
      return null;
    }

    return $ConversationCopyWith<$Res>(_value.conversation!, (value) {
      return _then(_value.copyWith(conversation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatStateImplCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory _$$ChatStateImplCopyWith(
    _$ChatStateImpl value,
    $Res Function(_$ChatStateImpl) then,
  ) = __$$ChatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Conversation? conversation,
    bool isGenerating,
    String? activeModel,
    String? errorMessage,
  });

  @override
  $ConversationCopyWith<$Res>? get conversation;
}

/// @nodoc
class __$$ChatStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateImpl>
    implements _$$ChatStateImplCopyWith<$Res> {
  __$$ChatStateImplCopyWithImpl(
    _$ChatStateImpl _value,
    $Res Function(_$ChatStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversation = freezed,
    Object? isGenerating = null,
    Object? activeModel = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$ChatStateImpl(
        conversation: freezed == conversation
            ? _value.conversation
            : conversation // ignore: cast_nullable_to_non_nullable
                  as Conversation?,
        isGenerating: null == isGenerating
            ? _value.isGenerating
            : isGenerating // ignore: cast_nullable_to_non_nullable
                  as bool,
        activeModel: freezed == activeModel
            ? _value.activeModel
            : activeModel // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ChatStateImpl implements _ChatState {
  const _$ChatStateImpl({
    this.conversation,
    this.isGenerating = false,
    this.activeModel,
    this.errorMessage,
  });

  @override
  final Conversation? conversation;
  @override
  @JsonKey()
  final bool isGenerating;
  @override
  final String? activeModel;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ChatState(conversation: $conversation, isGenerating: $isGenerating, activeModel: $activeModel, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateImpl &&
            (identical(other.conversation, conversation) ||
                other.conversation == conversation) &&
            (identical(other.isGenerating, isGenerating) ||
                other.isGenerating == isGenerating) &&
            (identical(other.activeModel, activeModel) ||
                other.activeModel == activeModel) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    conversation,
    isGenerating,
    activeModel,
    errorMessage,
  );

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      __$$ChatStateImplCopyWithImpl<_$ChatStateImpl>(this, _$identity);
}

abstract class _ChatState implements ChatState {
  const factory _ChatState({
    final Conversation? conversation,
    final bool isGenerating,
    final String? activeModel,
    final String? errorMessage,
  }) = _$ChatStateImpl;

  @override
  Conversation? get conversation;
  @override
  bool get isGenerating;
  @override
  String? get activeModel;
  @override
  String? get errorMessage;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
