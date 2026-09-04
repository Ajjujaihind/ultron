import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../../../app/app.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);

    return MacosScaffold(
      toolBar: const ToolBar(
        title: Text('Settings'),
        titleWidth: 200,
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
                        'Appearance',
                        style: MacosTheme.of(context).typography.headline,
                      ),
                      const SizedBox(height: 12),
                      MacosListTile(
                        leading: const MacosIcon(CupertinoIcons.paintbrush),
                        title: const Text('Theme'),
                        subtitle: Text(
                          currentThemeMode.name[0].toUpperCase() +
                              currentThemeMode.name.substring(1),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Chat',
                        style: MacosTheme.of(context).typography.headline,
                      ),
                      const SizedBox(height: 12),
                      const MacosListTile(
                        leading: MacosIcon(CupertinoIcons.gear_alt),
                        title: Text('Default Model'),
                        subtitle: Text('Not configured'),
                      ),
                      const MacosListTile(
                        leading: MacosIcon(CupertinoIcons.thermometer),
                        title: Text('Temperature'),
                        subtitle: Text('0.7'),
                      ),
                      const MacosListTile(
                        leading: MacosIcon(CupertinoIcons.chat_bubble),
                        title: Text('System Prompt'),
                        subtitle: Text('Default'),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Ollama',
                        style: MacosTheme.of(context).typography.headline,
                      ),
                      const SizedBox(height: 12),
                      const MacosListTile(
                        leading: MacosIcon(CupertinoIcons.cloud),
                        title: Text('Server URL'),
                        subtitle: Text('http://127.0.0.1:11434'),
                      ),
                      MacosListTile(
                        leading: const MacosIcon(CupertinoIcons.refresh),
                        title: const Text('Test Connection'),
                        subtitle: const Text('Not connected'),
                        onClick: () {},
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Storage',
                        style: MacosTheme.of(context).typography.headline,
                      ),
                      const SizedBox(height: 12),
                      MacosListTile(
                        leading: MacosIcon(
                          CupertinoIcons.trash,
                          color: MacosTheme.of(context).primaryColor,
                        ),
                        title: const Text('Clear Chat History'),
                        subtitle: const Text('Remove all conversations'),
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
