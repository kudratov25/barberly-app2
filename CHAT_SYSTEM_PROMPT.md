# Chat System - To'liq Tushuntirish va Barber Side Prompt

## 📱 Chat Tizimi - Umumiy Tushuntirish

### Chat Tizimi Qanday Ishlaydi?

Chat tizimi **private chat** (shaxsiy chat) asosida ishlaydi. Har bir chat ikki kishining o'rtasida bo'ladi:
- **Client ↔ Barber** (mijoz va barber o'rtasida)
- **Barber ↔ Client** (barber va mijoz o'rtasida)

---

## 🏗️ Chat Tizimi Arxitekturasi

### 1. **Chat Model (Chat Ob'ekti)**

```dart
Chat {
  id: int                    // Chat ID
  type: String              // "private" (hozircha faqat private)
  createdAt: String         // Chat yaratilgan vaqt
  latestMessage: ChatMessage?  // Oxirgi xabar (null bo'lishi mumkin)
  users: List<ChatUser>     // Chat'dagi foydalanuvchilar (2 ta: client va barber)
}
```

**Backend Response:**
```json
{
  "id": 3,
  "type": "private",
  "created_at": "2025-02-01T12:00:00.000000Z",
  "latest_message": {
    "id": 10,
    "message": "Salom!",
    "created_at": "2025-02-10T15:00:00.000000Z",
    "is_read": false
  },
  "users": [
    {"id": 1, "name": "Client Name"},
    {"id": 3, "name": "Barber Name"}
  ]
}
```

### 2. **ChatMessage Model (Xabar Ob'ekti)**

```dart
ChatMessage {
  id: int                    // Xabar ID
  chatId: int               // Chat ID
  userId: int               // Xabar yuborgan user ID
  message: String           // Xabar matni
  messageType: String       // "text" (yoki "image", "file" kelajakda)
  orderId: int?             // Order bilan bog'liq bo'lsa (null bo'lishi mumkin)
  replyToId: int?           // Reply qilingan xabar ID (null bo'lishi mumkin)
  replyTo: ChatMessage?     // Reply qilingan xabar ob'ekti (null bo'lishi mumkin)
  isRead: bool              // O'qilganmi? (false = o'qilmagan)
  createdAt: String         // Xabar yuborilgan vaqt
  user: ChatUser?           // Xabar yuborgan user (null bo'lishi mumkin)
}
```

**Backend Response:**
```json
{
  "id": 10,
  "chat_id": 3,
  "user_id": 1,
  "message": "Salom!",
  "message_type": "text",
  "order_id": null,
  "reply_to_id": null,
  "reply_to": null,
  "is_read": false,
  "created_at": "2025-02-10T15:00:00.000000Z",
  "user": {
    "id": 1,
    "name": "Client Name"
  }
}
```

### 3. **ChatUser Model (Foydalanuvchi Ob'ekti)**

```dart
ChatUser {
  id: int                    // User ID
  name: String              // User ismi
}
```

---

## 🔌 API Endpoints

### 1. **List Chats** (Chatlar Ro'yxati)
```
GET /api/v1/chats
```

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 3,
      "type": "private",
      "created_at": "2025-02-01T12:00:00.000000Z",
      "latest_message": {
        "id": 10,
        "message": "Salom!",
        "created_at": "2025-02-10T15:00:00.000000Z",
        "is_read": false
      },
      "users": [
        {"id": 1, "name": "Client"},
        {"id": 3, "name": "Barber"}
      ]
    }
  ]
}
```

**Frontend Implementation:**
```dart
Future<List<Chat>> listChats() async {
  final response = await _apiClient.dio.get(ApiEndpoints.chats);
  return (response.data['data'] as List).map((json) {
    final chatMap = Map<String, dynamic>.from(json);
    // Normalize latest_message.is_read (null bo'lishi mumkin)
    if (chatMap['latest_message'] != null && chatMap['latest_message'] is Map) {
      final latestMsgMap = Map<String, dynamic>.from(chatMap['latest_message']);
      latestMsgMap['is_read'] = latestMsgMap['is_read'] ?? false;
      chatMap['latest_message'] = latestMsgMap;
    }
    return Chat.fromJson(chatMap);
  }).toList();
}
```

### 2. **Create or Get Chat** (Chat Yaratish yoki Olish)
```
POST /api/v1/chats
Body: {"user_id": 3}  // Barber ID (client side'da) yoki Client ID (barber side'da)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": 3,
    "type": "private",
    "created_at": "2025-02-01T12:00:00.000000Z",
    "users": [
      {"id": 1, "name": "Client"},
      {"id": 3, "name": "Barber"}
    ]
  }
}
```

**Frontend Implementation:**
```dart
Future<Chat> createOrGetChat(int userId) async {
  final response = await _apiClient.dio.post(
    ApiEndpoints.chats,
    data: {'user_id': userId},
  );
  final chatMap = Map<String, dynamic>.from(response.data['data']);
  // Normalize latest_message if exists
  if (chatMap['latest_message'] != null && chatMap['latest_message'] is Map) {
    final latestMsgMap = Map<String, dynamic>.from(chatMap['latest_message']);
    latestMsgMap['is_read'] = latestMsgMap['is_read'] ?? false;
    chatMap['latest_message'] = latestMsgMap;
  }
  return Chat.fromJson(chatMap);
}
```

### 3. **Get Single Chat** (Bitta Chat Olish)
```
GET /api/v1/chats/:chat_id
```

**Response:** Xuddi Create or Get Chat kabi

### 4. **List Messages** (Xabarlar Ro'yxati)
```
GET /api/v1/chats/:chat_id/messages?per_page=50
```

**Response:**
```json
{
  "success": true,
  "data": {
    "current_page": 1,
    "data": [
      {
        "id": 10,
        "chat_id": 3,
        "user_id": 1,
        "message": "Salom!",
        "message_type": "text",
        "order_id": null,
        "reply_to_id": null,
        "reply_to": null,
        "is_read": false,
        "created_at": "2025-02-10T15:00:00.000000Z",
        "user": {"id": 1, "name": "Client"}
      }
    ],
    "total": 25,
    "per_page": 50
  }
}
```

**Frontend Implementation:**
```dart
Future<PaginatedResponse<ChatMessage>> listMessages({
  required int chatId,
  int? perPage,
}) async {
  final queryParams = <String, dynamic>{};
  if (perPage != null) queryParams['per_page'] = perPage;

  final response = await _apiClient.dio.get(
    ApiEndpoints.chatMessages(chatId),
    queryParameters: queryParams,
  );

  return PaginatedResponse<ChatMessage>.fromJson(
    response.data['data'],
    (json) {
      final map = Map<String, dynamic>.from(json);
      // Normalize is_read (null bo'lishi mumkin)
      map['is_read'] = map['is_read'] ?? false;
      // Normalize nested reply_to message if exists
      if (map['reply_to'] != null && map['reply_to'] is Map) {
        final replyToMap = Map<String, dynamic>.from(map['reply_to']);
        replyToMap['is_read'] = replyToMap['is_read'] ?? false;
        map['reply_to'] = replyToMap;
      }
      return ChatMessage.fromJson(map);
    },
  );
}
```

### 5. **Send Message** (Xabar Yuborish)
```
POST /api/v1/chats/:chat_id/messages
Body: {
  "message": "Salom!",
  "message_type": "text",
  "order_id": 5,        // Optional: Order bilan bog'liq bo'lsa
  "reply_to_id": 10    // Optional: Reply qilish uchun
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": 11,
    "chat_id": 3,
    "user_id": 1,
    "message": "Salom!",
    "message_type": "text",
    "order_id": 5,
    "reply_to_id": 10,
    "reply_to": {
      "id": 10,
      "message": "Qanday?",
      "is_read": false
    },
    "is_read": false,
    "created_at": "2025-02-10T16:00:00.000000Z"
  }
}
```

**Frontend Implementation:**
```dart
Future<ChatMessage> sendMessage({
  required int chatId,
  required String message,
  String messageType = 'text',
  int? orderId,
  int? replyToId,
}) async {
  final response = await _apiClient.dio.post(
    ApiEndpoints.chatMessages(chatId),
    data: {
      'message': message,
      'message_type': messageType,
      if (orderId != null) 'order_id': orderId,
      if (replyToId != null) 'reply_to_id': replyToId,
    },
  );
  final map = Map<String, dynamic>.from(response.data['data']);
  map['is_read'] = map['is_read'] ?? false;
  // Normalize nested reply_to
  if (map['reply_to'] != null && map['reply_to'] is Map) {
    final replyToMap = Map<String, dynamic>.from(map['reply_to']);
    replyToMap['is_read'] = replyToMap['is_read'] ?? false;
    map['reply_to'] = replyToMap;
  }
  return ChatMessage.fromJson(map);
}
```

### 6. **Update Message** (Xabarni Tahrirlash)
```
PATCH /api/v1/chats/:chat_id/messages/:message_id
Body: {"message": "Yangi matn"}
```

**Response:** Xuddi Send Message kabi

**Frontend Implementation:**
```dart
Future<ChatMessage> updateMessage({
  required int chatId,
  required int messageId,
  required String message,
}) async {
  final response = await _apiClient.dio.patch(
    ApiEndpoints.chatMessage(chatId, messageId),
    data: {'message': message},
  );
  final map = Map<String, dynamic>.from(response.data['data']);
  map['is_read'] = map['is_read'] ?? false;
  return ChatMessage.fromJson(map);
}
```

### 7. **Delete Message** (Xabarni O'chirish)
```
DELETE /api/v1/chats/:chat_id/messages/:message_id
```

**Response:**
```json
{
  "success": true,
  "message": "Message deleted successfully"
}
```

**Frontend Implementation:**
```dart
Future<void> deleteMessage({
  required int chatId,
  required int messageId,
}) async {
  await _apiClient.dio.delete(
    ApiEndpoints.chatMessage(chatId, messageId),
  );
}
```

### 8. **Mark as Read** (O'qilgan Deb Belgilash)
```
POST /api/v1/chats/:chat_id/read
```

**Response:**
```json
{
  "success": true,
  "message": "Messages marked as read"
}
```

**Frontend Implementation:**
```dart
Future<void> markAsRead(int chatId) async {
  await _apiClient.dio.post(ApiEndpoints.chatRead(chatId));
}
```

---

## 🎨 UI Implementation (Client Side)

### 1. **Chat List Screen**

**Features:**
- Barcha chatlar ro'yxati
- Har bir chat kartasida:
  - Avatar (user initial)
  - User ismi
  - Oxirgi xabar (preview)
  - Vaqt (HH:mm)
  - Unread badge (agar o'qilmagan bo'lsa)
- Tap → Chat Messages Screen'ga o'tadi

**Implementation:**
```dart
class ChatListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Chats')),
      body: FutureBuilder<List<Chat>>(
        future: ref.read(chatServiceProvider).listChats(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final chat = snapshot.data![index];
                final otherUser = chat.users.firstWhere(
                  (u) => u.id != currentUserId,
                );
                final hasUnread = chat.latestMessage?.isRead == false;
                
                return _ChatCard(
                  chat: chat,
                  otherUser: otherUser,
                  hasUnread: hasUnread,
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
```

### 2. **Chat Messages Screen**

**Features:**
- Xabarlar ro'yxati (Telegram style: reverse ListView)
- Sent messages (o'ng tomonda, ko'k rang)
- Received messages (chap tomonda, oq rang)
- Reply funksiyasi (xabar ustiga bosib, reply qilish)
- Edit funksiyasi (o'z xabarlarini tahrirlash)
- Delete funksiyasi (o'z xabarlarini o'chirish)
- Real-time updates (polling: 2-3 soniyada bir marta)
- Auto scroll to bottom (yangi xabar yuborilganda)
- Scroll to replied message (reply'ga bosganda)
- Message input field
- Send button

**Real-time Updates:**
```dart
class _ChatMessagesScreenState extends ConsumerState<ChatMessagesScreen> {
  List<ChatMessage> _messages = [];
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    // Real-time polling: har 2-3 soniyada yangilash
    _refreshTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _fetchMessages(silent: true);
    });
  }

  Future<void> _fetchMessages({bool silent = false}) async {
    try {
      final page = await ref
          .read(chatServiceProvider)
          .listMessages(chatId: widget.chatId);
      final newMessages = page.data;
      
      // Faqat o'zgarganda UI'ni yangilash (flicker oldini olish)
      if (!_sameMessages(_messages, newMessages)) {
        setState(() {
          _messages = newMessages;
        });
        _scrollToBottom();
      }
    } catch (e) {
      // Error handling
    }
  }

  bool _sameMessages(List<ChatMessage> a, List<ChatMessage> b) {
    if (a.length != b.length) return false;
    if (a.isEmpty) return true;
    return a.first.id == b.first.id && 
           a.last.id == b.last.id &&
           a.first.message == b.first.message &&
           a.last.message == b.last.message;
  }
}
```

**Message Bubble:**
```dart
Widget _buildMessageBubble(ChatMessage message, bool isSent) {
  return Align(
    alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.only(
        bottom: 8,
        left: isSent ? 50 : 0,
        right: isSent ? 0 : 50,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSent ? Color(0xFF0A84FF) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reply preview (agar reply bo'lsa)
          if (message.replyTo != null)
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSent ? Colors.white.withOpacity(0.2) : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message.replyTo!.message,
                style: TextStyle(
                  fontSize: 12,
                  color: isSent ? Colors.white70 : Colors.grey.shade700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          // Message text
          Text(
            message.message,
            style: TextStyle(
              color: isSent ? Colors.white : Colors.black87,
            ),
          ),
          // Time and read status
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('HH:mm').format(DateTime.parse(message.createdAt)),
                style: TextStyle(
                  fontSize: 11,
                  color: isSent ? Colors.white70 : Colors.grey.shade600,
                ),
              ),
              if (isSent) ...[
                SizedBox(width: 4),
                Icon(
                  message.isRead ? Icons.done_all : Icons.done,
                  size: 14,
                  color: message.isRead ? Colors.blue.shade300 : Colors.white70,
                ),
              ],
            ],
          ),
        ],
      ),
    ),
  );
}
```

**Message Actions (Reply, Edit, Delete):**
```dart
Widget _buildMessageActions(ChatMessage message, bool isSent) {
  if (!isSent) return SizedBox.shrink(); // Faqat o'z xabarlarida
  
  return PopupMenuButton(
    icon: Icon(Icons.more_vert, size: 18),
    itemBuilder: (context) => [
      PopupMenuItem(
        child: Row(
          children: [
            Icon(Icons.reply, size: 18),
            SizedBox(width: 8),
            Text('Reply'),
          ],
        ),
        onTap: () {
          setState(() {
            _replyingToMessage = message;
          });
        },
      ),
      PopupMenuItem(
        child: Row(
          children: [
            Icon(Icons.edit, size: 18),
            SizedBox(width: 8),
            Text('Edit'),
          ],
        ),
        onTap: () {
          setState(() {
            _editingMessage = message;
            _messageController.text = message.message;
          });
        },
      ),
      PopupMenuItem(
        child: Row(
          children: [
            Icon(Icons.delete, size: 18, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete', style: TextStyle(color: Colors.red)),
          ],
        ),
        onTap: () => _deleteMessage(message),
      ),
    ],
  );
}
```

---

## 🔄 Barber Side Chat System - To'liq Prompt

### Barber Side Chat System Features

Barber side'da chat tizimi client side bilan bir xil ishlaydi, lekin quyidagi farqlar bor:

1. **Chat List**: Barber barcha mijozlar bilan chatlarini ko'radi
2. **Order Integration**: Order qabul qilinganda, boshlanganda, tugatilganda avtomatik chat xabari yuboriladi
3. **Client Info**: Chat'da mijoz ma'lumotlari ko'rsatiladi
4. **Order Details**: Order bilan bog'liq xabarlarda order ma'lumotlari ko'rsatiladi

---

## 📁 Barber Side Chat Structure

```
lib/features/chats/
├── models/
│   ├── chat.dart              # Chat, ChatMessage, ChatUser models
│   ├── chat.freezed.dart
│   └── chat.g.dart
├── screens/
│   ├── chat_list_screen.dart      # Barcha chatlar ro'yxati
│   └── chat_messages_screen.dart  # Xabarlar ekrani
└── services/
    └── chat_service.dart          # Chat API service
```

---

## 🎯 Barber Side Chat Implementation

### 1. **Chat List Screen (Barber Side)**

**Features:**
- Barcha mijozlar bilan chatlar ro'yxati
- Har bir chat kartasida:
  - **Mijoz avatar** (yoki initial)
  - **Mijoz ismi**
  - **Oxirgi xabar** (preview)
  - **Vaqt** (HH:mm)
  - **Unread badge** (o'qilmagan xabarlar soni)
  - **Order badge** (agar order bilan bog'liq bo'lsa)
- Tap → Chat Messages Screen'ga o'tadi
- Search: Mijoz ismi bo'yicha qidirish

**Implementation:**
```dart
class ChatListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text('Chats'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Chat>>(
        future: ref.read(chatServiceProvider).listChats(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chats = snapshot.data!;
            
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                // Barber side'da: otherUser = client
                final client = chat.users.firstWhere(
                  (u) => u.id != currentBarberId,
                );
                final hasUnread = chat.latestMessage?.isRead == false;
                final unreadCount = _getUnreadCount(chat);
                
                return _ChatCard(
                  chat: chat,
                  client: client,
                  hasUnread: hasUnread,
                  unreadCount: unreadCount,
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
    );
  }
}
```

### 2. **Chat Messages Screen (Barber Side)**

**Features:**
- Xuddi client side kabi, lekin:
  - **Mijoz ma'lumotlari** header'da ko'rsatiladi
  - **Order info** (agar order bilan bog'liq bo'lsa)
  - **Quick actions**: 
    - Order yaratish (mijozga)
    - Mijoz profilini ko'rish
- Barcha client side funksiyalar (reply, edit, delete)

**Implementation:**
```dart
class ChatMessagesScreen extends ConsumerStatefulWidget {
  final int chatId;
  final int? clientId; // Mijoz ID (optional)

  @override
  ConsumerState<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends ConsumerState<ChatMessagesScreen> {
  // Xuddi client side kabi implementation
  // Lekin header'da mijoz ma'lumotlari ko'rsatiladi
  
  Widget _buildHeader() {
    return FutureBuilder<Chat>(
      future: ref.read(chatServiceProvider).getChat(widget.chatId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SizedBox.shrink();
        
        final chat = snapshot.data!;
        final client = chat.users.firstWhere(
          (u) => u.id != currentBarberId,
        );
        
        return SliverAppBar(
          expandedHeight: 100,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(client.name),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0A84FF), Color(0xFF4DA8FF)],
                ),
              ),
            ),
          ),
          actions: [
            // Order yaratish button (mijozga)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _createOrderForClient(),
            ),
            // Mijoz profilini ko'rish
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => _viewClientProfile(),
            ),
          ],
        );
      },
    );
  }
}
```

### 3. **Order Integration (Barber Side)**

**Avtomatik Chat Xabarlari:**

#### Order Qabul Qilinganda:
```dart
Future<void> acceptOrder(int orderId) async {
  final order = await ref.read(orderServiceProvider).startOrder(orderId);
  
  // Chat'ga avtomatik xabar yuborish
  final chat = await ref.read(chatServiceProvider).createOrGetChat(
    order.clientId,
  );
  
  await ref.read(chatServiceProvider).sendMessage(
    chatId: chat.id,
    message: 'Bron qabul qilindi',
    orderId: orderId,
  );
}
```

#### Order Tugatilganda:
```dart
Future<void> finishOrder(int orderId) async {
  final order = await ref.read(orderServiceProvider).finishOrder(orderId);
  
  // Chat'ga avtomatik xabar yuborish
  final chat = await ref.read(chatServiceProvider).createOrGetChat(
    order.clientId,
  );
  
  await ref.read(chatServiceProvider).sendMessage(
    chatId: chat.id,
    message: 'Xizmat yakunlandi. Rahmat!',
    orderId: orderId,
  );
}
```

#### Order Bekor Qilinganda:
```dart
Future<void> cancelOrder(int orderId) async {
  final order = await ref.read(orderServiceProvider).cancelOrder(orderId);
  
  // Chat'ga avtomatik xabar yuborish
  final chat = await ref.read(chatServiceProvider).createOrGetChat(
    order.clientId,
  );
  
  await ref.read(chatServiceProvider).sendMessage(
    chatId: chat.id,
    message: 'Bron bekor qilindi',
    orderId: orderId,
  );
}
```

---

## 🔧 Technical Details

### Real-time Updates (Polling)

**Client Side va Barber Side'da bir xil:**

```dart
Timer? _refreshTimer;

