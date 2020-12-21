import 'package:askit/main.dart';
import 'package:askit/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Button leads to Log In', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: HomePageWidget(),
    ));

    // Check we are on main page.
    expect(find.text("ASKIT"), findsNWidgets(2));
    expect(find.text("Log In"), findsOneWidget);

    // Tap the Log In button.
    await tester.tap(find.ancestor(
        of: find.text('Log In'), matching: find.byType(ElevatedButton)));
    await tester.pumpAndSettle();

    // Check we are on the log in page.
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
