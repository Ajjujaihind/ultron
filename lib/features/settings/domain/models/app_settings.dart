import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default('http://127.0.0.1:11434') String ollamaHost,
    @Default('llama3.2') String defaultModel,
    @Default(0.7) double temperature,
    @Default('You are a helpful assistant. Be concise and clear in your responses.')
    String systemPrompt,
    @Default('system') String themeMode, // 'system', 'light', 'dark'
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}
