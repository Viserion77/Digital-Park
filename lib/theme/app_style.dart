import 'package:flutter/material.dart';

class AppStyle {
  Color get secondaryHeaderColor => const Color(0xFFaed581);
  Color get primaryColor => const Color(0xFF7cb342);

  ThemeData get defaultTheme => ThemeData(
        primaryColor: primaryColor,
        primaryColorLight: const Color(0xFFaee571),
        primaryColorDark: const Color(0xFF4b830d),
        primaryColorBrightness: Brightness.dark,
        primaryIconTheme: const IconThemeData(
          color: Color(0xFF212121),
          size: 16.0,
        ),
        // primarySwatch: Colors.red,
        // primaryTextTheme: const TextTheme(),
        secondaryHeaderColor: secondaryHeaderColor,
        // accentColor: primaryColor,
        backgroundColor: const Color(0x007cb342),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFFaee571),
        ),

        tabBarTheme: TabBarTheme(
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: primaryColor,
                width: 2,
              ),
            ),
          ),
        ),

        buttonTheme: ButtonThemeData(
          buttonColor: secondaryHeaderColor,
          textTheme: ButtonTextTheme.primary,
        ),

        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: primaryColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: secondaryHeaderColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),

        unselectedWidgetColor: secondaryHeaderColor,
      );
}
