import 'package:shared_preferences/shared_preferences.dart';

/// Storage utility for managing local data (tokens, preferences, etc.)
class Storage {
  static const String _tokenKey = 'auth_token';
  static const String _ratedOrdersKey = 'rated_orders';
  static const String _orderRatingsKey = 'order_ratings'; // ["123=5", "124=4"]
  static const String _themeModeKey = 'theme_mode'; // system | light | dark

  /// Save authentication token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Get authentication token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Remove authentication token
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  /// Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear all stored data
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// Save theme mode preference: "system", "light", or "dark"
  static Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode);
  }

  /// Get theme mode preference: "system", "light", or "dark"
  static Future<String> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_themeModeKey);
    if (v == 'light' || v == 'dark' || v == 'system') return v!;
    return 'system';
  }

  /// Get locally cached rated order IDs (used to suppress duplicate rating prompts)
  static Future<Set<int>> getRatedOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_ratedOrdersKey) ?? const <String>[];
    final out = <int>{};
    for (final s in raw) {
      final v = int.tryParse(s);
      if (v != null) out.add(v);
    }
    return out;
  }

  /// Add an orderId to locally cached rated orders
  static Future<void> addRatedOrder(int orderId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = (prefs.getStringList(_ratedOrdersKey) ?? <String>[]).toList();
    final s = orderId.toString();
    if (!raw.contains(s)) {
      raw.add(s);
      await prefs.setStringList(_ratedOrdersKey, raw);
    }
  }

  /// Save rating value for an order (used to show "you rated X⭐" in chat)
  static Future<void> saveOrderRating({
    required int orderId,
    required int rating,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final raw =
        (prefs.getStringList(_orderRatingsKey) ?? <String>[]).toList();

    final prefix = '$orderId=';
    raw.removeWhere((e) => e.startsWith(prefix));
    raw.add('$orderId=$rating');
    await prefs.setStringList(_orderRatingsKey, raw);
  }

  /// Load locally cached order ratings map: orderId -> rating
  static Future<Map<int, int>> getOrderRatings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_orderRatingsKey) ?? const <String>[];
    final out = <int, int>{};

    for (final entry in raw) {
      final parts = entry.split('=');
      if (parts.length != 2) continue;
      final orderId = int.tryParse(parts[0]);
      final rating = int.tryParse(parts[1]);
      if (orderId == null || rating == null) continue;
      out[orderId] = rating;
    }

    return out;
  }
}

