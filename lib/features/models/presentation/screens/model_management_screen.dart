import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

class ModelManagementScreen extends ConsumerWidget {
  const ModelManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MacosScaffold(
      toolBar: const ToolBar(
        title: Text('Model Management'),
        titleWidth: 250,
        actions: [
          ToolBarIconButton(
            label: 'Refresh',
            icon: MacosIcon(CupertinoIcons.refresh),
            showLabel: false,
            onPressed: null,
          ),
        ],
      ),
      children: [
        ContentArea(
          builder: (context, scrollController) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Installed Models',
                        style: MacosTheme.of(context).typography.headline,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: MacosTheme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: MacosTheme.of(context).dividerColor,
                          ),
                        ),
                        child: Text(
                          'No models installed.\nConnect to Ollama to see available models.',
                          textAlign: TextAlign.center,
                          style:
                              MacosTheme.of(context).typography.subheadline,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Pull New Model',
                        style: MacosTheme.of(context).typography.headline,
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Expanded(
                            child: MacosTextField(
                              placeholder:
                                  'e.g. llama3.2, gemma3, mistral',
                            ),
                          ),
                          SizedBox(width: 8),
                          PushButton(
                            controlSize: ControlSize.regular,
                            onPressed: null,
                            child: Text('Pull'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
