class TradeNotification {
  final String title;
  final String body;
  final String ticker;
  final String position;
  final double entryPrice;
  final double stopLoss;
  final double takeProfit;

  const TradeNotification({
    required this.title,
    required this.body,
    required this.ticker,
    required this.position,
    required this.entryPrice,
    required this.stopLoss,
    required this.takeProfit,
  });

  factory TradeNotification.fromMap(Map<String, dynamic> map) {
    return TradeNotification(
      title: map["title"] as String,
      body: map["body"] as String,
      ticker: map["ticker"] as String,
      position: map["position"] as String,
      entryPrice: map["entryPrice"] as double,
      stopLoss: map["stopLoss"] as double,
      takeProfit: map["takeProfit"] as double,
    );
  }
}
