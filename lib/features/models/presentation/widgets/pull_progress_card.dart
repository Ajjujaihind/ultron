import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/model_info.dart';
import '../providers/model_notifier.dart';

class PullProgressCard extends ConsumerWidget {
  final PullProgress progress;

  const PullProgressCard({
    super.key,
    required this.progress,
  });

  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = 0;
    double count = bytes.toDouble();
    while (count >= 1024 && i < suffixes.length - 1) {
      count /= 1024;
      i++;
    }
    return '${count.toStringAsFixed(1)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final double? percent = (progress.total != null &&
            progress.total! > 0 &&
            progress.completed != null)
        ? (progress.completed! / progress.total!).clamp(0.0, 1.0)
        : null;
    final formattedCompleted =
        progress.completed != null ? _formatBytes(progress.completed!) : '';
    final formattedTotal =
        progress.total != null ? _formatBytes(progress.total!) : '';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          progress.modelName,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => ref
                      .read(modelProvider.notifier)
                      .cancelPull(progress.modelName),
                  child: const Text('Cancel'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (percent != null) ...[
              LinearProgressIndicator(value: percent),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(progress.status, style: theme.textTheme.bodySmall),
                  Text(
                    '$formattedCompleted / $formattedTotal (${(percent * 100).toStringAsFixed(1)}%)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ] else ...[
              Text(progress.status, style: theme.textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
