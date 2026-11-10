import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../models/presentation/providers/model_notifier.dart';
import '../providers/chat_notifier.dart';
import '../widgets/chat_composer.dart';
import '../widgets/message_bubble.dart';
import '../widgets/prompt_suggestions.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({this.conversationId, super.key});

  final String? conversationId;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.conversationId != null) {
        ref.read(chatProvider.notifier).loadConversation(widget.conversationId!);
      }
    });
  }

  @override
  void didUpdateWidget(covariant ChatScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.conversationId != oldWidget.conversationId && widget.conversationId != null) {
      ref.read(chatProvider.notifier).loadConversation(widget.conversationId!);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
      );
    }
  }

  void _showDeleteConversationDialog(BuildContext context, String convId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Conversation'),
        content: const Text('Are you sure you want to delete this chat history? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              ref.read(conversationListProvider.notifier).deleteConversation(convId);
              ref.read(chatProvider.notifier).startNewChat();
              Navigator.of(ctx).pop();
              context.go('/chat');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showHistorySheet(BuildContext context) {
    final conversations = ref.read(conversationListProvider);
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Chat History', style: theme.textTheme.headlineSmall),
                  TextButton(
                    
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      ref.read(chatProvider.notifier).startNewChat();
                      context.go('/chat');
                    },
                    child: const Text('New Chat'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (conversations.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: Text('No previous conversations.')),
                )
              else
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 340),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: conversations.length,
                    itemBuilder: (c, index) {
                      final conv = conversations[index];
                      return ListTile(
                        leading: const FaIcon(FontAwesomeIcons.commentDots, size: 18),
                        title: Text(conv.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('${conv.model} • ${conv.messages.length} messages'),
                        onTap: () {
                          ref.read(chatProvider.notifier).loadConversation(conv.id);
                          Navigator.of(ctx).pop();
                          context.go('/chat/${conv.id}');
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ModelState modelState, String activeModel) {
    final theme = Theme.of(context);
    if (!modelState.isConnected) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 520),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: theme.canvasColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FaIcon(FontAwesomeIcons.triangleExclamation, size: 52, color: Colors.red),
              const SizedBox(height: 16),
              Text('Ollama Connection Offline', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 10),
              Text(
                'Ultron connects to Ollama running locally on your machine (default: http://127.0.0.1:11434) to run AI models offline.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.dividerColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('HOW TO START OLLAMA:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.6, color: Colors.grey)),
                    SizedBox(height: 8),
                    Text('1. If not installed, open Terminal and run:', style: TextStyle(fontSize: 12)),
                    SizedBox(height: 4),
                    SelectableText('brew install ollama', style: TextStyle(fontFamily: 'Courier', fontSize: 13, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Text('2. Start the Ollama background service:', style: TextStyle(fontSize: 12)),
                    SizedBox(height: 4),
                    SelectableText('ollama serve', style: TextStyle(fontFamily: 'Courier', fontSize: 13, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Text('(Or open the Ollama app from your Applications folder)', style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => ref.read(modelProvider.notifier).refreshModels(),
                    icon: const FaIcon(FontAwesomeIcons.arrowsRotate, size: 14),
                    label: const Text('Check Connection'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/settings'),
                    icon: const FaIcon(FontAwesomeIcons.gear, size: 14),
                    label: const Text('Settings'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    if (modelState.installedModels.isEmpty) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.canvasColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(FontAwesomeIcons.cubes, size: 48, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text('No Models Installed', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('You need to download at least one model to start chatting. Recommended: Llama 3.2 (3B) or Llama 3.2 (1B).', textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => context.go('/models'),
                icon: const FaIcon(FontAwesomeIcons.cloudArrowDown, size: 16),
                label: const Text('Go to Model Management'),
              ),
            ],
          ),
        ),
      );
    }

    // Default welcome state (with ChatGPT styling)
    final isDark = theme.brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 768),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 28),
              // ChatGPT-style Sparkles / Ultron icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2E2E2E) : const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: isDark ? const Color(0xFF3E3E3E) : const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.wandMagicSparkles,
                    size: 22,
                    color: AppTheme.chatgptGreen,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'What can I help with today?',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              PromptSuggestions(
                onSelectPrompt: (prompt) {
                  ref.read(chatProvider.notifier).sendMessage(prompt);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final modelState = ref.watch(modelProvider);
    final conversation = chatState.conversation;
    final messages = conversation?.messages ?? [];
    final activeModel = chatState.activeModel ?? conversation?.model ?? modelState.activeModel ?? 'No Model';
    final hasInstalledModels = modelState.installedModels.isNotEmpty;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Auto-scroll listener
    ref.listen(chatProvider, (previous, next) {
      if (next.isGenerating || (previous?.conversation?.messages.length != next.conversation?.messages.length)) {
        Future.microtask(_scrollToBottom);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: PopupMenuButton<String>(
          tooltip: 'Select Model',
          onSelected: (value) => ref.read(chatProvider.notifier).setModel(value),
          position: PopupMenuPosition.under,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          itemBuilder: (ctx) => modelState.installedModels.map((model) {
            final isSelected = model.name == activeModel;
            return PopupMenuItem<String>(
              value: model.name,
              child: Row(
                children: [
                  FaIcon(
                    isSelected ? FontAwesomeIcons.solidCircleCheck : FontAwesomeIcons.cube,
                    size: 14,
                    color: isSelected ? AppTheme.chatgptGreen : null,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    model.name,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2E2E2E) : const Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  conversation?.title != null && conversation!.title != AppConstants.appName
                      ? conversation.title
                      : 'Ultron',
                  style: TextStyle(
                    color: isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  activeModel,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                  ),
                ),
                const SizedBox(width: 6),
                FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: 10,
                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                ),
              ],
            ),
          ),
        ),
        actions: [
          // Connection indicator
          IconButton(
            tooltip: modelState.isConnected ? 'Connected to Ollama' : 'Disconnected from Ollama',
            icon: FaIcon(
              modelState.isConnected ? FontAwesomeIcons.solidCircle : FontAwesomeIcons.circle,
              color: modelState.isConnected ? AppTheme.chatgptGreen : Colors.red,
              size: 10,
            ),
            onPressed: () => ref.read(modelProvider.notifier).refreshModels(),
          ),
          // History button
          IconButton(
            tooltip: 'Chat History',
            icon: const FaIcon(FontAwesomeIcons.clockRotateLeft, size: 16),
            onPressed: () => _showHistorySheet(context),
          ),
          // New chat button
          IconButton(
            tooltip: 'New Chat',
            icon: const FaIcon(FontAwesomeIcons.penToSquare, size: 16),
            onPressed: () {
              ref.read(chatProvider.notifier).startNewChat();
              context.go('/chat');
            },
          ),
          // Delete chat button
          if (conversation != null && messages.isNotEmpty)
            IconButton(
              tooltip: 'Delete Chat',
              icon: const FaIcon(FontAwesomeIcons.trashCan, size: 15),
              onPressed: () => _showDeleteConversationDialog(context, conversation.id),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? _buildEmptyState(context, modelState, activeModel)
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: messages.length,
                      itemBuilder: (ctx, index) {
                        final msg = messages[index];
                        return MessageBubble(
                          key: ValueKey(msg.id),
                          message: msg,
                          onDelete: () => ref.read(chatProvider.notifier).deleteMessage(msg.id),
                        );
                      },
                    ),
            ),
            ChatComposer(
              isGenerating: chatState.isGenerating,
              isEnabled: hasInstalledModels && modelState.isConnected,
              onSend: (text) => ref.read(chatProvider.notifier).sendMessage(text),
              onStop: () => ref.read(chatProvider.notifier).stopGeneration(),
            ),
          ],
        ),
      ),
    );
  }
}
