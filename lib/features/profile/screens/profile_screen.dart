import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';

/// Profile screen
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder(
        future: ref.read(authServiceProvider).getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final user = snapshot.data;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (user != null) ...[
                ListTile(
                  title: const Text('Name'),
                  subtitle: Text(user.name),
                ),
                ListTile(
                  title: const Text('Phone'),
                  subtitle: Text(user.phone),
                ),
                if (user.email != null)
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(user.email!),
                  ),
              ],
              const Divider(),
              ListTile(
                leading: const Icon(Icons.bar_chart),
                title: const Text('Statistics'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/stats'),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  await ref.read(authServiceProvider).logout();
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

