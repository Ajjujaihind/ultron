// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(
  Map<String, dynamic> json,
) => _$AppSettingsImpl(
  ollamaHost: json['ollamaHost'] as String? ?? 'http://127.0.0.1:11434',
  defaultModel: json['defaultModel'] as String? ?? 'llama3.2',
  temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
  systemPrompt:
      json['systemPrompt'] as String? ??
      'You are a helpful assistant. Be concise and clear in your responses.',
  themeMode: json['themeMode'] as String? ?? 'system',
);

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'ollamaHost': instance.ollamaHost,
      'defaultModel': instance.defaultModel,
      'temperature': instance.temperature,
      'systemPrompt': instance.systemPrompt,
      'themeMode': instance.themeMode,
    };
