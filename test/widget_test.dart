// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:elitetraders/HomePage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomePage shows user info', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const EliteTradersApp());

    // Verify that user information is displayed.
    expect(find.text('Demo User'), findsOneWidget);
    expect(find.text('demo.user@example.com'), findsOneWidget);
    expect(find.text('+92 300 1234567'), findsOneWidget);
  });
}
