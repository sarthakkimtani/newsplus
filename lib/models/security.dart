import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'ticker': ticker,
      'type': type,
      'exchange': exchange,
      'price': price,
      'dayChange': dayChange,
      'dayChangePercent': dayChangePercent,
    };
  }

  factory Security.fromMap(Map<String, dynamic> map) {
    return Security(
      id: map['id'] as String,
      name: map['name'] as String,
      ticker: map['ticker'] as String,
      type: map['type'] as String,
      exchange: map['exchange'] as String,
      price: map['price'] as double,
      dayChange: map['dayChange'] as double,
      dayChangePercent: map['dayChangePercent'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Security.fromJson(String source) =>
      Security.fromMap(json.decode(source) as Map<String, dynamic>);
}
