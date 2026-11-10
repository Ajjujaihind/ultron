import 'dart:async';
import '../../../../core/network/ollama_client.dart';
import '../../domain/models/model_info.dart';

class ModelRepository {
  final OllamaClient _client;

  ModelRepository({OllamaClient? client}) : _client = client ?? OllamaClient();

  Future<String?> checkServer(String baseUrl) => _client.checkHealth(baseUrl);

  Future<List<OllamaModel>> fetchInstalledModels(String baseUrl) async {
    final rawList = await _client.getInstalledModels(baseUrl);
    return rawList.map((json) => OllamaModel.fromJson(json)).toList();
  }

  Stream<PullProgress> pullModelStream({
    required String baseUrl,
    required String modelName,
  }) async* {
    try {
      await for (final chunk in _client.pullModel(
        baseUrl: baseUrl,
        modelName: modelName,
      )) {
        final status = chunk['status'] as String? ?? 'downloading';
        final completed = chunk['completed'] as int?;
        final total = chunk['total'] as int?;
        final isDone = status == 'success';

        yield PullProgress(
          modelName: modelName,
          status: status,
          completed: completed,
          total: total,
          isDone: isDone,
        );
      }
    } catch (e) {
      yield PullProgress(
        modelName: modelName,
        status: 'error',
        isDone: false,
        error: e.toString(),
      );
    }
  }

  Future<void> deleteModel({
    required String baseUrl,
    required String modelName,
  }) =>
      _client.deleteModel(baseUrl: baseUrl, modelName: modelName);
}
