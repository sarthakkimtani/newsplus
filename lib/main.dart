// ignore_for_file: use_key_in_widget_constructors
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";

import "./providers/articles.dart";
import "./providers/securities.dart";
import "./screens/navigation/tabs_screen.dart";
import "./screens/auth_screen.dart";
import "./screens/settings_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Articles()),
        ChangeNotifierProvider(create: (ctx) => Securities()),
      ],
      child: MaterialApp(
        title: "News+",
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
          canvasColor: const Color(0xFFfafafa),
          primaryColor: Colors.black,
          appBarTheme: theme.appBarTheme.copyWith(
            iconTheme: const IconThemeData(color: Colors.black),
            color: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              fontSize: 22,
            ),
          ),
          textTheme: theme.textTheme.copyWith(
            bodyLarge: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 15,
              color: Colors.black,
            ),
            bodyMedium: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              color: Colors.black,
            ),
            displayLarge: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
            displayMedium: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            labelLarge: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          colorScheme: theme.colorScheme
              .copyWith(
                secondary: Colors.white,
              )
              .copyWith(error: const Color(0xFFf73131)),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, authSnapshot) {
            if (authSnapshot.hasData) {
              return TabsScreen();
            } else {
              return AuthScreen();
            }
          },
        ),
        routes: {
          AuthScreen.routeName: (_) => AuthScreen(),
          TabsScreen.routeName: (_) => TabsScreen(),
          SettingsScreen.routeName: (_) => SettingsScreen(),
        },
      ),
    );
  }
}