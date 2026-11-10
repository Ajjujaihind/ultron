import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/model_notifier.dart';
import '../widgets/connection_banner.dart';
import '../widgets/installed_models_list.dart';
import '../widgets/pull_progress_card.dart';
import '../widgets/recommended_models_list.dart';

class ModelManagementScreen extends ConsumerStatefulWidget {
  const ModelManagementScreen({super.key});

  @override
  ConsumerState<ModelManagementScreen> createState() => _ModelManagementScreenState();
}

class _ModelManagementScreenState extends ConsumerState<ModelManagementScreen> {
  final TextEditingController _modelInputController = TextEditingController();

  @override
  void dispose() {
    _modelInputController.dispose();
    super.dispose();
  }

  void onPull(String modelName) {
    final clean = modelName.trim();
    if (clean.isEmpty) return;
    ref.read(modelProvider.notifier).pullModel(clean);
    _modelInputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final modelState = ref.watch(modelProvider);
    final isConnected = modelState.isConnected;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Model Management'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const FaIcon(FontAwesomeIcons.arrowsRotate, size: 16),
            onPressed: () => ref.read(modelProvider.notifier).refreshModels(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Connection Status Banner
                ConnectionBanner(modelState: modelState),
                const SizedBox(height: 24),

                // Active Downloads / Pulls
                if (modelState.activePulls.isNotEmpty) ...[
                  Text('Active Downloads', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  ...modelState.activePulls.values.map(
                    (p) => PullProgressCard(progress: p),
                  ),
                  const SizedBox(height: 28),
                ],

                // Installed Models Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Installed Models', style: theme.textTheme.titleLarge),
                    Text(
                      '${modelState.installedModels.length} models available',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                InstalledModelsList(modelState: modelState),
                const SizedBox(height: 32),

                // Pull Custom Model Field
                Text('Pull Any Model', style: theme.textTheme.titleLarge),
                const SizedBox(height: 6),
                const Text(
                  'Enter any model tag from the Ollama library (e.g. llama3.2, mistral, codellama, qwen2.5:14b).',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _modelInputController,
                        decoration: const InputDecoration(
                          hintText: 'e.g. llama3.2:1b, mistral, deepseek-r1:7b',
                        ),
                        onSubmitted: isConnected ? onPull : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: isConnected
                          ? () => onPull(_modelInputController.text)
                          : null,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(FontAwesomeIcons.cloudArrowDown, size: 16),
                          SizedBox(width: 8),
                          Text('Pull Model'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),

                // Recommended Models Presets
                Text('Recommended Models', style: theme.textTheme.titleLarge),
                const SizedBox(height: 6),
                const Text(
                  'Optimized models that run great on Apple Silicon Macs.',
                ),
                const SizedBox(height: 16),
                RecommendedModelsList(modelState: modelState),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
