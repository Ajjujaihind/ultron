import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../data/repositories/chat_repository.dart';
import '../../domain/models/chat_message.dart';
import '../../domain/models/conversation.dart';
import '../../../models/presentation/providers/model_notifier.dart';
import '../../../settings/presentation/providers/settings_notifier.dart';

part 'chat_notifier.g.dart';
part 'chat_notifier.freezed.dart';

@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) {
  return ChatRepository();
}

// --- Conversation List Notifier ---

@Riverpod(keepAlive: true)
class ConversationList extends _$ConversationList {
  ChatRepository get _repository => ref.read(chatRepositoryProvider);

  @override
  List<Conversation> build() {
    _loadAll();
    return const [];
  }

  Future<void> _loadAll() async {
    final list = await _repository.loadConversations();
    // Sort by updatedAt descending
    list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    state = list;
  }

  Future<void> upsertConversation(Conversation conv) async {
    final index = state.indexWhere((c) => c.id == conv.id);
    List<Conversation> updated;
    if (index >= 0) {
      updated = List.of(state);
      updated[index] = conv;
    } else {
      updated = [conv, ...state];
    }
    updated.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    state = updated;
    await _repository.saveConversations(updated);
  }

  Future<void> deleteConversation(String id) async {
    final updated = state.where((c) => c.id != id).toList();
    state = updated;
    await _repository.saveConversations(updated);
  }

  Future<void> clearAll() async {
    state = [];
    await _repository.clearAllConversations();
  }
}

typedef ConversationListNotifier = ConversationList;

// --- Chat State & Notifier ---

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    Conversation? conversation,
    @Default(false) bool isGenerating,
    String? activeModel,
    String? errorMessage,
  }) = _ChatState;
}

@Riverpod(keepAlive: true)
class Chat extends _$Chat {
  ChatRepository get _repository => ref.read(chatRepositoryProvider);
  StreamSubscription<String>? _streamingSub;
  final _uuid = const Uuid();

  @override
  ChatState build() {
    final initialModel = ref.read(modelProvider).activeModel ??
        ref.read(settingsProvider).defaultModel;

    ref.listen(modelProvider, (previous, next) {
      if (previous?.activeModel != next.activeModel && next.activeModel != null) {
        state = state.copyWith(activeModel: next.activeModel);
      }
    });

    ref.onDispose(() {
      _streamingSub?.cancel();
    });

    return ChatState(activeModel: initialModel);
  }

  void setModel(String model) {
    if (state.conversation != null) {
      final updated = state.conversation!.copyWith(model: model);
      state = state.copyWith(conversation: updated, activeModel: model);
      ref.read(conversationListProvider.notifier).upsertConversation(updated);
    } else {
      state = state.copyWith(activeModel: model);
    }
  }

  void loadConversation(String conversationId) {
    final conversations = ref.read(conversationListProvider);
    final conv = conversations.firstWhere(
      (c) => c.id == conversationId,
      orElse: () => _createNewConversation(model: state.activeModel),
    );
    state = state.copyWith(
      conversation: conv,
      activeModel: conv.model,
      errorMessage: null,
    );
  }

  void startNewChat([String? preferredModel]) {
    _streamingSub?.cancel();
    _repository.stopGeneration();

    final model = preferredModel ??
        state.activeModel ??
        ref.read(modelProvider).activeModel ??
        ref.read(settingsProvider).defaultModel;

    final newConv = _createNewConversation(model: model);
    state = ChatState(
      conversation: newConv,
      activeModel: model,
      isGenerating: false,
    );
    ref.read(conversationListProvider.notifier).upsertConversation(newConv);
  }

  Conversation _createNewConversation({String? model}) {
    final now = DateTime.now();
    final effectiveModel = model ?? ref.read(settingsProvider).defaultModel;
    return Conversation(
      id: _uuid.v4(),
      title: 'New Chat',
      model: effectiveModel,
      createdAt: now,
      updatedAt: now,
      messages: [],
      systemPrompt: ref.read(settingsProvider).systemPrompt,
    );
  }

