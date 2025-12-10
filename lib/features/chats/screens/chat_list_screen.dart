import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/chats/models/chat.dart';

/// Chat list screen
class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: FutureBuilder<List<Chat>>(
        future: ref.read(chatServiceProvider).listChats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chats found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final chat = snapshot.data![index];
              final otherUser = chat.users.isNotEmpty ? chat.users.first : null;
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(otherUser?.name ?? 'Chat'),
                  subtitle: chat.latestMessage != null
                      ? Text(chat.latestMessage!.message)
                      : null,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/chats/${chat.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

