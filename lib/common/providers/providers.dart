import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/features/auth/services/auth_service.dart';
import 'package:mobile/features/barbers/services/barber_service.dart';
import 'package:mobile/features/barbers/services/available_slots_service.dart';
import 'package:mobile/features/chats/services/chat_service.dart';
import 'package:mobile/features/orders/services/order_service.dart';
import 'package:mobile/features/ratings/services/rating_service.dart';
import 'package:mobile/features/services/services/service_service.dart';
import 'package:mobile/features/shops/services/shop_service.dart';
import 'package:mobile/features/stats/services/stats_service.dart';
import 'package:mobile/features/walkin/services/walkin_service.dart';

/// API Client provider
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

/// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(apiClientProvider));
});

/// Shop service provider
final shopServiceProvider = Provider<ShopService>((ref) {
  return ShopService(ref.watch(apiClientProvider));
});

/// Barber service provider
final barberServiceProvider = Provider<BarberService>((ref) {
  return BarberService(ref.watch(apiClientProvider));
});

/// Available slots service provider
final availableSlotsServiceProvider = Provider<AvailableSlotsService>((ref) {
  return AvailableSlotsService(ref.watch(apiClientProvider));
});

/// Service service provider
final serviceServiceProvider = Provider<ServiceService>((ref) {
  return ServiceService(ref.watch(apiClientProvider));
});

/// Order service provider
final orderServiceProvider = Provider<OrderService>((ref) {
  return OrderService(ref.watch(apiClientProvider));
});

/// Walk-in service provider
final walkInServiceProvider = Provider<WalkInService>((ref) {
  return WalkInService(ref.watch(apiClientProvider));
});

/// Chat service provider
final chatServiceProvider = Provider<ChatService>((ref) {
  return ChatService(ref.watch(apiClientProvider));
});

/// Total unread chats count (polls every 3 seconds).
///
/// Note: backend `unread_count` should already reflect unread messages from the barber.
/// We additionally guard against counting messages sent by the current user.
final unreadChatsCountProvider = StreamProvider.autoDispose<int>((ref) async* {
  var disposed = false;
  ref.onDispose(() {
    disposed = true;
  });

  int? currentUserId;

  while (!disposed) {
    try {
      currentUserId ??= (await ref.read(authServiceProvider).getCurrentUser()).id;

      final chats = await ref.read(chatServiceProvider).listChats();
      var total = 0;

      for (final chat in chats) {
        final latestMessage = chat.latestMessage;
        final uid = currentUserId;
        final isLatestMessageFromCurrentUser =
            latestMessage != null && latestMessage.userId == uid;

        int unreadCount;
        if (isLatestMessageFromCurrentUser) {
          unreadCount = 0;
        } else if (chat.unreadCount != null && chat.unreadCount! > 0) {
          unreadCount = chat.unreadCount!;
        } else if (latestMessage != null && !latestMessage.isRead) {
          unreadCount = 1;
        } else {
          unreadCount = 0;
        }

        total += unreadCount;
      }

      yield total;
    } catch (_) {
      // If anything fails (network/auth), don't show a badge.
      yield 0;
    }

    await Future.delayed(const Duration(seconds: 3));
  }
});

/// Rating service provider
final ratingServiceProvider = Provider<RatingService>((ref) {
  return RatingService(ref.watch(apiClientProvider));
});

/// Stats service provider
final statsServiceProvider = Provider<StatsService>((ref) {
  return StatsService(ref.watch(apiClientProvider));
});

