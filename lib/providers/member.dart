// ignore_for_file: prefer_interpolation_to_compose_strings
import "dart:convert";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:localstore/localstore.dart";
import "package:http/http.dart" as http;

import "../utils/member_exception.dart";
import "../services/notification_service.dart";
import "../models/trade_notification.dart";

class Member extends ChangeNotifier {
  final db = Localstore.instance;
  final _userId = FirebaseAuth.instance.currentUser?.uid;

  final _baseUrl = "https://api.stripe.com/v1/customers?email=";
  final _headers = {
    "authorization": "Basic " +
        base64Encode(utf8.encode(const String.fromEnvironment("STRIPE_API")))
  };

  bool _isMember = false;
  List<TradeNotification> _trades = [];

  bool get isMember {
    return _isMember;
  }

  List<TradeNotification> get trades {
    return _trades;
  }

  Future<String> _resolveMemberEmail() async {
    final data = await db.collection("$_userId/member").doc(_userId).get();
    if (data == null) {
      return FirebaseAuth.instance.currentUser!.email as String;
    } else {
      return data["email"];
    }
  }

  Future<void> checkMemberStatus() async {
    final email = await _resolveMemberEmail();
    final response =
        await http.get(Uri.parse(_baseUrl + email), headers: _headers);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final memberData = List<Map<dynamic, dynamic>>.from(extractedData["data"]);

    _isMember = memberData.isNotEmpty;
    await NotificationService.subscribeToNotifications();
    notifyListeners();
  }

  Future<void> checkMemberStatusWithEmail(String userEmail) async {
    final response =
        await http.get(Uri.parse(_baseUrl + userEmail), headers: _headers);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final memberData = List<Map<dynamic, dynamic>>.from(extractedData["data"]);

    if (memberData.isEmpty) {
      throw MemberException("No Subscription found on this account.");
    } else {
      await db.collection("$_userId/member").doc(_userId).set({
        "email": userEmail,
      });
      _isMember = memberData.isNotEmpty;
      await NotificationService.subscribeToNotifications();
      notifyListeners();
    }
  }

  Future<void> fetchTrades() async {
    final data = await db.collection("$_userId/trades").get();
    if (data == null) {
      return;
    }

    final List<dynamic> extractedData =
        data.entries.map((entry) => entry.value).toList();
    final List<TradeNotification> tradeList =
        extractedData.map((trade) => TradeNotification.fromMap(trade)).toList();
    _trades = tradeList;
    notifyListeners();
  }
}
