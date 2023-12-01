import 'package:flutter/material.dart';

class MyTheme {

  static ThemeData lightTheme (BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: const Color.fromARGB(200, 109, 191, 248),
        secondary: const Color.fromRGBO(255, 255, 255, 0.999),
        tertiary: const Color.fromRGBO(1, 1, 1, 0.999),
      ),
    );
  }

  static ThemeData darktheme(BuildContext context){
    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: const Color.fromRGBO(91, 73, 120, 0.999),
        secondary: const Color.fromRGBO(1, 1, 1, 0.9),
        tertiary: const Color.fromRGBO(255, 255, 255, 0.999),
      ), 
    );
  }
}