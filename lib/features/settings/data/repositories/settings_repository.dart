import '../../../../core/storage/local_storage_service.dart';
import '../../domain/models/app_settings.dart';

class SettingsRepository {
  final LocalStorageService _storage;

  SettingsRepository({LocalStorageService? storage})
      : _storage = storage ?? LocalStorageService();

  Future<AppSettings> loadSettings() async {
    final data = await _storage.loadSettings();
    if (data == null) {
      return const AppSettings();
    }
    try {
      return AppSettings.fromJson(data);
    } catch (_) {
      return const AppSettings();
    }
  }

  Future<void> saveSettings(AppSettings settings) async {
    await _storage.saveSettings(settings.toJson());
  }
}
