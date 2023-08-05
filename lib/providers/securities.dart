import 'dart:convert';

import "package:flutter/foundation.dart";
import "package:localstore/localstore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:http/http.dart" as http;

import '../models/security.dart';

class Securities extends ChangeNotifier {
  final db = Localstore.instance;

  final _url = Uri.parse(
    "https://yh-finance.p.rapidapi.com/market/get-trending-tickers",
  );

  final _headers = {
    "X-RapidAPI-Host": "yh-finance.p.rapidapi.com",
    "X-RapidAPI-Key": const String.fromEnvironment("STOCK_API")
  };

  List<Security> _items = [];
  List<Security> _savedItems = [];

  String get _userId {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  List<Security> get items {
    return [..._items];
  }

  List<Security> get savedItems {
    return [..._savedItems];
  }

  Future<void> fetchSecurities() async {
    try {
      final response = await http.get(_url, headers: _headers);
      final extractedData = json.decode(response.body)['finance']['result'][0];
      final assetData =
          List<Map<dynamic, dynamic>>.from(extractedData['quotes']);

      final List<Security> assetList = assetData
          .map((asset) => Security(
                id: asset['symbol'],
                name: asset['shortName'],
                ticker: asset['symbol'],
                type: asset['quoteType'],
                exchange: asset['fullExchangeName'],
                price: asset['regularMarketPrice'],
                dayChange: asset['regularMarketChange'],
                dayChangePercent: asset['regularMarketChangePercent'],
              ))
          .toList();

      _items = assetList
          .where((asset) => asset.type == "EQUITY" || asset.type == "INDEX")
          .toList();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  bool containsSaved(String ticker) {
    return _savedItems.any((item) => item.ticker == ticker);
  }

  Security findByTicker(String ticker) {
    return _items.firstWhere((item) => item.ticker == ticker);
  }

  Security findSavedByTicker(String ticker) {
    return _savedItems.firstWhere((item) => item.ticker == ticker);
  }

  Future<void> saveSecurity(String ticker) async {
    Security security = findByTicker(ticker);
    _savedItems.add(security);
    await db.collection("$_userId/tickers").doc(ticker).set({
      "id": security.id,
      "name": security.name,
      "price": security.price,
      "ticker": security.ticker,
      "type": security.type,
      "exchange": security.exchange,
      "dayChange": security.dayChange,
      "dayChangePercent": security.dayChangePercent
    });
    notifyListeners();
  }

  Future<void> removeSavedSecurity(String ticker) async {
    await db.collection("$_userId/tickers").doc(ticker).delete();
    _savedItems.remove(findByTicker(ticker));
    notifyListeners();
  }

  Future<void> fetchSavedSecurities() async {
    final data = await db.collection("$_userId/tickers").get();
    final List<dynamic> extractedData =
        data?.entries.map((entry) => entry.value).toList() ?? [];

    final List<Security> securityList = extractedData
        .map((security) => Security.fromMap(security as Map<String, dynamic>))
        .toList();
    _savedItems = securityList;
    notifyListeners();
  }
}
