import 'package:flutter/material.dart';
import 'package:_21tradeasn01/feature/watchlist/watchlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      cardTheme: const CardThemeData(margin: EdgeInsets.zero),
    );

    final darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      cardTheme: const CardThemeData(margin: EdgeInsets.zero),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '21 Trade Assignment 01',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: WatchlistPage(),
    );
  }
}
