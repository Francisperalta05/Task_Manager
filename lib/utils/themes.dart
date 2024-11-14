import 'package:flutter/material.dart';

final outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
);

ThemeData get themes => ThemeData(
      // checkboxTheme: CheckboxThemeData(
      //   fillColor: WidgetStatePropertyAll(Colors.teal),
      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal, // Color vibrante
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          foregroundBuilder: (context, states, child) => SizedBox(
            width: double.infinity,
            child: Center(child: child),
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      primaryColor: Colors.teal,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
