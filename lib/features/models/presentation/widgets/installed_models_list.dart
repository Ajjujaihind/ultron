import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/model_notifier.dart';

class InstalledModelsList extends ConsumerWidget {
  final ModelState modelState;

  const InstalledModelsList({
    super.key,
    required this.modelState,
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

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, String modelName) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Model'),
        content: Text(
          'Are you sure you want to delete "$modelName"? This will permanently remove the model files from your device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              ref.read(modelProvider.notifier).deleteModel(modelName);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    if (modelState.isLoading && modelState.installedModels.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 12),
                Text('Checking for installed models...'),
              ],
            ),
          ),
        ),
      );
    }

    if (modelState.installedModels.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(FontAwesomeIcons.boxOpen, size: 44, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No models installed yet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Download one of the recommended models below to get started.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: modelState.installedModels.map((model) {
        final isSelected = model.name == modelState.activeModel;
        final paramSize = model.details?.parameterSize ?? '';
        final quant = model.details?.quantizationLevel ?? '';
        final sizeStr = _formatBytes(model.size);

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isSelected
                  ? theme.colorScheme.primary.withValues(alpha: 0.6)
                  : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.database,
                  color: isSelected ? theme.colorScheme.primary : Colors.grey,
                  size: 24,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Text(
                            model.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isSelected)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'ACTIVE CHAT MODEL',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        [
                          if (paramSize.isNotEmpty) 'Params: $paramSize',
                          if (quant.isNotEmpty) 'Quant: $quant',
                          'Disk: $sizeStr',
                        ].join('  •  '),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (!isSelected)
                  OutlinedButton(
                    onPressed: () => ref
                        .read(modelProvider.notifier)
                        .selectActiveModel(model.name),
                    child: const Text('Use for Chat'),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.chatgptGreen.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Selected',
                      style: TextStyle(
                        color: AppTheme.chatgptGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.trashCan, color: Colors.red, size: 16),
                  tooltip: 'Delete',
                  onPressed: () =>
                      _showDeleteConfirmation(context, ref, model.name),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
