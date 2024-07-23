import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:localstore/localstore.dart";
import "package:overlay_support/overlay_support.dart";
import "package:provider/provider.dart";

import "../providers/member.dart";

class NotificationService {
  static final _userId = FirebaseAuth.instance.currentUser!.uid;
  static final _messaging = FirebaseMessaging.instance;
  static final _db = Localstore.instance;

  static Future<void> initializeService(BuildContext context) async {
    NotificationSettings settings = await _messaging.requestPermission();
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        showSimpleNotification(
          Text(
            message.notification!.title!,
            textAlign: TextAlign.center,
          ),
          background: Theme.of(context).colorScheme.primary,
          foreground: Theme.of(context).colorScheme.secondary,
        );
        await _db.collection("$_userId/trades").doc(message.messageId).set({
          "title": message.notification?.title,
          "body": message.notification?.body,
        });
        await Provider.of<Member>(context, listen: false).fetchTrades();
      });

      FirebaseMessaging.onMessageOpenedApp.listen((_) async {
        await Navigator.of(context)
            .pushNamed("/tabs", arguments: {"initialIndex": 3});
      });
    }
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    await _db.collection("$_userId/trades").doc(message.messageId).set({
      "title": message.notification?.title,
      "body": message.notification?.body,
    });
  }

  static Future<void> subscribeToNotifications() async {
    await _messaging.subscribeToTopic("members");
  }

  static Future<void> unsubscribeToNotifications() async {
    await _messaging.unsubscribeFromTopic("members");
  }
}
