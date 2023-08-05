import 'dart:convert';

class Article {
  final String id;
  final String title;
  final String url;
  final String imageUrl;
  final DateTime publishedAt;

  const Article({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'url': url,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt.toString(),
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as String,
      title: map['title'] as String,
      url: map['url'] as String,
      imageUrl: map['imageUrl'] as String,
      publishedAt: DateTime.parse(map['publishedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source) as Map<String, dynamic>);
}
