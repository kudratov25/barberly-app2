import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/common/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/chats/models/chat.dart';
import 'package:intl/intl.dart';

/// Chat list screen with modern design
class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  List<Chat> _chats = [];
  bool _isLoading = true;
  String? _error;
  int? _currentUserId;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCurrentUser();
      _fetchChats(silent: false);
      // Real-time polling: har 3 soniyada yangilash
      _refreshTimer = Timer.periodic(const Duration(seconds: 3), (_) {
        _fetchChats(silent: true);
      });
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final user = await ref.read(authServiceProvider).getCurrentUser();
      if (mounted) {
        setState(() {
          _currentUserId = user.id;
        });
      }
    } catch (e) {
      // Ignore error, will use null
    }
  }

  Future<void> _fetchChats({required bool silent}) async {
    if (!silent) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      final chats = await ref.read(chatServiceProvider).listChats();
      if (mounted) {
        setState(() {
          _chats = chats;
          _isLoading = false;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = e.toString();
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    await _fetchChats(silent: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading && _chats.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _error != null && _chats.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: $_error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _fetchChats(silent: false),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : _chats.isEmpty
          ? Center(
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
            )
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _chats.length,
                itemBuilder: (context, index) {
                  final chat = _chats[index];
                  return _ChatCard(chat: chat, currentUserId: _currentUserId);
                },
              ),
            ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}

class _ChatCard extends StatelessWidget {
  final Chat chat;
  final int? currentUserId;

  const _ChatCard({required this.chat, this.currentUserId});

  @override
  Widget build(BuildContext context) {
    // Barber'ni topish: chat.users dan currentUserId bo'lmagan user'ni olish
    final otherUser = chat.users.firstWhere(
      (user) => currentUserId == null || user.id != currentUserId,
      orElse: () => chat.users.isNotEmpty
          ? chat.users.first
          : const ChatUser(id: 0, name: 'Chat'),
    );

    // Faqat barber yuborgan o'qilmagan habarlar uchun belgi ko'rsatish
    // Agar latest message foydalanuvchi tomonidan yuborilgan bo'lsa, belgi ko'rsatilmaydi
    final latestMessage = chat.latestMessage;
    final isLatestMessageFromCurrentUser =
        currentUserId != null &&
        latestMessage != null &&
        latestMessage.userId == currentUserId;

    // Unread count: backend'dan kelgan yoki latest_message is_read dan hisoblash
    // Faqat barber yuborgan habarlar uchun
    int unreadCount;
    if (isLatestMessageFromCurrentUser) {
      // Agar oxirgi xabar foydalanuvchi tomonidan yuborilgan bo'lsa, belgi ko'rsatilmaydi
      unreadCount = 0;
    } else if (chat.unreadCount != null && chat.unreadCount! > 0) {
      // Backend'dan kelgan unread count (barber yuborgan o'qilmagan habarlar soni)
      unreadCount = chat.unreadCount!;
    } else if (latestMessage != null && !latestMessage.isRead) {
      // Agar latest message o'qilmagan bo'lsa va barber tomonidan yuborilgan bo'lsa
      unreadCount = 1;
    } else {
      unreadCount = 0;
    }
    final hasUnread = unreadCount > 0;

    DateTime? parseCreatedAt(String? value) {
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
              // Avatar with unread badge
              Stack(
                // clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C4B77),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        otherUser.name.isNotEmpty
                            ? otherUser.name[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Unread count badge on avatar
                  // if (hasUnread)
                  //   Positioned(
                  //     right: -4,
                  //     top: -4,
                  //     child: Container(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 6,
                  //         vertical: 2,
                  //       ),
                  //       decoration: const BoxDecoration(
                  //         color: Colors.red,
                  //         shape: BoxShape.circle,
                  //       ),
                  //       constraints: const BoxConstraints(
                  //         minWidth: 18,
                  //         minHeight: 18,
                  //       ),
                  //       child: Center(
                  //         child: Text(
                  //           unreadCount > 99 ? '99+' : '$unreadCount',
                  //           style: const TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 10,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
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
                        Expanded(
                          child: Text(
                            otherUser.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: hasUnread
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: const Color(0xFF212121),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (parseCreatedAt(chat.latestMessage?.createdAt) !=
                            null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              DateFormat('HH:mm').format(
                                parseCreatedAt(chat.latestMessage?.createdAt)!,
                              ),
                              style: TextStyle(
                                fontSize: 12,
                                color: hasUnread
                                    ? const Color(0xFF2C4B77)
                                    : const Color(0xFF757575),
                                fontWeight: hasUnread
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
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
                              fontWeight: hasUnread
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Unread count badge (alternative to avatar badge)
                        if (hasUnread)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: EdgeInsets.symmetric(
                              horizontal: unreadCount > 9 ? 8 : 8,
                              vertical: 4,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2C4B77),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              unreadCount > 99 ? '99+' : '$unreadCount',
                              style: const TextStyle(
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