@override
void initState() {
  super.initState();
  _fetchMessages();
  // Har 2-3 soniyada yangilash
  _refreshTimer = Timer.periodic(const Duration(seconds: 2), (_) {
    _fetchMessages(silent: true);
  });
}

@override
void dispose() {
  _refreshTimer?.cancel();
  super.dispose();
}
```

### Message Sending Logic

```dart
Future<void> _sendMessage() async {
  final message = _messageController.text.trim();
  if (message.isEmpty) return;

  setState(() => _isSending = true);

  try {
    if (_editingMessage != null) {
      // Edit existing message
      await ref.read(chatServiceProvider).updateMessage(
        chatId: widget.chatId,
        messageId: _editingMessage!.id,
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
        replyToId: _replyingToMessage?.id,
      );
      setState(() {
        _replyingToMessage = null;
        _messageController.clear();
      });
    }
    
    // Yangi xabarlarni yuklash
    _fetchMessages();
    _scrollToBottom();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  } finally {
    setState(() => _isSending = false);
  }
}
```

### Message Deletion

```dart
Future<void> _deleteMessage(ChatMessage message) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Delete Message'),
      content: Text('Are you sure you want to delete this message?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );

  if (confirm == true) {
    try {
      await ref.read(chatServiceProvider).deleteMessage(
        chatId: widget.chatId,
        messageId: message.id,
      );
      _fetchMessages();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
```

### Scroll to Replied Message

```dart
void _scrollToMessage(int messageId) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final key = _messageKeys[messageId];
    if (key?.currentContext != null && _scrollController.hasClients) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  });
}
```

---

## 📱 Barber Side Chat - To'liq Implementation Checklist

### Phase 1: Models
- [ ] Chat model (Chat, ChatMessage, ChatUser)
- [ ] Freezed code generation
- [ ] JSON serialization

### Phase 2: Service
- [ ] ChatService class
- [ ] listChats() method
- [ ] createOrGetChat() method
- [ ] getChat() method
- [ ] listMessages() method
- [ ] sendMessage() method
- [ ] updateMessage() method
- [ ] deleteMessage() method
- [ ] markAsRead() method
- [ ] Null handling (is_read normalization)

### Phase 3: Chat List Screen
- [ ] Chat list UI
- [ ] Chat cards (mijoz ismi, oxirgi xabar, vaqt)
- [ ] Unread badge
- [ ] Search functionality
- [ ] Empty state
- [ ] Error handling
- [ ] Refresh indicator

### Phase 4: Chat Messages Screen
- [ ] Messages list (reverse ListView)
- [ ] Message bubbles (sent/received)
- [ ] Reply functionality
- [ ] Edit functionality
- [ ] Delete functionality
- [ ] Real-time polling (2-3 soniya)
- [ ] Auto scroll to bottom
- [ ] Scroll to replied message
- [ ] Message input field
- [ ] Send button
- [ ] Loading states
- [ ] Error handling

### Phase 5: Order Integration
- [ ] Order qabul qilinganda chat xabari
- [ ] Order tugatilganda chat xabari
- [ ] Order bekor qilinganda chat xabari
- [ ] Order detail'ga link (chat xabarida)

### Phase 6: Polish
- [ ] Animations
- [ ] Empty states
- [ ] Error messages
- [ ] Loading indicators
- [ ] Unread count badge

---

## 🎨 Design Specifications

### Color Scheme
- **Sent messages**: `#0A84FF` (Blue)
- **Received messages**: `#FFFFFF` (White)
- **Unread badge**: `#0A84FF` (Blue)
- **Reply preview**: `rgba(255,255,255,0.2)` (sent) yoki `#E5E7EB` (received)

