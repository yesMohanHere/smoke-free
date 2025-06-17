import 'package:flutter/material.dart';
import 'package:cigarette_tracker/views/home_screen.dart';
import 'package:cigarette_tracker/views/analytics_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cigarette Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/analytics': (context) => const AnalyticsScreen(),
      },
    );
  }
}

