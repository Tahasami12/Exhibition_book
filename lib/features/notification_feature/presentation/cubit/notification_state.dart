import 'package:cloud_firestore/cloud_firestore.dart';

// ─── Order notification item (real data from Firestore) ──────────────────────

class NotificationOrderItem {
  final String orderId;
  final String status;
  final double totalAmount;
  final int itemCount;
  final String date;
  final Timestamp? createdAt;

  const NotificationOrderItem({
    required this.orderId,
    required this.status,
    required this.totalAmount,
    required this.itemCount,
    required this.date,
    this.createdAt,
  });
}

// ─── Promo notification item (real data from Firestore) ──────────────────────

class NotificationPromoItem {
  final String promoId;
  final String title;
  final String description;
  final dynamic discount;
  final String code;

  const NotificationPromoItem({
    required this.promoId,
    required this.title,
    required this.description,
    required this.discount,
    required this.code,
  });
}

// ─── Legacy models kept for backward compatibility ────────────────────────────

class NotificationTabData {
  final String film;
  final String status;
  final String quantity;
  final String poster;

  const NotificationTabData({
    required this.film,
    required this.status,
    required this.quantity,
    required this.poster,
  });
}

class NewsItem {
  final String type;
  final String date;
  final String time;
  final String description;

  const NewsItem({
    required this.type,
    required this.date,
    required this.time,
    required this.description,
  });
}

// ─── Main notification state ──────────────────────────────────────────────────

class NotificationState {
  final List<NotificationOrderItem> orders;
  final List<NotificationPromoItem> promos;
  final int unreadCount;

  // Legacy — kept for badge count compatibility
  List<NotificationTabData> get deliveries => [];
  List<NewsItem> get news => [];

  const NotificationState({
    this.orders = const [],
    this.promos = const [],
    this.unreadCount = 0,
  });

  /// Total unread count shown in the badge
  int get totalCount => unreadCount;

  NotificationState copyWith({
    List<NotificationOrderItem>? orders,
    List<NotificationPromoItem>? promos,
    int? unreadCount,
  }) {
    return NotificationState(
      orders: orders ?? this.orders,
      promos: promos ?? this.promos,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
