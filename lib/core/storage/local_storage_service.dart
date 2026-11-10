import 'dart:convert';
import 'dart:io';
import '../constants/app_constants.dart';

class LocalStorageService {
  Directory? _storageDir;

  Future<Directory> _getStorageDirectory() async {
    if (_storageDir != null) return _storageDir!;

    String path;
    if (Platform.isMacOS) {
      final home = Platform.environment['HOME'] ?? '';
      path = home.isNotEmpty
          ? '$home/Library/Application Support/ultron'
          : '.ultron_data';
    } else if (Platform.isWindows) {
      final appData = Platform.environment['APPDATA'] ??
          Platform.environment['USERPROFILE'] ??
          '';
      path = appData.isNotEmpty ? '$appData\\Ultron' : '.ultron_data';
    } else if (Platform.isLinux) {
      final xdg = Platform.environment['XDG_DATA_HOME'];
      final home = Platform.environment['HOME'] ?? '';
      path = xdg != null && xdg.isNotEmpty
          ? '$xdg/ultron'
          : (home.isNotEmpty ? '$home/.local/share/ultron' : '.ultron_data');
    } else {
      path = '.ultron_data';
    }

    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    _storageDir = dir;
    return dir;
  }

  Future<File> _getFile(String fileName) async {
    final dir = await _getStorageDirectory();
    return File('${dir.path}/$fileName');
  }

  // --- Conversations Persistence ---

  Future<List<Map<String, dynamic>>> loadConversations() async {
    try {
      final file = await _getFile(AppConstants.conversationsFileName);
      if (!await file.exists()) {
        return [];
      }
      final content = await file.readAsString();
      if (content.trim().isEmpty) return [];
      final decoded = jsonDecode(content);
      if (decoded is List) {
        return decoded.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<void> saveConversations(List<Map<String, dynamic>> data) async {
    try {
      final file = await _getFile(AppConstants.conversationsFileName);
      await file.writeAsString(jsonEncode(data), flush: true);
    } catch (e) {
      // Log or handle write failure
    }
  }

  Future<void> clearConversations() async {
    try {
      final file = await _getFile(AppConstants.conversationsFileName);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {}
  }

  // --- Settings Persistence ---

  Future<Map<String, dynamic>?> loadSettings() async {
    try {
      final file = await _getFile(AppConstants.settingsFileName);
      if (!await file.exists()) return null;
      final content = await file.readAsString();
      if (content.trim().isEmpty) return null;
      final decoded = jsonDecode(content);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<void> saveSettings(Map<String, dynamic> data) async {
    try {
      final file = await _getFile(AppConstants.settingsFileName);
      await file.writeAsString(jsonEncode(data), flush: true);
    } catch (_) {}
  }
}
