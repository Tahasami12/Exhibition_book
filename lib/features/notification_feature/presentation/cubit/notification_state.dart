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

class NotificationState {
  final List<NotificationTabData> deliveries;
  final List<NewsItem> news;

  const NotificationState({
    this.deliveries = const [],
    this.news = const [],
  });
}
