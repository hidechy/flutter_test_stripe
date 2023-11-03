import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class CustomTheme {
  static const Color grey = Color(0xffdfdfdf);
  static const Color yellow = Color(0xffffd847);

  static const cardShadow = [BoxShadow(color: Colors.grey, blurRadius: 6, spreadRadius: 4, offset: Offset(0, 2))];

  static const buttonShadow = [BoxShadow(color: Colors.grey, blurRadius: 3, spreadRadius: 4, offset: Offset(1, 3))];

  ///
  static BoxDecoration getCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(35),
      boxShadow: cardShadow,
    );
  }

  ///
  static ThemeData getTheme() {
    final fontSize = <String, double>{'sm': 14, 'md': 18, 'lg': 24};

    return ThemeData(
      primaryColor: yellow,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        toolbarHeight: 70,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: fontSize['lg'],
          fontWeight: FontWeight.bold,
          letterSpacing: 4,
        ),
      ),
      tabBarTheme: const TabBarTheme(labelColor: yellow, unselectedLabelColor: Colors.black),
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: Colors.black, fontSize: fontSize['lg'], fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: Colors.black, fontSize: fontSize['md'], fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(color: Colors.black, fontSize: fontSize['sm'], fontWeight: FontWeight.bold),
        titleSmall: TextStyle(fontSize: fontSize['sm'], fontWeight: FontWeight.bold, letterSpacing: 1),
        bodySmall: TextStyle(fontSize: fontSize['sm'], fontWeight: FontWeight.normal),
      ),
    );
  }
}
