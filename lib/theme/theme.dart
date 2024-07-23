import "package:flutter/material.dart";

final appTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    secondary: Colors.white,
    surface: Colors.white,
    error: Color.fromRGBO(247, 49, 49, 1),
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    color: Colors.white,
    elevation: 0.0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic,
      fontSize: 22,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "Poppins",
      fontSize: 15,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Poppins",
      fontSize: 18,
      color: Colors.black,
    ),
    displayLarge: TextStyle(
      fontFamily: "Poppins",
      color: Colors.black,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: 26,
    ),
    displayMedium: TextStyle(
      fontFamily: "Poppins",
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    labelLarge: TextStyle(
      fontFamily: "Poppins",
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
);
