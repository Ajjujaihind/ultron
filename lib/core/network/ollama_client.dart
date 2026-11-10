import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

class OllamaClient {
  final Dio _dio;

  OllamaClient({Dio? dio}) : _dio = dio ?? Dio();

  String _buildUrl(String baseUrl, String endpoint) {
    var cleanBase = baseUrl.trim();
    if (cleanBase.endsWith('/')) {
      cleanBase = cleanBase.substring(0, cleanBase.length - 1);
    }
    if (!cleanBase.startsWith('http://') && !cleanBase.startsWith('https://')) {
      cleanBase = 'http://$cleanBase';
    }
    return '$cleanBase$endpoint';
  }

  /// Check whether Ollama is reachable and return its version
  Future<String?> checkHealth(String baseUrl) async {
    try {
      final url = _buildUrl(baseUrl, AppConstants.versionEndpoint);
      final response = await _dio.get<Map<String, dynamic>>(
        url,
        options: Options(
          sendTimeout: const Duration(seconds: 3),
          receiveTimeout: const Duration(seconds: 3),
        ),
      );
      if (response.statusCode == 200 && response.data != null) {
        return response.data!['version'] as String? ?? 'connected';
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// List all locally installed models from Ollama
  Future<List<Map<String, dynamic>>> getInstalledModels(String baseUrl) async {
    try {
      final url = _buildUrl(baseUrl, AppConstants.tagsEndpoint);
      final response = await _dio.get<Map<String, dynamic>>(
        url,
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final models = response.data!['models'] as List<dynamic>? ?? [];
        return models.cast<Map<String, dynamic>>();
      } else {
        throw HttpException(
          'Failed to fetch models (Status ${response.statusCode})',
        );
      }
    } on DioException catch (e) {
      if (e.error is SocketException || e.type == DioExceptionType.connectionError) {
        throw SocketException(
          'Cannot connect to Ollama at $baseUrl. Ensure Ollama is running. (${e.message})',
        );
      }
      throw HttpException('Failed to fetch models: ${e.message}');
    }
  }

  /// Pull/download a model from Ollama library with streaming progress updates
  Stream<Map<String, dynamic>> pullModel({
    required String baseUrl,
    required String modelName,
    CancelToken? cancelToken,
  }) async* {
    final url = _buildUrl(baseUrl, AppConstants.pullEndpoint);
    final response = await _dio.post<ResponseBody>(
      url,
      data: jsonEncode({
        'name': modelName.trim(),
        'stream': true,
      }),
      cancelToken: cancelToken,
      options: Options(
        responseType: ResponseType.stream,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    final responseBody = response.data;
    if (responseBody == null || response.statusCode != 200) {
      throw HttpException('Pull failed (Status ${response.statusCode})');
    }

    final lines = responseBody.stream
        .cast<List<int>>()
        .transform(utf8.decoder)
        .transform(const LineSplitter());

    await for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      try {
        final data = jsonDecode(trimmed) as Map<String, dynamic>;
        yield data;
      } catch (_) {
        // Skip malformed chunk
      }
    }
  }

  /// Delete a model from local Ollama storage
  Future<void> deleteModel({
    required String baseUrl,
    required String modelName,
  }) async {
    final url = _buildUrl(baseUrl, AppConstants.deleteEndpoint);
    final response = await _dio.delete(
      url,
      data: jsonEncode({
        'name': modelName.trim(),
      }),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (response.statusCode != 200) {
      throw HttpException(
        'Delete failed (Status ${response.statusCode})',
      );
    }
  }

  /// Stream chat completion tokens from Ollama /api/chat
  Stream<String> streamChat({
    required String baseUrl,
    required String model,
    required List<Map<String, String>> messages,
    double temperature = 0.7,
    CancelToken? cancelToken,
  }) async* {
    final url = _buildUrl(baseUrl, AppConstants.chatEndpoint);
    final response = await _dio.post<ResponseBody>(
      url,
      data: jsonEncode({
        'model': model,
        'messages': messages,
        'stream': true,
        'options': {
          'temperature': temperature,
        },
      }),
      cancelToken: cancelToken,
      options: Options(
        responseType: ResponseType.stream,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    final responseBody = response.data;
    if (responseBody == null || response.statusCode != 200) {
      throw HttpException(
        'Chat generation failed (Status ${response.statusCode})',
      );
    }

    final lines = responseBody.stream
        .cast<List<int>>()
        .transform(utf8.decoder)
        .transform(const LineSplitter());

    await for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      try {
        final data = jsonDecode(trimmed) as Map<String, dynamic>;
        final message = data['message'] as Map<String, dynamic>?;
        if (message != null) {
          final content = message['content'] as String? ?? '';
          if (content.isNotEmpty) {
            yield content;
          }
        }
        final isDone = data['done'] as bool? ?? false;
        if (isDone) {
          break;
        }
      } catch (_) {
        // Skip malformed chunk
      }
    }
  }
}
