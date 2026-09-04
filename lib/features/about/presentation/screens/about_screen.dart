import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../../../core/constants/app_constants.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MacosScaffold(
      toolBar: const ToolBar(
        title: Text('About'),
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
                    size: 72,
                    color: MacosTheme.of(context).primaryColor.withValues(
                      alpha: 0.8,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppConstants.appName,
                    style: MacosTheme.of(context).typography.largeTitle,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version ${AppConstants.appVersion}',
                    style: MacosTheme.of(context).typography.subheadline,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppConstants.appDescription,
                    style: MacosTheme.of(context).typography.subheadline,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Chat privately with AI running directly on your Mac.\nPowered by Ollama.',
                    textAlign: TextAlign.center,
                    style: MacosTheme.of(context).typography.footnote,
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
