class TradeNotification {
  final String title;
  final String body;

  const TradeNotification({
    required this.title,
    required this.body,
  });

  factory TradeNotification.fromMap(Map<String, dynamic> map) {
    return TradeNotification(
      title: map["title"] as String,
      body: map["body"] as String,
    );
  }
}
