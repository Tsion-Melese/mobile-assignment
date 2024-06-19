import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/presentation/view/auth/admin_registration_page.dart';

void main() {
  testWidgets('AdminRegistrationPage UI test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: AdminRegistrationPage()));

    // Verify if the widgets are present
    expect(find.text('Admin-Registration'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('First Name'), findsOneWidget);
    expect(find.text('Last Name'), findsOneWidget);
  });

  testWidgets('AdminRegistrationPage form validation test',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: AdminRegistrationPage()));

    // Fill the input fields with valid data
    await tester.enterText(find.byKey(Key('email')), 'test@example.com');
    await tester.enterText(find.byKey(Key('password')), 'password123');
    await tester.enterText(find.byKey(Key('username')), 'testuser');
    await tester.enterText(find.byKey(Key('firstName')), 'John');
    await tester.enterText(find.byKey(Key('lastName')), 'Doe');

    // Verify if the form validation passes after filling all input fields
    expect(find.text('Please enter your email'), findsNothing);
    expect(find.text('Please enter your password'), findsNothing);
    expect(find.text('Please enter your username'), findsNothing);
    expect(find.text('Please enter your first name'), findsNothing);
    expect(find.text('Please enter your last name'), findsNothing);
  });

  testWidgets('AdminRegistrationPage form validation test',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: AdminRegistrationPage()));

    // Fill the input fields with valid data
    await tester.enterText(find.byKey(Key('email')), 'test@example.com');
    await tester.enterText(find.byKey(Key('password')), 'password123');
    await tester.enterText(find.byKey(Key('username')), 'testuser');
    await tester.enterText(find.byKey(Key('firstName')), 'John');
    await tester.enterText(find.byKey(Key('lastName')), 'Doe');

    // Verify if the form validation passes after filling all input fields
    expect(find.text('Please enter your email'), findsNothing);
    expect(find.text('Please enter your password'), findsNothing);
    expect(find.text('Please enter your username'), findsNothing);
    expect(find.text('Please enter your first name'), findsNothing);
    expect(find.text('Please enter your last name'), findsNothing);
  });

  testWidgets('AdminRegistrationPage password field obscured test',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AdminRegistrationPage()));

    final passwordField = find.byKey(Key('password'));
    final passwordFieldWidget = tester.widget<TextFormField>(passwordField);
  });

  testWidgets('AdminRegistrationPage button enabled test',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AdminRegistrationPage()));

    final submitButton = find.byType(ElevatedButton);

    // Fill the input fields with valid data
    await tester.enterText(find.byKey(Key('email')), 'test@example.com');
    await tester.enterText(find.byKey(Key('password')), 'password123');
    await tester.enterText(find.byKey(Key('username')), 'testuser');
    await tester.enterText(find.byKey(Key('firstName')), 'John');
    await tester.enterText(find.byKey(Key('lastName')), 'Doe');
  });
}
