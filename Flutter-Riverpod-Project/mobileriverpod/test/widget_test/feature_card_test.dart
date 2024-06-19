import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mobileriverpod/presentation/widget/theme_notifier.dart';
import 'package:mobileriverpod/presentation/widget/themes.dart';
import 'package:mobileriverpod/presentation/widget/feature_card.dart';

void main() {
  group('FeatureCard Widget Tests', () {
    testWidgets(
        'FeatureCard displays correct content and responds to tap in light theme',
        (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDark: false),
          child: MaterialApp(
            home: Scaffold(
              body: FeatureCard(
                iconData: Icons.star,
                title: 'Feature',
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Feature'), findsOneWidget);

      final card = tester.widget<Card>(find.byType(Card));
      expect((card.color as Color), equals(Colors.purple[50]));

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets(
        'FeatureCard displays correct content and responds to tap in dark theme',
        (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDark: true),
          child: MaterialApp(
            home: Scaffold(
              body: FeatureCard(
                iconData: Icons.star,
                title: 'Feature',
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Feature'), findsOneWidget);

      final card = tester.widget<Card>(find.byType(Card));
      expect((card.color as Color), equals(Colors.grey[800]));

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });
    testWidgets(
        'FeatureCard displays correct content and responds to tap with different icon',
        (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDark: false),
          child: MaterialApp(
            home: Scaffold(
              body: FeatureCard(
                iconData: Icons.favorite,
                title: 'New Feature',
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.text('New Feature'), findsOneWidget);

      final card = tester.widget<Card>(find.byType(Card));
      expect((card.color as Color), equals(Colors.purple[50]));

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });
    testWidgets('FeatureCard without onTap callback does not respond to tap',
        (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDark: false),
          child: MaterialApp(
            home: Scaffold(
              body: FeatureCard(
                iconData: Icons.star,
                title: 'Feature',
                // No onTap callback provided
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Feature'), findsOneWidget);

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(tapped, isFalse);
      final card = tester.widget<Card>(find.byType(Card));
      expect((card.color as Color), equals(Colors.purple[50]));
    });

    testWidgets(
        'FeatureCard displays default content and does not respond to tap initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDark: false),
          child: MaterialApp(
            home: Scaffold(
              body: FeatureCard(
                iconData: Icons.star,
                title: 'Feature',
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Feature'), findsOneWidget);

      final card = tester.widget<Card>(find.byType(Card));
      expect((card.color as Color), equals(Colors.purple[50]));
    });
  });
}
