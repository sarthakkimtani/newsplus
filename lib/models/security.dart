class Security {
  final String id;
  final String name;
  final String ticker;
  final String type;
  final String exchange;
  final double price;
  final double dayChange;
  final double dayChangePercent;

  const Security({
    required this.id,
    required this.name,
    required this.ticker,
    required this.type,
    required this.exchange,
    required this.price,
    required this.dayChange,
    required this.dayChangePercent,
  });
}
