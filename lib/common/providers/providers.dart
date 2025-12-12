import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/features/auth/services/auth_service.dart';
import 'package:mobile/features/barbers/services/barber_service.dart';
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

/// Rating service provider
final ratingServiceProvider = Provider<RatingService>((ref) {
  return RatingService(ref.watch(apiClientProvider));
});

/// Stats service provider
final statsServiceProvider = Provider<StatsService>((ref) {
  return StatsService(ref.watch(apiClientProvider));
});

