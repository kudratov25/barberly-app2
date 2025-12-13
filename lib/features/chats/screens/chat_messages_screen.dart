import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/chats/models/chat.dart';
import 'package:intl/intl.dart';

/// Chat messages screen with WhatsApp-style design
class ChatMessagesScreen extends ConsumerStatefulWidget {
  final int chatId;

  const ChatMessagesScreen({super.key, required this.chatId});

  @override
  ConsumerState<ChatMessagesScreen> createState() =>
      _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends ConsumerState<ChatMessagesScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isSending = false;
  ChatMessage? _replyingToMessage;
  ChatMessage? _editingMessage;
  int? _currentUserId;
  final Map<int, GlobalKey> _messageKeys = {};
  Timer? _refreshTimer;
  List<ChatMessage> _messages = const [];
  bool _isLoadingMessages = true;
  String? _messagesError;
  bool _initialAutoScrollDone = false;

  @override
  void initState() {
    super.initState();
    // Load current user after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCurrentUser();
    });

    // Initial load + realtime polling (no FutureBuilder flicker)
    _fetchMessages(silent: false);
    _refreshTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _fetchMessages(silent: true);
    });
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

  void _scrollToMessage(int messageId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final key = _messageKeys[messageId];
      if (key?.currentContext != null && _scrollController.hasClients) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  bool _isAtBottom() {
    if (!_scrollController.hasClients) return true;
    // In reverse:true ListView, bottom == offset 0.
    return _scrollController.offset <= 24;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  bool _sameMessages(List<ChatMessage> a, List<ChatMessage> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    if (a.isEmpty) return true;
    final aFirst = a.first;
    final aLast = a.last;
    final bFirst = b.first;
    final bLast = b.last;
    return aFirst.id == bFirst.id &&
        aLast.id == bLast.id &&
        aFirst.message == bFirst.message &&
        aLast.message == bLast.message &&
        aFirst.isRead == bFirst.isRead &&
        aLast.isRead == bLast.isRead;
  }

  Future<void> _fetchMessages({required bool silent}) async {
    final wasAtBottom = _isAtBottom();

    if (!silent) {
      setState(() {
        _isLoadingMessages = true;
        _messagesError = null;
      });
    }

    try {
      final page = await ref
          .read(chatServiceProvider)
          .listMessages(chatId: widget.chatId);
      final nextMessages = page.data;

      final changed = !_sameMessages(_messages, nextMessages);
      if (!changed) {
        if (!silent && mounted) {
          setState(() {
            _isLoadingMessages = false;
          });
        }
        return;
      }

      if (!mounted) return;
      setState(() {
        _messages = nextMessages;
        _isLoadingMessages = false;
        _messagesError = null;
      });

      if (!_initialAutoScrollDone || wasAtBottom) {
        _initialAutoScrollDone = true;
        _scrollToBottom();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingMessages = false;
        _messagesError = e.toString();
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final message = _messageController.text.trim();
    final replyToId = _replyingToMessage?.id;
    final editingMessageId = _editingMessage?.id;

    setState(() => _isSending = true);

    try {
      if (editingMessageId != null) {
        // Update existing message
        await ref.read(chatServiceProvider).updateMessage(
              chatId: widget.chatId,
              messageId: editingMessageId,
              message: message,
            );
        setState(() {
          _editingMessage = null;
          _messageController.clear();
        });
      } else {
        // Send new message or reply
      await ref.read(chatServiceProvider).sendMessage(
            chatId: widget.chatId,
            message: message,
              replyToId: replyToId,
          );
        setState(() {
          _replyingToMessage = null;
          _messageController.clear();
        });
      }

      await _fetchMessages(silent: true);
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isSending = false);
    }
  }

  Future<void> _deleteMessage(ChatMessage message) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete message?'),
        content: const Text('This message will be deleted for everyone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref.read(chatServiceProvider).deleteMessage(
            chatId: widget.chatId,
            messageId: message.id,
          );
      await _fetchMessages(silent: true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white24,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, size: 20),
            ),
            const SizedBox(width: 12),
            const Text('Barber'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                if (_isLoadingMessages) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_messagesError != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text('Error: $_messagesError'),
                      ],
                    ),
                  );
                }
                if (_messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_outlined,
                            size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text(
                          'No messages yet',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Say hi to start the conversation',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Reverse messages so newest is at bottom (Telegram style)
                final reversedMessages = _messages.reversed.toList();

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true, // Telegram style: newest at bottom
                  padding: const EdgeInsets.all(16),
                  itemCount: reversedMessages.length,
                  itemBuilder: (context, index) {
                    final message = reversedMessages[index];
                    // Create key for this message if it doesn't exist
                    _messageKeys.putIfAbsent(message.id, () => GlobalKey());

                    // Find replyTo message if exists
                    ChatMessage? replyToMessage;
                    if (message.replyToId != null) {
                      replyToMessage = reversedMessages.firstWhere(
                        (m) => m.id == message.replyToId,
                        orElse: () => message.replyTo ?? message,
                      );
                    }

                    final isSent = _currentUserId != null &&
                        message.userId == _currentUserId;

                    final menu = PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      padding: EdgeInsets.zero,
                      onSelected: (value) {
                        switch (value) {
                          case 'reply':
                            setState(() {
                              _replyingToMessage = message;
                              _editingMessage = null;
                            });
                            break;
                          case 'edit':
                            setState(() {
                              _editingMessage = message;
                              _replyingToMessage = null;
                              _messageController.text = message.message;
                            });
                            break;
                          case 'delete':
                            _deleteMessage(message);
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'reply',
                          child: Row(
                            children: [
                              Icon(Icons.reply, size: 18),
                              SizedBox(width: 8),
                              Text('Reply'),
                            ],
                          ),
                        ),
                        if (isSent)
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 18),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                        if (isSent)
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 18, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Delete',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                      ],
                    );

                    final bubble = Flexible(
                      child: _MessageBubble(
                        key: _messageKeys[message.id],
                      message: message,
                        replyToMessage: replyToMessage,
                      isSent: isSent,
                        onReplyTap: message.replyToId != null
                            ? () => _scrollToMessage(message.replyToId!)
                            : null,
                      ),
                    );

                    // Make the menu stay close to the bubble (Telegram-like).
                    return Align(
                      alignment:
                          isSent ? Alignment.centerRight : Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: menu,
                          ),
                          const SizedBox(width: 4),
                          bubble,
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Reply/Edit preview
          if (_replyingToMessage != null || _editingMessage != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 3,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _editingMessage != null
                          ? Colors.orange
                          : const Color(0xFF2196F3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _editingMessage != null
                              ? 'Editing message'
                              : _replyingToMessage?.user?.name ?? 'You',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2196F3),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _editingMessage?.message ??
                              _replyingToMessage?.message ??
                              '',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () {
                      setState(() {
                        _replyingToMessage = null;
                        _editingMessage = null;
                        _messageController.clear();
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
            ),
          ),
          // Message input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: _editingMessage != null
                              ? 'Edit message...'
                              : 'Type a message...',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: _isSending
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Icon(
                              _editingMessage != null
                                  ? Icons.check
                                  : Icons.send,
                              color: Colors.white,
                            ),
                      onPressed: _isSending ? null : _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final ChatMessage? replyToMessage;
  final bool isSent;
  final VoidCallback? onReplyTap;

  const _MessageBubble({
    super.key,
    required this.message,
    this.replyToMessage,
    required this.isSent,
    this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSent ? const Color(0xFF2196F3) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isSent ? 16 : 4),
            bottomRight: Radius.circular(isSent ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                // Reply preview (Telegram style)
                if (replyToMessage != null)
                  GestureDetector(
                    onTap: onReplyTap,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSent
                            ? Colors.white.withOpacity(0.2)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          left: BorderSide(
                            color: isSent
                                ? Colors.white
                                : const Color(0xFF2196F3),
                            width: 3,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            replyToMessage!.user?.name ?? 'You',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSent
                                  ? Colors.white
                                  : const Color(0xFF2196F3),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            replyToMessage!.message,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSent
                                  ? Colors.white70
                                  : Colors.grey.shade700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
            Text(
              message.message,
              style: TextStyle(
                fontSize: 15,
                color: isSent ? Colors.white : const Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
            Text(
                      () {
                        try {
                          final dt = DateTime.parse(message.createdAt);
                          return DateFormat('HH:mm').format(dt);
                        } catch (_) {
                          return '';
                        }
                      }(),
              style: TextStyle(
                fontSize: 11,
                color: isSent ? Colors.white70 : const Color(0xFF757575),
              ),
                    ),
                    if (isSent) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.check,
                        size: 14,
                        color: message.isRead
                            ? (isSent ? Colors.white : const Color(0xFF0A84FF))
                            : (isSent ? Colors.white70 : Colors.grey),
                      ),
                      if (message.isRead)
                        Icon(
                          Icons.check,
                          size: 14,
                          color: isSent ? Colors.white : const Color(0xFF0A84FF),
                        ),
                    ],
                  ],
            ),
          ],
        ),
      ),
    );
  }
}


