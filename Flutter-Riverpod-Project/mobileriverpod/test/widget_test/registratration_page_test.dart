import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/presentation/view/auth/user_registration_page.dart';

void main() {
  testWidgets('RegistrationPage UI test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: RegistrationPage()));

    // Verify if the widgets are present
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('First Name'), findsOneWidget);
    expect(find.text('Last Name'), findsOneWidget);
  });
}