  Future<void> sendMessage(String text) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty || state.isGenerating) return;

    // Ensure we have an active conversation
    Conversation conv = state.conversation ??
        _createNewConversation(
          model: state.activeModel ?? ref.read(modelProvider).activeModel,
        );

    final now = DateTime.now();
    final userMessage = ChatMessage(
      id: _uuid.v4(),
      role: 'user',
      content: cleanText,
      createdAt: now,
    );

    final assistantMsgId = _uuid.v4();
    final placeholderAssistant = ChatMessage(
      id: assistantMsgId,
      role: 'assistant',
      content: '',
      createdAt: now.add(const Duration(milliseconds: 10)),
      isStreaming: true,
    );

    // Auto-generate title if this is the first user message
    var currentTitle = conv.title;
    if (conv.messages.isEmpty || currentTitle == 'New Chat') {
      currentTitle = cleanText.length > 32
          ? '${cleanText.substring(0, 32)}...'
          : cleanText;
    }

    conv = conv.copyWith(
      title: currentTitle,
      updatedAt: now,
      messages: [...conv.messages, userMessage, placeholderAssistant],
    );

    state = state.copyWith(
      conversation: conv,
      isGenerating: true,
      errorMessage: null,
    );

    // Persist user message immediately
    ref.read(conversationListProvider.notifier).upsertConversation(conv);

    final settings = ref.read(settingsProvider);
    final baseUrl = settings.ollamaHost;
    final activeModel = conv.model;

    // Prepare message history for Ollama
    final ollamaMessages = <Map<String, String>>[];
    final systemPrompt = conv.systemPrompt ?? settings.systemPrompt;
    if (systemPrompt.isNotEmpty) {
      ollamaMessages.add({'role': 'system', 'content': systemPrompt});
    }

    for (final m in conv.messages) {
      if (m.id == assistantMsgId) continue; // Don't send current empty streaming message
      if (m.error != null) continue;
      ollamaMessages.add({'role': m.role, 'content': m.content});
    }

    final buffer = StringBuffer();

    try {
      final stream = _repository.streamChatCompletion(
        baseUrl: baseUrl,
        model: activeModel,
        messages: ollamaMessages,
        temperature: settings.temperature,
      );

      _streamingSub = stream.listen(
        (chunk) {
          buffer.write(chunk);
          final updatedContent = buffer.toString();

          final updatedMessages = state.conversation!.messages.map((m) {
            if (m.id == assistantMsgId) {
              return m.copyWith(content: updatedContent);
            }
            return m;
          }).toList();

          final updatedConv = state.conversation!.copyWith(
            updatedAt: DateTime.now(),
            messages: updatedMessages,
          );

          state = state.copyWith(conversation: updatedConv);
        },
        onError: (err) {
          _completeAssistantMessage(
            assistantMsgId: assistantMsgId,
            finalContent: buffer.toString(),
            error: err.toString(),
          );
        },
        onDone: () {
          _completeAssistantMessage(
            assistantMsgId: assistantMsgId,
            finalContent: buffer.toString(),
          );
        },
        cancelOnError: true,
      );
    } catch (e) {
      _completeAssistantMessage(
        assistantMsgId: assistantMsgId,
        finalContent: buffer.toString(),
        error: e.toString(),
      );
    }
  }

  void _completeAssistantMessage({
    required String assistantMsgId,
    required String finalContent,
    String? error,
  }) {
    if (state.conversation == null) return;

    final updatedMessages = state.conversation!.messages.map((m) {
      if (m.id == assistantMsgId) {
        return m.copyWith(
          content: finalContent.isNotEmpty
              ? finalContent
              : (error != null ? 'Error: $error' : ''),
          isStreaming: false,
          error: error,
        );
      }
      return m;
    }).toList();

    final updatedConv = state.conversation!.copyWith(
      updatedAt: DateTime.now(),
      messages: updatedMessages,
    );

    state = state.copyWith(
      conversation: updatedConv,
      isGenerating: false,
      errorMessage: error,
    );

    // Save final conversation state
    ref.read(conversationListProvider.notifier).upsertConversation(updatedConv);
  }

  void stopGeneration() {
    _streamingSub?.cancel();
    _streamingSub = null;
    _repository.stopGeneration();

    if (state.conversation != null && state.isGenerating) {
      final updatedMessages = state.conversation!.messages.map((m) {
        if (m.isStreaming) {
          return m.copyWith(isStreaming: false);
        }
        return m;
      }).toList();

      final updatedConv = state.conversation!.copyWith(
        messages: updatedMessages,
      );
      state = state.copyWith(
        conversation: updatedConv,
        isGenerating: false,
      );
      ref.read(conversationListProvider.notifier).upsertConversation(updatedConv);
    }
  }

  void deleteMessage(String messageId) {
    if (state.conversation == null) return;
    final updatedMessages = state.conversation!.messages
        .where((m) => m.id != messageId)
        .toList();
    final updatedConv = state.conversation!.copyWith(
      messages: updatedMessages,
    );
    state = state.copyWith(conversation: updatedConv);
    ref.read(conversationListProvider.notifier).upsertConversation(updatedConv);
  }
}

typedef ChatNotifier = Chat;

