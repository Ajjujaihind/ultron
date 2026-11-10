import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_theme.dart';

class PromptSuggestions extends StatelessWidget {
  final ValueChanged<String> onSelectPrompt;

  const PromptSuggestions({super.key, required this.onSelectPrompt});

  static final List<Map<String, dynamic>> _suggestions = [
    {
      'icon': FontAwesomeIcons.lightbulb,
      'title': 'Explain a concept',
      'prompt': 'Explain quantum computing in simple terms with real-world analogies.',
    },
    {
      'icon': FontAwesomeIcons.code,
      'title': 'Write code',
      'prompt': 'Write a Python script to find duplicate files in a folder and output their sizes.',
    },
    {
      'icon': FontAwesomeIcons.envelope,
      'title': 'Draft an email',
      'prompt': 'Draft a professional and polite email requesting an update on a project timeline.',
    },
    {
      'icon': FontAwesomeIcons.penToSquare,
      'title': 'Brainstorm ideas',
      'prompt': 'Give me 5 creative ideas for side projects using local AI and Flutter.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardBg = isDark ? AppTheme.darkSurface : AppTheme.lightSurface;
    final cardBorder = isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder;
    final textPrimary = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final textSecondary = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 768),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: _suggestions.map((item) {
            final icon = item['icon'] as IconData;
            final title = item['title'] as String;
            final prompt = item['prompt'] as String;

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onSelectPrompt(prompt),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: cardBorder, width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF383838) : const Color(0xFFEAEAEA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FaIcon(
                          icon,
                          size: 14,
                          color: AppTheme.chatgptGreen,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              prompt,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 12,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
