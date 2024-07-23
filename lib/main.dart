import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:overlay_support/overlay_support.dart";
import "package:provider/provider.dart";

import "./providers/articles.dart";
import "./providers/member.dart";
import "./providers/securities.dart";
import "./screens/auth_screen.dart";
import "./screens/navigation/tabs_screen.dart";
import "./screens/settings_screen.dart";
import "./services/notification_service.dart";
import "./theme/theme.dart";

@pragma("vm:entry-point")
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  await NotificationService.backgroundMessageHandler(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Articles()),
        ChangeNotifierProvider(create: (ctx) => Securities()),
        ChangeNotifierProvider(create: (ctx) => Member()),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          title: "News+",
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, authSnapshot) {
              if (authSnapshot.hasData) {
                return const TabsScreen();
              } else {
                return const AuthScreen();
              }
            },
          ),
          routes: {
            AuthScreen.routeName: (_) => const AuthScreen(),
            TabsScreen.routeName: (_) => const TabsScreen(),
            SettingsScreen.routeName: (_) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
