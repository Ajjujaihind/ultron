// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OllamaModelImpl _$$OllamaModelImplFromJson(Map<String, dynamic> json) =>
    _$OllamaModelImpl(
      name: json['name'] as String,
      model: json['model'] as String?,
      modifiedAt: json['modified_at'] == null
          ? null
          : DateTime.parse(json['modified_at'] as String),
      size: (json['size'] as num?)?.toInt() ?? 0,
      digest: json['digest'] as String?,
      details: json['details'] == null
          ? null
          : ModelDetails.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OllamaModelImplToJson(_$OllamaModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'model': instance.model,
      'modified_at': instance.modifiedAt?.toIso8601String(),
      'size': instance.size,
      'digest': instance.digest,
      'details': instance.details,
    };

_$ModelDetailsImpl _$$ModelDetailsImplFromJson(Map<String, dynamic> json) =>
    _$ModelDetailsImpl(
      parentModel: json['parent_model'] as String?,
      format: json['format'] as String?,
      family: json['family'] as String?,
      families: (json['families'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      parameterSize: json['parameter_size'] as String?,
      quantizationLevel: json['quantization_level'] as String?,
    );

Map<String, dynamic> _$$ModelDetailsImplToJson(_$ModelDetailsImpl instance) =>
    <String, dynamic>{
      'parent_model': instance.parentModel,
      'format': instance.format,
      'family': instance.family,
      'families': instance.families,
      'parameter_size': instance.parameterSize,
      'quantization_level': instance.quantizationLevel,
    };

_$PullProgressImpl _$$PullProgressImplFromJson(Map<String, dynamic> json) =>
    _$PullProgressImpl(
      modelName: json['modelName'] as String,
      status: json['status'] as String,
      completed: (json['completed'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      isDone: json['isDone'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$PullProgressImplToJson(_$PullProgressImpl instance) =>
    <String, dynamic>{
      'modelName': instance.modelName,
      'status': instance.status,
      'completed': instance.completed,
      'total': instance.total,
      'isDone': instance.isDone,
      'error': instance.error,
    };
