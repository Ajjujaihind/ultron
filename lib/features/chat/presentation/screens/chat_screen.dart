import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../../../core/constants/app_constants.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({this.conversationId, super.key});

  final String? conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (conversationId == null) {
      return _EmptyChatView();
    }
    return _ChatView(conversationId: conversationId!);
  }
}

class _EmptyChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: const ToolBar(
        title: Text(AppConstants.appName),
        titleWidth: 200,
      ),
      children: [
        ContentArea(
          builder: (context, scrollController) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.chat_bubble_text,
                    size: 64,
                    color: MacosTheme.of(context).primaryColor.withValues(
                      alpha: 0.3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome to ${AppConstants.appName}',
                    style: MacosTheme.of(context).typography.largeTitle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Chat privately with AI running directly\non your Mac.',
                    textAlign: TextAlign.center,
                    style: MacosTheme.of(context).typography.subheadline,
                  ),
                  const SizedBox(height: 24),
                  PushButton(
                    controlSize: ControlSize.large,
                    onPressed: () {},
                    child: const Text('Start New Chat'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView({required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
        title: Text(conversationId),
        actions: [
          ToolBarIconButton(
            label: 'Model',
            icon: const MacosIcon(CupertinoIcons.square_stack),
            showLabel: false,
            onPressed: () {},
          ),
        ],
      ),
      children: [
        ContentArea(
          builder: (context, scrollController) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Messages will appear here',
                          style: MacosTheme.of(context).typography.subheadline,
                        ),
                      ),
                    ),
                    _Composer(),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _Composer extends StatefulWidget {
  @override
  State<_Composer> createState() => _ComposerState();
}

class _ComposerState extends State<_Composer> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: MacosTextField(
              controller: _controller,
              placeholder: 'Ask anything...',
              minLines: 1,
              maxLines: 5,
            ),
          ),
          const SizedBox(width: 8),
          PushButton(
            controlSize: ControlSize.regular,
            onPressed: _controller.text.isEmpty ? null : () {},
            child: const MacosIcon(CupertinoIcons.arrow_up),
          ),
        ],
      ),
    );
  }
}
