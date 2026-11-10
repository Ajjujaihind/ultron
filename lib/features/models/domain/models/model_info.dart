import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_info.freezed.dart';
part 'model_info.g.dart';

@freezed
class OllamaModel with _$OllamaModel {
  const factory OllamaModel({
    required String name,
    String? model,
    @JsonKey(name: 'modified_at') DateTime? modifiedAt,
    @Default(0) int size,
    String? digest,
    ModelDetails? details,
  }) = _OllamaModel;

  factory OllamaModel.fromJson(Map<String, dynamic> json) =>
      _$OllamaModelFromJson(json);
}

@freezed
class ModelDetails with _$ModelDetails {
  const factory ModelDetails({
    @JsonKey(name: 'parent_model') String? parentModel,
    String? format,
    String? family,
    List<String>? families,
    @JsonKey(name: 'parameter_size') String? parameterSize,
    @JsonKey(name: 'quantization_level') String? quantizationLevel,
  }) = _ModelDetails;

  factory ModelDetails.fromJson(Map<String, dynamic> json) =>
      _$ModelDetailsFromJson(json);
}

@freezed
class PullProgress with _$PullProgress {
  const factory PullProgress({
    required String modelName,
    required String status,
    int? completed,
    int? total,
    @Default(false) bool isDone,
    String? error,
  }) = _PullProgress;

  factory PullProgress.fromJson(Map<String, dynamic> json) =>
      _$PullProgressFromJson(json);
}
