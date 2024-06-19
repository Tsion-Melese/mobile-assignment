import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/presentation/view/auth/login_page.dart';

void main() {
  testWidgets('LoginPage Widget Test', (WidgetTester tester) async {
    // Build our LoginPage widget.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Verify that the back button is present in the AppBar.
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Verify that the email and password fields are present in the form.
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Verify that the "Sign In" button is present.
    expect(find.text('Sign In'), findsOneWidget);

    // Verify that the "Register Now!" button is present.
    expect(find.text('Register Now!'), findsOneWidget);
  });
}
