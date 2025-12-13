import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/common/providers/theme_mode_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final notifier = ref.read(themeModeProvider.notifier);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            tooltip: isDark ? 'Dark mode: ON' : 'Dark mode: OFF',
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              notifier.setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              title: const Text('Dark mode'),
              subtitle: Text(isDark ? 'ON' : 'OFF'),
              trailing: IconButton(
                icon: Icon(isDark ? Icons.toggle_on : Icons.toggle_off),
                iconSize: 36,
                onPressed: () {
                  notifier.setThemeMode(
                    isDark ? ThemeMode.light : ThemeMode.dark,
                  );
                },
              ),
              onTap: () {
                notifier.setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
              },
            ),
          ),
        ],
      ),
    );
  }
}


