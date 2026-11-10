import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ResponsiveAppShell extends ConsumerWidget {
  const ResponsiveAppShell({
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

  static const List<_NavItem> _items = [
    _NavItem(icon: FontAwesomeIcons.solidComments, label: 'Chat'),
    _NavItem(icon: FontAwesomeIcons.gear, label: 'Settings'),
    _NavItem(icon: FontAwesomeIcons.cubes, label: 'Models'),
    _NavItem(icon: FontAwesomeIcons.circleInfo, label: 'About'),
  ];

  void _onItemTap(WidgetRef ref, BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/chat');
        break;
      case 1:
        context.go('/settings');
        break;
      case 2:
        context.go('/models');
        break;
      case 3:
        context.go('/about');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = _selectedIndex;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 720) {
        // Wide screen: NavigationRail (ChatGPT Sidebar style)
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: selected,
                onDestinationSelected: (index) => _onItemTap(ref, context, index),
                labelType: NavigationRailLabelType.all,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 20),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF282828) : const Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.wandMagicSparkles,
                        color: Color(0xFF10A37F),
                        size: 16,
                      ),
                    ),
                  ),
                ),
                destinations: _items
                    .map((item) => NavigationRailDestination(
                          icon: FaIcon(item.icon, size: 18),
                          selectedIcon: FaIcon(item.icon, size: 18),
                          label: Text(item.label),
                        ))
                    .toList(),
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: child),
            ],
          ),
        );
      } else if (constraints.maxWidth >= 400) {
        // Medium screen: Drawer
        return Scaffold(
          appBar: AppBar(title: const Text('Ultron')),
          drawer: Drawer(
            backgroundColor: isDark ? const Color(0xFF171717) : const Color(0xFFF9F9F9),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF212121) : const Color(0xFFF0F0F0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10A37F).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.wandMagicSparkles,
                            color: Color(0xFF10A37F),
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Ultron',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                for (var i = 0; i < _items.length; i++)
                  ListTile(
                    leading: FaIcon(
                      _items[i].icon,
                      size: 18,
                      color: i == selected ? const Color(0xFF10A37F) : null,
                    ),
                    title: Text(
                      _items[i].label,
                      style: TextStyle(
                        fontWeight: i == selected ? FontWeight.w600 : FontWeight.normal,
                        color: i == selected ? const Color(0xFF10A37F) : null,
                      ),
                    ),
                    selected: i == selected,
                    selectedTileColor: isDark ? const Color(0xFF212121) : const Color(0xFFEFEFEF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onTap: () {
                      Navigator.of(context).pop();
                      _onItemTap(ref, context, i);
                    },
                  ),
              ],
            ),
          ),
          body: child,
        );
      } else {
        // Small screen: BottomNavigationBar
        return Scaffold(
          appBar: AppBar(title: const Text('Ultron')),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selected,
            backgroundColor: isDark ? const Color(0xFF171717) : const Color(0xFFFFFFFF),
            selectedItemColor: const Color(0xFF10A37F),
            unselectedItemColor: isDark ? const Color(0xFF8E8E8E) : const Color(0xFF6E6E6E),
            onTap: (index) => _onItemTap(ref, context, index),
            items: _items
                .map((item) => BottomNavigationBarItem(
                      icon: FaIcon(item.icon, size: 18),
                      label: item.label,
                    ))
                .toList(),
          ),
        );
      }
    });
  }
}

class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}