### Message Bubble Style
- **Border radius**: 16px
- **Padding**: 12px
- **Margin**: 8px bottom, 50px left/right
- **Shadow**: Light shadow for received messages

### Typography
- **Message text**: 15px, regular
- **Time**: 11px, light color
- **Reply preview**: 12px, italic

---

## 🔄 Key Differences: Client vs Barber Side

### Client Side:
- Barberlar bilan chat qiladi
- Order yaratilganda chat xabari yuboriladi
- Order bekor qilinganda chat xabari yuboriladi

### Barber Side:
- Mijozlar bilan chat qiladi
- Order qabul qilinganda chat xabari yuboriladi (backend)
- Order tugatilganda chat xabari yuboriladi
- Order bekor qilinganda chat xabari yuboriladi
- Mijoz ma'lumotlari ko'rsatiladi
- Order yaratish funksiyasi (mijozga)

---

## 📝 Notes

1. **Real-time**: Hozircha polling ishlatiladi (2-3 soniya). Kelajakda WebSocket yoki Pusher qo'shilishi mumkin
2. **Null Handling**: `is_read` field null bo'lishi mumkin, shuning uchun `?? false` ishlatiladi
3. **Performance**: `_sameMessages` check orqali UI flicker oldini olinadi
4. **Scroll Behavior**: `reverse: true` ListView + `animateTo(0.0)` orqali eng pastga scroll qiladi
5. **Message Keys**: Har bir xabar uchun `GlobalKey` yaratiladi, reply'ga scroll qilish uchun

---

Bu prompt yordamida barber side uchun to'liq chat tizimini yaratishingiz mumkin! 🚀
