import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';

/// Reusable bottom navigation bar widget
class BottomNavBar extends ConsumerWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = currentIndex;
    final unreadAsync = ref.watch(unreadChatsCountProvider);
    final unread = unreadAsync.value ?? 0;
    final unreadLabel = unread > 99 ? '99+' : '$unread';

    Widget chatIcon(IconData icon) {
      return Badge(
        backgroundColor: Colors.red,
        isLabelVisible: unread > 0,
        label: Text(
          unreadLabel,
          style: const TextStyle(fontSize: 10),
        ),
        child: Icon(icon),
      );
    }

    return NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (selectedIndex) {
        switch (selectedIndex) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/shops');
            break;
          case 2:
            context.go('/chats');
            break;
          case 3:
            context.go('/orders');
            break;
          case 4:
            context.go('/ai');
            break;
          case 5:
            context.go('/profile');
            break;
        }
      },
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        const NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: 'Search',
        ),
        NavigationDestination(
          icon: chatIcon(Icons.chat_bubble_outline),
          selectedIcon: chatIcon(Icons.chat_bubble),
          label: 'Chat',
        ),
        const NavigationDestination(
          icon: Icon(Icons.calendar_today_outlined),
          selectedIcon: Icon(Icons.calendar_today),
          label: 'Bookings',
        ),
        const NavigationDestination(
          icon: Icon(Icons.smart_toy_outlined),
          selectedIcon: Icon(Icons.smart_toy),
          label: 'AI',
        ),
        const NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
