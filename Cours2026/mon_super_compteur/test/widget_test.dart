// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mon_super_compteur/main.dart';

void main() {
  testWidgets('Welcome screen displays title and button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.textContaining('comptez vos objectifs'), findsOneWidget);
    expect(find.text('Commencer à compter'), findsOneWidget);
  });

  testWidgets('Back button navigates to WelcomeScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Navigate to counter screen
    await tester.tap(find.text('Commencer à compter'));
    await tester.pumpAndSettle();

    // Verify we are on the counter screen
    expect(find.text('Mes Petits Totaux'), findsOneWidget);

    // Tap the back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify we are back on the welcome screen
    expect(find.text('Commencer à compter'), findsOneWidget);
    expect(find.textContaining('comptez vos objectifs'), findsOneWidget);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Navigate to counter screen
    await tester.tap(find.text('Commencer à compter'));
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
