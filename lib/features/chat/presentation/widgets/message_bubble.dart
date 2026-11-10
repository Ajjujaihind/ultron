import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/models/chat_message.dart';

class MessageBubble extends StatefulWidget {
  final ChatMessage message;
  final VoidCallback? onDelete;

  const MessageBubble({
    super.key,
    required this.message,
    this.onDelete,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool _copied = false;

  bool get _isUser => widget.message.role == 'user';

  void _copyContent() {
    if (widget.message.content.isEmpty) return;
    Clipboard.setData(ClipboardData(text: widget.message.content));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final userBubbleColor = isDark ? AppTheme.darkUserBubble : AppTheme.lightUserBubble;
    final userTextColor = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final assistantTextColor = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 768),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: _isUser
              ? _buildUserMessage(userBubbleColor, userTextColor)
              : _buildAssistantMessage(theme, isDark, assistantTextColor),
        ),
      ),
    );
  }

  Widget _buildUserMessage(Color bubbleColor, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 48),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(22),
            ),
            child: SelectionArea(
              child: Text(
                widget.message.content,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssistantMessage(ThemeData theme, bool isDark, Color textColor) {
    final hasContent = widget.message.content.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ChatGPT style Avatar
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2E2E2E) : const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isDark ? const Color(0xFF404040) : const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.wandMagicSparkles,
              color: AppTheme.chatgptGreen,
              size: 13,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Message Text or Thinking State
              if (!hasContent && widget.message.isStreaming)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppTheme.chatgptGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Thinking...',
                        style: TextStyle(
                          color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                )
              else
                SelectionArea(
                  child: Text(
                    widget.message.content,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      height: 1.6,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),

              // Streaming animated cursor indicator
              if (widget.message.isStreaming && hasContent) ...[
                const SizedBox(height: 4),
                Container(
                  width: 8,
                  height: 15,
                  margin: const EdgeInsets.only(left: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.chatgptGreen,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],

              // Error display
              if (widget.message.error != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.circleExclamation,
                        color: Colors.redAccent,
                        size: 13,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          widget.message.error!,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Bottom subtle action toolbar (Copy, Time)
              if (hasContent && !widget.message.isStreaming) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: _copyContent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              _copied ? FontAwesomeIcons.check : FontAwesomeIcons.copy,
                              size: 12,
                              color: _copied
                                  ? AppTheme.chatgptGreen
                                  : (isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _copied ? 'Copied' : 'Copy',
                              style: TextStyle(
                                fontSize: 12,
                                color: _copied
                                    ? AppTheme.chatgptGreen
                                    : (isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatTime(widget.message.createdAt),
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? AppTheme.darkTextSecondary.withValues(alpha: 0.6) : AppTheme.lightTextSecondary.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$hour:$min';
  }
}
