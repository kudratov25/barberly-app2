import 'package:flutter/material.dart';
import 'package:mobile/common/widgets/bottom_nav_bar.dart';

/// AI Screen placeholder
class AIScreen extends StatelessWidget {
  const AIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('AI Assistant'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.smart_toy,
              size: 80,
              color: Color(0xFF0A84FF),
            ),
            SizedBox(height: 16),
            Text(
              'AI Assistant',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coming soon...',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }
}
