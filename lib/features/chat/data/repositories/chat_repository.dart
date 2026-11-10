import 'dart:async';
import 'package:dio/dio.dart';
import '../../../../core/network/ollama_client.dart';
import '../../../../core/storage/local_storage_service.dart';
import '../../domain/models/conversation.dart';

class ChatRepository {
  final OllamaClient _ollamaClient;
  final LocalStorageService _storageService;
  CancelToken? _currentCancelToken;

  ChatRepository({
    OllamaClient? ollamaClient,
    LocalStorageService? storageService,
  })  : _ollamaClient = ollamaClient ?? OllamaClient(),
        _storageService = storageService ?? LocalStorageService();

  /// Stream tokens from Ollama /api/chat
  Stream<String> streamChatCompletion({
    required String baseUrl,
    required String model,
    required List<Map<String, String>> messages,
    double temperature = 0.7,
  }) {
    _currentCancelToken?.cancel('New chat request started');
    final cancelToken = CancelToken();
    _currentCancelToken = cancelToken;

    return _ollamaClient.streamChat(
      baseUrl: baseUrl,
      model: model,
      messages: messages,
      temperature: temperature,
      cancelToken: cancelToken,
    );
  }

  /// Stop current chat streaming via Dio CancelToken
  void stopGeneration() {
    _currentCancelToken?.cancel('User cancelled generation');
    _currentCancelToken = null;
  }

  /// Load all stored conversations from disk
  Future<List<Conversation>> loadConversations() async {
    final rawList = await _storageService.loadConversations();
    return rawList.map((json) {
      try {
        return Conversation.fromJson(json);
      } catch (_) {
        return null;
      }
    }).whereType<Conversation>().toList();
  }

  /// Save conversations to disk
  Future<void> saveConversations(List<Conversation> conversations) async {
    final rawList = conversations.map((c) {
      final json = c.toJson();
      json['messages'] = c.messages.map((m) => m.toJson()).toList();
      return json;
    }).toList();
    await _storageService.saveConversations(rawList);
  }

  /// Clear all conversations from disk
  Future<void> clearAllConversations() async {
    await _storageService.clearConversations();
  }
}
