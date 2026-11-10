import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/model_notifier.dart';

class RecommendedModelsList extends ConsumerWidget {
  final ModelState modelState;

  const RecommendedModelsList({
    super.key,
    required this.modelState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final installedNames =
        modelState.installedModels.map((m) => m.name).toSet();
    final activePulls = modelState.activePulls.keys.toSet();

    return Column(
      children: recommendedModels.map((preset) {
        final isInstalled = installedNames.contains(preset.tag) ||
            installedNames.contains('${preset.tag}:latest');
        final isPulling = activePulls.contains(preset.tag);

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
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
                            preset.displayName,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  theme.dividerColor.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              preset.approxDownloadSize,
                              style: theme.textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(preset.description, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                if (isPulling)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(),
                  )
                else if (isInstalled)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.chatgptGreen.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(FontAwesomeIcons.check, color: AppTheme.chatgptGreen, size: 12),
                        SizedBox(width: 6),
                        Text(
                          'Installed',
                          style: TextStyle(
                            color: AppTheme.chatgptGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: modelState.isConnected
                        ? () => ref
                            .read(modelProvider.notifier)
                            .pullModel(preset.tag)
                        : null,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(FontAwesomeIcons.download, size: 13),
                        SizedBox(width: 6),
                        Text('Download'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
