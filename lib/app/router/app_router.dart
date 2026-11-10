import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'responsive_app_shell.dart';

import '../../features/about/presentation/screens/about_screen.dart';
import '../../features/chat/presentation/providers/chat_notifier.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/models/presentation/screens/model_management_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/chat',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppShell(
        currentPath: state.uri.path,
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/chat',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ChatScreen(),
          ),
        ),
        GoRoute(
          path: '/chat/:conversationId',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChatScreen(
              conversationId: state.pathParameters['conversationId'],
            ),
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
        GoRoute(
          path: '/models',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ModelManagementScreen(),
          ),
        ),
        GoRoute(
          path: '/about',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AboutScreen(),
          ),
        ),
      ],
    ),
  ],
);

class AppShell extends ConsumerWidget {
  const AppShell({
    required this.child,
    required this.currentPath,
    super.key,
  });

  final Widget child;
  final String currentPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.keyN, meta: true): () {
          ref.read(chatProvider.notifier).startNewChat();
          context.go('/chat');
        },
        const SingleActivator(LogicalKeyboardKey.comma, meta: true): () {
          context.go('/settings');
        },
      },
      child: Focus(
        autofocus: true,
        child: ResponsiveAppShell(
          currentPath: currentPath,
          child: child,
        ),
      ),
    );
  }
}
