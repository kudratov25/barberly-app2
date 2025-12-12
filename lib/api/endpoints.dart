/// API endpoint constants
class ApiEndpoints {
  // Update this to your Laravel backend URL (include port if needed)
  // For Laravel default: http://10.245.202.220:8000
  // For production: https://yourdomain.com
  static const String baseUrl = 'http://localhost:8000';
  static const String apiPrefix = '/api/v1';

  // Auth endpoints
  static const String register = '$apiPrefix/register';
  static const String login = '$apiPrefix/login';
  static const String logout = '$apiPrefix/logout';
  static const String me = '$apiPrefix/me';
  static const String updateLocation = '$apiPrefix/users/location';

  // Barbers endpoints
  static const String barbersNearest = '$apiPrefix/barbers/nearest';
  static const String barbersSchedule = '$apiPrefix/barbers/schedule';
  static const String barbersStatus = '$apiPrefix/barbers/status';
  static const String barbersLocation = '$apiPrefix/barbers/location';

  // Shops endpoints
  static const String shops = '$apiPrefix/shops';
  static String shop(int id) => '$shops/$id';
  static String shopWorkers(int id) => '$shops/$id/workers';
  static String shopSubscription(int id) => '$shops/$id/subscription';

  // Services endpoints
  static const String services = '$apiPrefix/services';
  static String service(int id) => '$services/$id';

  // Orders endpoints
  static const String orders = '$apiPrefix/orders';
  static String order(int id) => '$orders/$id';
  static String orderStart(int id) => '$orders/$id/start';
  static String orderFinish(int id) => '$orders/$id/finish';
  static String orderCancel(int id) => '$orders/$id/cancel';

  // Walk-in endpoints
  static const String walkin = '$apiPrefix/walkin';
  static String walkinSession(int id) => '$walkin/$id';
  static String walkinStart(int id) => '$walkin/$id/start';
  static String walkinFinish(int id) => '$walkin/$id/finish';

  // Chat endpoints
  static const String chats = '$apiPrefix/chats';
  static String chat(int id) => '$chats/$id';
  static String chatMessages(int id) => '$chats/$id/messages';
  static String chatMessage(int chatId, int messageId) => '$chats/$chatId/messages/$messageId';
  static String chatRead(int id) => '$chats/$id/read';

  // Ratings endpoints
  static const String ratings = '$apiPrefix/ratings';
  static String rating(int id) => '$ratings/$id';

  // Stats endpoints
  static const String statsDaily = '$apiPrefix/stats/me/daily';
  static const String statsMonthly = '$apiPrefix/stats/me/monthly';
  static const String statsAdminMonthly = '$apiPrefix/stats/admin/monthly';
  static const String statsAdminSubscriptions =
      '$apiPrefix/stats/admin/subscriptions';
}
