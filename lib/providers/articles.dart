import "dart:convert";

import "package:flutter/foundation.dart";
import "package:localstore/localstore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:http/http.dart" as http;

import "../models/article.dart";

class Articles extends ChangeNotifier {
  final db = Localstore.instance;

  final _url = Uri.parse(
    "https://newsapi.org/v2/top-headlines?country=in&category=business",
  );
  final _headers = {"X-Api-Key": const String.fromEnvironment("NEWS_API")};

  List<Article> _items = [];
  List<Article> _savedItems = [];

  String get _userId {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  List<Article> get items {
    return [..._items];
  }

  List<Article> get savedItems {
    return [..._savedItems];
  }

  Future<void> fetchArticles() async {
    try {
      final response = await http.get(_url, headers: _headers);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final articleData =
          List<Map<dynamic, dynamic>>.from(extractedData['articles']);
      final loadedArticles = articleData
          .map(
            (data) => Article(
              id: data['publishedAt'] ?? "",
              title: data['title'] ?? "",
              url: data['url'] ?? "",
              imageUrl: data['urlToImage'] ?? "",
              publishedAt: DateTime.parse(data['publishedAt']),
            ),
          )
          .toList();
      _items = loadedArticles;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Article findById(String id) {
    return _items.firstWhere((article) => article.id == id);
  }

  Article findSavedById(String id) {
    return _savedItems.firstWhere((article) => article.id == id);
  }

  bool containsSaved(String id) {
    return _savedItems.any((article) => article.id == id);
  }

  Future<void> saveArticle(String id) async {
    final data = findById(id);
    _savedItems.add(data);
    await db.collection("$_userId/articles").doc(id).set({
      "id": data.id,
      "title": data.title,
      "imageUrl": data.imageUrl,
      "url": data.url,
      "publishedAt": data.publishedAt.toString(),
    });
    notifyListeners();
  }

  Future<void> removeSavedArticle(String id) async {
    await db.collection("$_userId/articles").doc(id).delete();
    _savedItems.remove(findSavedById(id));
    notifyListeners();
  }

  Future<void> fetchSavedArticles() async {
    final data = await db.collection("$_userId/articles").get();
    final List<dynamic> extractedData =
        data!.entries.map((entry) => entry.value).toList();
    final List<Article> articleList =
        extractedData.map((article) => Article.fromMap(article)).toList();
    _savedItems = articleList;
    notifyListeners();
  }
}
