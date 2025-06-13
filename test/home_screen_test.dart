import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cigarette_tracker/views/home_screen.dart';
import 'package:cigarette_tracker/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('HomeScreen', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({}); // Clear any previous data
    });

    testWidgets('HomeScreen displays title and buttons', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.text('Cigarette Tracker'), findsOneWidget);
      expect(find.text('Press the button to log a cigarette:'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Log Cigarette'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'View Analytics'), findsOneWidget);
    });

    testWidgets('Tapping Log Cigarette button shows SnackBar', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      await tester.tap(find.widgetWithText(ElevatedButton, 'Log Cigarette'));
      await tester.pump(); // Rebuild the widget after the button tap

      expect(find.text('Cigarette logged!'), findsOneWidget);
    });

    testWidgets('Tapping View Analytics button navigates to AnalyticsScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/': (context) => const HomeScreen(),
          '/analytics': (context) => const Text('Analytics Screen Content'), // Mock AnalyticsScreen
        },
      ));

      await tester.tap(find.widgetWithText(ElevatedButton, 'View Analytics'));
      await tester.pumpAndSettle(); // Wait for navigation animation to complete

      expect(find.text('Analytics Screen Content'), findsOneWidget);
    });
  });
}

