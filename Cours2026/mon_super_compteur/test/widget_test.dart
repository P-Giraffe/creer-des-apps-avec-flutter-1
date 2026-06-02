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
  testWidgets('Welcome screen shows the create button and empty state',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('comptez vos objectifs'), findsOneWidget);
    expect(find.text('Nouveau compteur'), findsOneWidget);
    expect(find.textContaining('Aucun compteur'), findsOneWidget);
  });

  testWidgets('Creating a counter navigates to its screen at value 0',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Nouveau compteur'));
    await tester.pumpAndSettle();

    // We are on the counter screen.
    expect(find.text('Mes Petits Totaux'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Back button returns to the welcome list with the new counter',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Nouveau compteur'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Back on the welcome screen, the freshly created counter is listed.
    expect(find.text('Nouveau compteur'), findsOneWidget);
    expect(find.text('Compteur sans nom'), findsOneWidget);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Nouveau compteur'));
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

  testWidgets('Deleting a counter asks for confirmation then returns home',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Nouveau compteur'));
    await tester.pumpAndSettle();

    // Open the delete confirmation dialog.
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Supprimer ce compteur ?'), findsOneWidget);

    // Confirm the deletion.
    await tester.tap(find.text('Supprimer'));
    await tester.pumpAndSettle();

    // Back on the welcome screen, no counter remains.
    expect(find.text('Nouveau compteur'), findsOneWidget);
    expect(find.textContaining('Aucun compteur'), findsOneWidget);
  });
}
