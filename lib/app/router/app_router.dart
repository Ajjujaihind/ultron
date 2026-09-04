import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../features/about/presentation/screens/about_screen.dart';
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

class AppShell extends StatelessWidget {
  const AppShell({
    required this.child,
    required this.currentPath,
    super.key,
  });

  final Widget child;
  final String currentPath;

  int get _selectedIndex {
    if (currentPath.startsWith('/settings')) return 1;
    if (currentPath.startsWith('/models')) return 2;
    if (currentPath.startsWith('/about')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.keyN, meta: true): () {
          context.go('/chat');
        },
        const SingleActivator(LogicalKeyboardKey.comma, meta: true): () {
          context.go('/settings');
        },
      },
      child: Focus(
        autofocus: true,
        child: MacosWindow(
          sidebar: Sidebar(
            minWidth: 220,
            builder: (context, scrollController) {
              return SidebarItems(
                currentIndex: _selectedIndex,
                onChanged: (index) {
                  switch (index) {
                    case 0:
                      context.go('/chat');
                    case 1:
                      context.go('/settings');
                    case 2:
                      context.go('/models');
                    case 3:
                      context.go('/about');
                  }
                },
                items: const [
                  SidebarItem(
                    leading: MacosIcon(CupertinoIcons.chat_bubble_text),
                    label: Text('Chat'),
                  ),
                  SidebarItem(
                    leading: MacosIcon(CupertinoIcons.gear),
                    label: Text('Settings'),
                  ),
                  SidebarItem(
                    leading: MacosIcon(CupertinoIcons.cloud_download),
                    label: Text('Models'),
                  ),
                  SidebarItem(
                    leading: MacosIcon(CupertinoIcons.info),
                    label: Text('About'),
                  ),
                ],
              );
            },
          ),
          child: child,
        ),
      ),
    );
  }
}
