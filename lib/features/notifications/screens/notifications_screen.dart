import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Simple Notifications page – UI only, grouped by type.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    String _formatTime(DateTime dt) {
      return DateFormat('HH:mm').format(dt);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionHeader(title: 'Orders'),
          _NotificationTile(
            icon: Icons.event_available,
            title: 'Your booking with Jamshid Barber is confirmed',
            time: _formatTime(now.subtract(const Duration(minutes: 10))),
          ),
          _NotificationTile(
            icon: Icons.alarm,
            title: 'Your appointment starts in 1 hour',
            time: _formatTime(now.subtract(const Duration(hours: 1))),
          ),
          _NotificationTile(
            icon: Icons.check_circle_outline,
            title: 'Order completed',
            time: _formatTime(now.subtract(const Duration(hours: 3))),
          ),
          const SizedBox(height: 24),
          const _SectionHeader(title: 'Chat'),
          _NotificationTile(
            icon: Icons.chat_bubble_outline,
            title: 'You have a new message from Shox Barber',
            time: _formatTime(now.subtract(const Duration(minutes: 5))),
          ),
          const SizedBox(height: 24),
          const _SectionHeader(title: 'System'),
          _NotificationTile(
            icon: Icons.location_on_outlined,
            title: 'New shops near you',
            time: _formatTime(now.subtract(const Duration(days: 1))),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF212121),
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;

  const _NotificationTile({
    required this.icon,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF0A84FF), Color(0xFF4DA8FF)],
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF212121),
          ),
        ),
        subtitle: Text(
          time,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF757575),
          ),
        ),
        onTap: () {
          // UI-only: navigation to related page can be wired later.
        },
      ),
    );
  }
}

