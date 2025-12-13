import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Reusable bottom navigation bar widget
class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final index = currentIndex;

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
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline),
          selectedIcon: Icon(Icons.chat_bubble),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_today_outlined),
          selectedIcon: Icon(Icons.calendar_today),
          label: 'Bookings',
        ),
        NavigationDestination(
          icon: Icon(Icons.smart_toy_outlined),
          selectedIcon: Icon(Icons.smart_toy),
          label: 'AI',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
