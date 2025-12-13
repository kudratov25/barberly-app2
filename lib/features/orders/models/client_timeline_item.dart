import 'package:mobile/features/orders/models/order.dart';
import 'package:mobile/features/walkin/models/walkin.dart';

/// A single item in the client's combined timeline list coming from GET /orders?role=client
/// Backend can return both:
/// - Order: type = "order"
/// - Walk-in: type = "walk_in"
class ClientTimelineItem {
  final String type; // "order" | "walk_in"
  final String? sortTime; // ISO string for sorting
  final Order? order;
  final WalkIn? walkIn;

  const ClientTimelineItem({
    required this.type,
    required this.sortTime,
    required this.order,
    required this.walkIn,
  });

  bool get isOrder => type == 'order' && order != null;
  bool get isWalkIn => type == 'walk_in' && walkIn != null;

  String get status {
    if (isOrder) return order!.status;
    if (isWalkIn) return walkIn!.status;
    return '';
  }

  int get price {
    if (isOrder) return order!.price;
    if (isWalkIn) return walkIn!.price ?? 0;
    return 0;
  }

  int get id {
    if (isOrder) return order!.id;
    if (isWalkIn) return walkIn!.id;
    return 0;
  }

  static ClientTimelineItem fromJson({
    required Map<String, dynamic> json,
    required Order Function(Map<String, dynamic>) parseOrder,
    required WalkIn Function(Map<String, dynamic>) parseWalkIn,
  }) {
    final t = (json['type'] as String?)?.toLowerCase();
    final inferredType = t ??
        (json.containsKey('start_time')
            ? 'order'
            : (json.containsKey('started_at') || json.containsKey('client_name'))
                ? 'walk_in'
                : 'order');

    final sortTime = json['sort_time'] as String? ??
        (inferredType == 'order'
            ? json['start_time'] as String?
            : (json['finished_at'] as String? ??
                json['started_at'] as String? ??
                json['created_at'] as String?));

    if (inferredType == 'walk_in') {
      return ClientTimelineItem(
        type: 'walk_in',
        sortTime: sortTime,
        order: null,
        walkIn: parseWalkIn(json),
      );
    }

    return ClientTimelineItem(
      type: 'order',
      sortTime: sortTime,
      order: parseOrder(json),
      walkIn: null,
    );
  }
}


