import 'package:flutter/material.dart';

class MyTheme {
  static const Color mywhite = Color(0xFFFFFFFF);

  static const Color myBlackDark = Color.fromARGB(255, 10, 26, 36);
  static const Color myBlackLight = Color.fromARGB(255, 13, 33, 46);
  static Color myYellow = Colors.grey[200]!;

  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      primary: Colors.black,
      seedColor: Colors.black,
      primaryContainer: myYellow,
    ),
    scaffoldBackgroundColor: mywhite,
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
      centerTitle: false,
      backgroundColor: mywhite,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: myBlackDark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      primary: mywhite,
      seedColor: mywhite,
      primaryContainer: myBlackLight,
    ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
      centerTitle: false,
      backgroundColor: myBlackDark,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
