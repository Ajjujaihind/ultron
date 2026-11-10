import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_theme.dart';

class ChatComposer extends StatefulWidget {
  final bool isGenerating;
  final bool isEnabled;
  final ValueChanged<String> onSend;
  final VoidCallback onStop;

  const ChatComposer({
    super.key,
    required this.isGenerating,
    required this.isEnabled,
    required this.onSend,
    required this.onStop,
  });

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty || widget.isGenerating || !widget.isEnabled) return;
    widget.onSend(text);
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bool hasText = _controller.text.trim().isNotEmpty;
    final bool canSend = hasText && widget.isEnabled && !widget.isGenerating;

    final capsuleBg = isDark ? AppTheme.darkInputSurface : AppTheme.lightInputSurface;
    final capsuleBorder = isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 768),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Floating Capsule Input
              Container(
                decoration: BoxDecoration(
                  color: capsuleBg,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: capsuleBorder, width: 1),
                ),
                padding: const EdgeInsets.only(left: 18, right: 8, top: 4, bottom: 4),
                child: Shortcuts(
                  shortcuts: {
                    LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
                  },
                  child: Actions(
                    actions: {
                      ActivateIntent: CallbackAction<ActivateIntent>(
                        onInvoke: (_) {
                          if (HardwareKeyboard.instance.isShiftPressed) {
                            return null;
                          }
                          _submit();
                          return null;
                        },
                      ),
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            enabled: widget.isEnabled && !widget.isGenerating,
                            minLines: 1,
                            maxLines: 6,
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 15,
                              height: 1.4,
                            ),
                            decoration: InputDecoration(
                              hintText: widget.isEnabled
                                  ? 'Message Ultron...'
                                  : 'Select or download a model first...',
                              hintStyle: TextStyle(
                                color: textSecondary,
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              filled: false,
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: widget.isGenerating
                              ? _buildStopButton(isDark)
                              : _buildSendButton(canSend, isDark),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Subtle ChatGPT-style disclaimer
              Text(
                'Ultron can make mistakes. Verify important information.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: textSecondary.withValues(alpha: 0.7),
                  letterSpacing: -0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStopButton(bool isDark) {
    return Tooltip(
      message: 'Stop generating',
      child: InkWell(
        onTap: widget.onStop,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isDark ? Colors.white : Colors.black,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendButton(bool canSend, bool isDark) {
    final activeBg = isDark ? Colors.white : Colors.black;
    final activeIcon = isDark ? Colors.black : Colors.white;
    final disabledBg = isDark ? const Color(0xFF424242) : const Color(0xFFE5E5E5);
    final disabledIcon = isDark ? const Color(0xFF8E8E8E) : const Color(0xFFA3A3A3);

    return Tooltip(
      message: 'Send message',
      child: InkWell(
        onTap: canSend ? _submit : null,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: canSend ? activeBg : disabledBg,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.arrowUp,
              size: 14,
              color: canSend ? activeIcon : disabledIcon,
            ),
          ),
        ),
      ),
    );
  }
}
