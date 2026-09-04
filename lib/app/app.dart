import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../core/constants/app_constants.dart';
import 'router/app_router.dart';

class UltronApp extends ConsumerWidget {
  const UltronApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MacosApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}

final themeModeProvider = StateProvider<ThemeMode>(
  (ref) => ThemeMode.system,
  name: 'themeModeProvider',
);
