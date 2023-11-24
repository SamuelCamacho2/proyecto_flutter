import 'package:flutter/material.dart';

class MyTheme {

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: Color.fromRGBO(109, 191, 248, 0.784)),
    elevatedButtonTheme: ElevatedButtonThemeData(style:ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(109, 191, 248, 0.784))),
  );
}