import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/model_notifier.dart';

class ConnectionBanner extends ConsumerWidget {
  final ModelState modelState;

  const ConnectionBanner({
    super.key,
    required this.modelState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    if (modelState.isConnected) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.chatgptGreen.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.chatgptGreen.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const FaIcon(FontAwesomeIcons.solidCircleCheck, color: AppTheme.chatgptGreen, size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Connected to Ollama (version: ${modelState.serverVersion ?? "online"})',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.chatgptGreen,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FaIcon(FontAwesomeIcons.circleExclamation, color: Colors.red, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ollama Is Not Running or Unreachable',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Please start the Ollama application on your device or run "ollama serve" in your terminal. You can configure the server host in Settings.',
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () => ref.read(modelProvider.notifier).refreshModels(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
