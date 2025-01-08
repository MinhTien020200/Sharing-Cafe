import 'package:flutter/material.dart';

import 'constants.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFE3C9AD),
      fontFamily: "Roboto",
      appBarTheme: const AppBarTheme(
          color: Color(0xFFE3C9AD),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFE3C9AD),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: kTextColor),
        bodyMedium: TextStyle(color: kTextColor),
        bodySmall: TextStyle(color: kTextColor),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }
}

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(28)),
  borderSide: BorderSide(color: kTextColor),
  gapPadding: 10,
);
