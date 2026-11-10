import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/models/app_settings.dart';
import '../../../../core/network/ollama_client.dart';

part 'settings_notifier.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepository();
}

@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  SettingsRepository get _repository => ref.read(settingsRepositoryProvider);
  final OllamaClient _ollamaClient = OllamaClient();

  @override
  AppSettings build() {
    _loadInitialSettings();
    return const AppSettings();
  }

  Future<void> _loadInitialSettings() async {
    final loaded = await _repository.loadSettings();
    state = loaded;
  }

  Future<void> updateHost(String host) async {
    final updated = state.copyWith(ollamaHost: host.trim());
    state = updated;
    await _repository.saveSettings(updated);
  }

  Future<void> updateDefaultModel(String model) async {
    final updated = state.copyWith(defaultModel: model.trim());
    state = updated;
    await _repository.saveSettings(updated);
  }

  Future<void> updateTemperature(double temperature) async {
    final updated = state.copyWith(temperature: temperature);
    state = updated;
    await _repository.saveSettings(updated);
  }

  Future<void> updateSystemPrompt(String systemPrompt) async {
    final updated = state.copyWith(systemPrompt: systemPrompt);
    state = updated;
    await _repository.saveSettings(updated);
  }

  Future<void> updateThemeMode(String mode) async {
    final updated = state.copyWith(themeMode: mode);
    state = updated;
    await _repository.saveSettings(updated);
  }

  /// Check connection and return server version or null
  Future<String?> testConnection() async {
    return await _ollamaClient.checkHealth(state.ollamaHost);
  }
}

typedef SettingsNotifier = Settings;
