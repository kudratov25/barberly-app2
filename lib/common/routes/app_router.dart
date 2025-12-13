import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/utils/storage.dart';
import 'package:mobile/features/auth/screens/login_screen.dart';
import 'package:mobile/features/auth/screens/register_screen.dart';
import 'package:mobile/features/barbers/screens/barber_booking_screen.dart';
import 'package:mobile/features/barbers/models/barber.dart';
import 'package:mobile/features/barbers/screens/barber_schedule_screen.dart';
import 'package:mobile/features/chats/screens/chat_list_screen.dart';
import 'package:mobile/features/chats/screens/chat_messages_screen.dart';
import 'package:mobile/features/orders/screens/new_order_screen.dart';
import 'package:mobile/features/orders/screens/order_detail_screen.dart';
import 'package:mobile/features/orders/screens/orders_list_screen.dart';
import 'package:mobile/features/profile/screens/profile_screen.dart';
import 'package:mobile/features/profile/screens/settings_screen.dart';
import 'package:mobile/features/ratings/screens/create_rating_screen.dart';
import 'package:mobile/features/services/screens/service_detail_screen.dart';
import 'package:mobile/features/services/screens/services_list_screen.dart';
import 'package:mobile/features/shops/screens/shop_detail_screen.dart';
import 'package:mobile/features/shops/screens/shops_list_screen.dart';
import 'package:mobile/features/shops/screens/workers_list_screen.dart';
import 'package:mobile/features/ai/screens/ai_screen.dart';
import 'package:mobile/features/notifications/screens/notifications_screen.dart';
import 'package:mobile/features/stats/screens/stats_screen.dart';
import 'package:mobile/features/walkin/screens/walkin_list_screen.dart';
import 'package:mobile/features/walkin/screens/walkin_session_screen.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/splash_screen.dart';

/// App router configuration with go_router
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) async {
      final isAuthenticated = await Storage.isAuthenticated();
      final isLoginRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isAuthenticated && !isLoginRoute) {
        return '/login';
      }
      if (isAuthenticated && isLoginRoute) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/shops',
        builder: (context, state) => const ShopsListScreen(),
      ),
      GoRoute(
        path: '/shops/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ShopDetailScreen(shopId: id);
        },
      ),
      GoRoute(
        path: '/shops/:id/workers',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return WorkersListScreen(shopId: id);
        },
      ),
      GoRoute(
        path: '/services',
        builder: (context, state) => const ServicesListScreen(),
      ),
      GoRoute(
        path: '/services/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ServiceDetailScreen(serviceId: id);
        },
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersListScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/orders/new',
        builder: (context, state) => const NewOrderScreen(),
      ),
      GoRoute(
        path: '/orders/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return OrderDetailScreen(orderId: id);
        },
      ),
      GoRoute(
        path: '/barbers/:id/book',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final extra = state.extra;
          final barber = extra is Barber ? extra : null;
          return BarberBookingScreen(
            barberId: id,
            barber: barber,
          );
        },
      ),
      GoRoute(
        path: '/barbers/schedule',
        builder: (context, state) => const BarberScheduleScreen(),
      ),
      GoRoute(
        path: '/walkin',
        builder: (context, state) => const WalkInListScreen(),
      ),
      GoRoute(
        path: '/walkin/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return WalkInSessionScreen(walkInId: id);
        },
      ),
      GoRoute(
        path: '/chats',
        builder: (context, state) => const ChatListScreen(),
      ),
      GoRoute(
        path: '/chats/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ChatMessagesScreen(chatId: id);
        },
      ),
      GoRoute(
        path: '/ratings/new',
        builder: (context, state) {
          final orderId = state.uri.queryParameters['orderId'];
          return CreateRatingScreen(
            orderId: orderId != null ? int.parse(orderId) : null,
          );
        },
      ),
      GoRoute(path: '/stats', builder: (context, state) => const StatsScreen()),
      GoRoute(
        path: '/ai',
        builder: (context, state) => const AIScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
