import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../chat/presentation/providers/chat_notifier.dart';
import '../../../models/presentation/providers/model_notifier.dart';
import '../providers/settings_notifier.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController _hostController;
  late final TextEditingController _systemPromptController;
  String? _connectionTestResult;
  bool _isTestingConnection = false;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);
    _hostController = TextEditingController(text: settings.ollamaHost);
    _systemPromptController = TextEditingController(text: settings.systemPrompt);
  }

  @override
  void dispose() {
    _hostController.dispose();
    _systemPromptController.dispose();
    super.dispose();
  }

  Future<void> _testConnection() async {
    setState(() {
      _isTestingConnection = true;
      _connectionTestResult = null;
    });

    final version = await ref.read(settingsProvider.notifier).testConnection();

    if (mounted) {
      setState(() {
        _isTestingConnection = false;
        _connectionTestResult = version != null
            ? 'Connected! (Ollama version: $version)'
            : 'Could not connect to Ollama at ${_hostController.text}';
      });
      // Refresh models after testing connection
      ref.read(modelProvider.notifier).refreshModels();
    }
  }

  void _showClearHistoryConfirm(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Chat History'),
        content: const Text(
            'Are you sure you want to delete all saved conversations? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              ref.read(conversationListProvider.notifier).clearAll();
              ref.read(chatProvider.notifier).startNewChat();
              Navigator.of(context).pop();
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final modelState = ref.watch(modelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Appearance Section
                Text('Appearance', style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.palette, size: 18),
                            SizedBox(width: 12),
                            Text('Theme Mode'),
                          ],
                        ),
                        DropdownButton<String>(
                          value: settings.themeMode,
                          onChanged: (val) {
                            if (val != null) {
                              ref.read(settingsProvider.notifier).updateThemeMode(val);
                            }
                          },
                          items: const [
                            DropdownMenuItem(value: 'system', child: Text('System Default')),
                            DropdownMenuItem(value: 'light', child: Text('Light')),
                            DropdownMenuItem(value: 'dark', child: Text('Dark')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Ollama Connection Section
                Text('Ollama Connection', style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.server, size: 18),
                            SizedBox(width: 12),
                            Text('Server Host URL'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _hostController,
                                decoration: const InputDecoration(
                                  hintText: 'http://127.0.0.1:11434',
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(settingsProvider.notifier).updateHost(_hostController.text);
                                _testConnection();
                              },
                              child: const Text('Save & Apply'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: _isTestingConnection ? null : _testConnection,
                              icon: _isTestingConnection
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const FaIcon(FontAwesomeIcons.arrowsRotate, size: 16),
                              label: const Text('Test Connection'),
                            ),
                            if (_connectionTestResult != null) ...[
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _connectionTestResult!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: _connectionTestResult!.startsWith('Connected')
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Chat Parameters Section
                Text('Chat Parameters', style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Default Model Picker
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                FaIcon(FontAwesomeIcons.sliders, size: 18),
                                SizedBox(width: 12),
                                Text('Default Model'),
                              ],
                            ),
                            if (modelState.installedModels.isNotEmpty)
                              DropdownButton<String>(
                                value: modelState.installedModels.any((m) => m.name == settings.defaultModel)
                                    ? settings.defaultModel
                                    : modelState.installedModels.first.name,
                                onChanged: (val) {
                                  if (val != null) {
                                    ref.read(settingsProvider.notifier).updateDefaultModel(val);
                                  }
                                },
                                items: modelState.installedModels
                                    .map((m) => DropdownMenuItem(value: m.name, child: Text(m.name)))
                                    .toList(),
                              )
                            else
                              const Text('No models installed'),
                          ],
                        ),
                        const Divider(height: 32),
                        // Temperature Slider
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.temperatureHalf, size: 18),
                                    SizedBox(width: 12),
                                    Text('Temperature'),
                                  ],
                                ),
                                // Value placeholder will be added below
                              ],
                            ),
                            const SizedBox(height: 10),
                            Slider(
                              value: settings.temperature.clamp(0.0, 1.0),
                              min: 0.0,
                              max: 1.0,
                              divisions: 100,
                              label: settings.temperature.toStringAsFixed(2),
                              onChanged: (val) {
                                ref.read(settingsProvider.notifier).updateTemperature(val);
                              },
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Lower values produce more deterministic and factual responses; higher values produce more creative output.',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const Divider(height: 32),
                        // System Prompt Editor
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                FaIcon(FontAwesomeIcons.message, size: 18),
                                SizedBox(width: 12),
                                Text('Default System Prompt'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _systemPromptController,
                              minLines: 3,
                              maxLines: 6,
                              decoration: const InputDecoration(
                                hintText: 'You are a helpful assistant...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(settingsProvider.notifier).updateSystemPrompt(
                                    _systemPromptController.text.trim());
                              },
                              child: const Text('Save System Prompt'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Storage Section
                Text('Storage & History', style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Clear Chat History', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(
                              'Permanently remove all conversations stored on this device.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.withValues(alpha: 0.15),
                            foregroundColor: Colors.redAccent,
                          ),
                          onPressed: () => _showClearHistoryConfirm(context),
                          icon: const FaIcon(FontAwesomeIcons.trashCan, size: 14),
                          label: const Text('Clear History'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
