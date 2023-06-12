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
}
