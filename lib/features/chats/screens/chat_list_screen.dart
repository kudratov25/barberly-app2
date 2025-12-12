import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/chats/models/chat.dart';
import 'package:intl/intl.dart';

/// Chat list screen with modern design
class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Chat>>(
        future: ref.read(chatServiceProvider).listChats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No chats yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF757575),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Start a conversation with your barber',
                    style: TextStyle(color: Color(0xFF757575)),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              // Trigger rebuild
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final chat = snapshot.data![index];
                return _ChatCard(chat: chat);
              },
            ),
          );
        },
      ),
    );
  }
}

class _ChatCard extends StatelessWidget {
  final Chat chat;

  const _ChatCard({required this.chat});

  @override
  Widget build(BuildContext context) {
    final otherUser = chat.users.isNotEmpty ? chat.users.first : null;
    final hasUnread = chat.latestMessage?.isRead == false;

    DateTime? _parseCreatedAt(String? value) {
      if (value == null || value.isEmpty) return null;
      try {
        return DateTime.parse(value);
      } catch (_) {
        return null;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/chats/${chat.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    otherUser?.name[0].toUpperCase() ?? 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Chat info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          otherUser?.name ?? 'Chat',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                hasUnread ? FontWeight.bold : FontWeight.w600,
                            color: const Color(0xFF212121),
                          ),
                        ),
                        if (_parseCreatedAt(chat.latestMessage?.createdAt) !=
                            null)
                          Text(
                            DateFormat('HH:mm').format(
                              _parseCreatedAt(
                                chat.latestMessage?.createdAt,
                              )!,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: hasUnread
                                  ? const Color(0xFF2196F3)
                                  : const Color(0xFF757575),
                              fontWeight:
                                  hasUnread ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            chat.latestMessage?.message ?? 'No messages yet',
                            style: TextStyle(
                              fontSize: 14,
                              color: hasUnread
                                  ? const Color(0xFF212121)
                                  : const Color(0xFF757575),
                              fontWeight:
                                  hasUnread ? FontWeight.w500 : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (hasUnread)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2196F3),
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


