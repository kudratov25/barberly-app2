import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/common/utils/storage.dart';
import 'package:mobile/features/chats/models/chat.dart';
import 'package:intl/intl.dart';

/// Telegram-like chat messages screen
/// 
/// CRITICAL BEHAVIOR:
/// - Messages ordered by created_at ASC (oldest at top, newest at bottom)
/// - Sent messages: RIGHT side, Blue bubble
/// - Received messages: LEFT side, White bubble
/// - Normal ListView (NOT reverse:true)
/// - Auto-scroll to bottom on open and new messages
/// - Smart polling: only append new messages
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
  
  // Messages list - ordered by created_at ASC (oldest first, newest last)
  List<ChatMessage> _messages = [];
  bool _isLoadingMessages = true;
  String? _messagesError;
  bool _hasScrolledToBottom = false;
  
  // Track which orders have been rated to avoid showing dialog multiple times
  final Set<int> _ratedOrders = {};
  final Map<int, int> _orderRatings = {}; // orderId -> rating (1..5)
  bool _ratedOrdersLoaded = false;
  bool _isRatingDialogOpen = false;

  @override
  void initState() {
    super.initState();
    // Load current user after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCurrentUser();
      _loadRatedOrdersFromStorage();
      // Mark chat as read when opening
      _markChatAsRead();
    });

    // Initial load + realtime polling
    _fetchMessages(silent: false);
    _refreshTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _fetchMessages(silent: true);
    });
  }

  /// Mark chat messages as read
  Future<void> _markChatAsRead() async {
    try {
      await ref.read(chatServiceProvider).markAsRead(widget.chatId);
    } catch (e) {
      // Ignore error silently
    }
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

  Future<void> _loadRatedOrdersFromStorage() async {
    try {
      final rated = await Storage.getRatedOrders();
      final ratings = await Storage.getOrderRatings();
      if (!mounted) return;
      setState(() {
        _ratedOrders
          ..clear()
          ..addAll(rated);
        _orderRatings
          ..clear()
          ..addAll(ratings);
        _ratedOrdersLoaded = true;
      });

      // If messages already loaded, re-check whether we need to prompt for rating.
      _checkForRatingRequests(_messages);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _ratedOrdersLoaded = true; // avoid blocking prompts forever
      });
    }
  }

  Widget _buildRatedInChatMessage({required int orderId}) {
    final rating = _orderRatings[orderId];
    final stars = rating == null ? '' : ' ${'⭐' * rating}';
    final text = rating == null
        ? 'Siz bu xizmatga baho berdingiz.'
        : 'Siz $rating⭐ baho berdingiz.$stars';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _checkForRatingRequests(List<ChatMessage> messages) {
    if (!_ratedOrdersLoaded) return;
    if (_isRatingDialogOpen) return;
    for (final msg in messages) {
      final text = msg.message.toLowerCase();
      if (msg.messageType == 'system' &&
          msg.orderId != null &&
          text.contains('baho') &&
          !_ratedOrders.contains(msg.orderId)) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) _showRatingDialog(msg.orderId!);
        });
        break; // only show one dialog at a time
      }
    }
  }

  /// Scroll to a specific message (for reply navigation)
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

  /// Check if user is at bottom of chat
  bool _isAtBottom() {
    if (!_scrollController.hasClients) return true;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    // Consider at bottom if within 50px of bottom
    return (maxScroll - currentScroll) <= 50;
  }

  /// Scroll to bottom (newest message)
  void _scrollToBottom({bool smooth = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (smooth) {
        _scrollController.animateTo(
          maxScroll,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(maxScroll);
      }
    });
  }

  /// Fetch messages from API
  /// Smart polling: only append new messages, don't rebuild entire list
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
          .listMessages(chatId: widget.chatId, perPage: 100);
      
      // Backend returns messages ordered by created_at ASC (oldest first)
      final newMessages = page.data;

      if (_messages.isEmpty) {
        // First load: set all messages
        if (mounted) {
          setState(() {
            _messages = newMessages;
            _isLoadingMessages = false;
            _messagesError = null;
          });
          
          // Check for rating request messages on first load
          _checkForRatingRequests(newMessages);
          
          // Auto-scroll to bottom on first load
          _scrollToBottom(smooth: false);
          _hasScrolledToBottom = true;
        }
        return;
      }

      // Smart update: only append new messages
      // Find the last message ID we have
      final lastMessageId = _messages.isNotEmpty ? _messages.last.id : 0;
      
      // Find new messages (messages with ID > lastMessageId)
      final newMessagesToAdd = newMessages
          .where((msg) => msg.id > lastMessageId)
          .toList();

      if (newMessagesToAdd.isEmpty) {
        // No new messages, but check for updates (is_read, edits)
        final updatedMessages = <ChatMessage>[];
        bool hasUpdates = false;

        for (var existingMsg in _messages) {
          final updatedMsg = newMessages.firstWhere(
            (m) => m.id == existingMsg.id,
            orElse: () => existingMsg,
          );
          
          // Check if message was updated
          if (updatedMsg.isRead != existingMsg.isRead ||
              updatedMsg.message != existingMsg.message) {
            hasUpdates = true;
            updatedMessages.add(updatedMsg);
          } else {
            updatedMessages.add(existingMsg);
          }
        }

        if (hasUpdates && mounted) {
          setState(() {
            _messages = updatedMessages;
          });
        } else if (!silent && mounted) {
          setState(() {
            _isLoadingMessages = false;
          });
        }
        return;
      }

      // Append new messages
      if (mounted) {
        setState(() {
          _messages = [..._messages, ...newMessagesToAdd];
          _isLoadingMessages = false;
          _messagesError = null;
        });

        // Check for rating request messages
        _checkForRatingRequests(newMessagesToAdd);

        // Auto-scroll to bottom if user was at bottom or on first load
        if (wasAtBottom || !_hasScrolledToBottom) {
          _hasScrolledToBottom = true;
          _scrollToBottom();
        }
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
        final updatedMessage = await ref.read(chatServiceProvider).updateMessage(
          chatId: widget.chatId,
          messageId: editingMessageId,
          message: message,
        );
        
        // Update message in list
        setState(() {
          final index = _messages.indexWhere((m) => m.id == editingMessageId);
          if (index != -1) {
            _messages[index] = updatedMessage;
          }
          _editingMessage = null;
          _messageController.clear();
        });
      } else {
        // Send new message or reply
        final sentMessage = await ref.read(chatServiceProvider).sendMessage(
          chatId: widget.chatId,
          message: message,
          replyToId: replyToId,
        );
        
        // Append new message to list
        setState(() {
          _messages = [..._messages, sentMessage];
          _replyingToMessage = null;
          _messageController.clear();
        });
        
        // Scroll to bottom
        _scrollToBottom();
      }
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

  /// Show rating dialog for completed order
  Future<void> _showRatingDialog(int orderId) async {
    // Don't show if already rated
    if (_ratedOrders.contains(orderId)) return;
    if (_isRatingDialogOpen) return;
    _isRatingDialogOpen = true;
    
    int? selectedRating;
    bool isLoading = false;
    
    await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 32),
              SizedBox(width: 8),
              Text(
                'Baho bering',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Xizmat qanday bo\'ldi?',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF757575),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // 5 yulduzcha
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final rating = index + 1;
                  final isSelected = selectedRating != null && rating <= selectedRating!;
                  return GestureDetector(
                    onTap: isLoading ? null : () {
                      setDialogState(() {
                        selectedRating = rating;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          isSelected ? Icons.star : Icons.star_border,
                          size: 48,
                          color: isSelected ? Colors.amber : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              // Rating text
              if (selectedRating != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    selectedRating == 5
                        ? 'Ajoyib! ⭐⭐⭐⭐⭐'
                        : selectedRating == 4
                            ? 'Yaxshi! ⭐⭐⭐⭐'
                            : selectedRating == 3
                                ? 'Yaxshi ⭐⭐⭐'
                                : selectedRating == 2
                                    ? 'O\'rtacha ⭐⭐'
                                    : 'Yomon ⭐',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber,
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            // Keyinroq tugmasi
            TextButton(
              onPressed: isLoading ? null : () {
                Navigator.pop(dialogContext, {'success': false});
              },
              child: const Text(
                'Keyinroq',
                style: TextStyle(color: Color(0xFF757575)),
              ),
            ),
            // Yuborish tugmasi
            ElevatedButton(
              onPressed: (selectedRating != null && !isLoading) ? () async {
                setDialogState(() {
                  isLoading = true;
                });
                
                try {
                  await ref.read(ratingServiceProvider).createRating(
                    orderId: orderId,
                    rating: selectedRating!,
                  );
                  
                  if (mounted) {
                    setState(() {
                      _ratedOrders.add(orderId);
                      _orderRatings[orderId] = selectedRating!;
                    });
                    await Storage.addRatedOrder(orderId);
                    await Storage.saveOrderRating(
                      orderId: orderId,
                      rating: selectedRating!,
                    );
                    
                    Navigator.pop(dialogContext, {
                      'success': true,
                      'rating': selectedRating,
                    });
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.white),
                            const SizedBox(width: 8),
                            Text('Baho yuborildi! ${selectedRating} yulduz ⭐'),
                          ],
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                } catch (e) {
                  final msg = e.toString().toLowerCase();
                  final alreadyRated = msg.contains('already been rated') ||
                      msg.contains('already rated') ||
                      msg.contains('allaqachon baholangan') ||
                      msg.contains('allaqachon baholangan');

                  if (alreadyRated) {
                    if (mounted) {
                      setState(() {
                        _ratedOrders.add(orderId);
                      });
                      await Storage.addRatedOrder(orderId);
                      Navigator.pop(dialogContext, {'success': false});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bu buyurtma allaqachon baholangan.'),
                          backgroundColor: Colors.blueGrey,
                        ),
                      );
                    }
                    return;
                  }

                  setDialogState(() {
                    isLoading = false;
                  });
                  
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Xatolik: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedRating != null
                    ? const Color(0xFF2196F3)
                    : Colors.grey.shade300,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Yuborish',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );

    // Dialog yopilganda hech narsa qilmaymiz, chunki rating allaqachon yuborilgan
    _isRatingDialogOpen = false;
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
      
      // Remove message from list
      setState(() {
        _messages = _messages.where((m) => m.id != message.id).toList();
      });
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
            const Text('Chat'),
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
                if (_isLoadingMessages && _messages.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_messagesError != null && _messages.isEmpty) {
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

                // Normal ListView - messages already sorted ASC (oldest first, newest last)
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];

                    // If this is the rating-request system message and rating already given,
                    // show "you rated X⭐" instead of asking again.
                    final msgLower = message.message.toLowerCase();
                    if (message.messageType == 'system' &&
                        message.orderId != null &&
                        msgLower.contains('baho') &&
                        _ratedOrders.contains(message.orderId)) {
                      return _buildRatedInChatMessage(orderId: message.orderId!);
                    }

                    // Create key for this message if it doesn't exist
                    _messageKeys.putIfAbsent(message.id, () => GlobalKey());

                    // Find replyTo message if exists
                    ChatMessage? replyToMessage;
                    if (message.replyToId != null) {
                      replyToMessage = _messages.firstWhere(
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

                    // Message alignment: Sent = RIGHT, Received = LEFT
                    return Align(
                      alignment:
                          isSent ? Alignment.centerRight : Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:
                            isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          if (!isSent) ...[
                            bubble,
                            const SizedBox(width: 4),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: menu,
                            ),
                          ] else ...[
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: menu,
                            ),
                            const SizedBox(width: 4),
                            bubble,
                          ],
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

/// Message bubble widget
/// 
/// CRITICAL:
/// - Sent messages: RIGHT aligned, Blue bubble
/// - Received messages: LEFT aligned, White bubble
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
    return Container(
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
          // Message text
          Text(
            message.message,
            style: TextStyle(
              fontSize: 15,
              color: isSent ? Colors.white : const Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 4),
          // Time and read status
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
              // Read status icons ONLY for sent messages
              if (isSent) ...[
                const SizedBox(width: 4),
                Icon(
                  message.isRead ? Icons.done_all : Icons.done,
                  size: 14,
                  color: message.isRead
                      ? const Color(0xFF64B5F6) // Light blue for read
                      : Colors.white70, // Gray for unread
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
