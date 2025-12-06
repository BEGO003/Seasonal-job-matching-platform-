import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/widgets/common/animated_scale_button.dart';

void main() {
  group('AnimatedScaleButton', () {
    testWidgets('renders child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedScaleButton(
              onPressed: () {},
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(AnimatedScaleButton), findsOneWidget);
    });

    testWidgets('triggers onPressed callback when tapped', (
      WidgetTester tester,
    ) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedScaleButton(
              onPressed: () {
                wasPressed = true;
              },
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Test Button'));
      await tester.pumpAndSettle();

      expect(wasPressed, isTrue);
    });

    testWidgets('does not trigger callback when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedScaleButton(
              onPressed: null,
              child: Text('Disabled Button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled Button'));
      await tester.pumpAndSettle();

      // Should not throw and button should exist
      expect(find.text('Disabled Button'), findsOneWidget);
    });

    testWidgets('animates on tap down and tap up', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedScaleButton(
              onPressed: () {},
              child: const SizedBox(
                width: 100,
                height: 50,
                child: Center(child: Text('Animate')),
              ),
            ),
          ),
        ),
      );

      // Trigger tap down
      final gesture = await tester.startGesture(
        tester.getCenter(find.text('Animate')),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Release
      await gesture.up();
      await tester.pumpAndSettle();

      expect(find.byType(AnimatedScaleButton), findsOneWidget);
    });
  });

  group('GradientButton', () {
    testWidgets('renders with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GradientButton(label: 'Click Me', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
      expect(find.byType(GradientButton), findsOneWidget);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GradientButton(
              label: 'Loading',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('renders with icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GradientButton(
              label: 'With Icon',
              icon: Icons.add,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('With Icon'), findsOneWidget);
    });

    testWidgets('is disabled when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GradientButton(label: 'Disabled', onPressed: null),
          ),
        ),
      );

      expect(find.text('Disabled'), findsOneWidget);
    });
  });

  group('AnimatedIconButton', () {
    testWidgets('renders icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedIconButton(icon: Icons.favorite, onPressed: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('shows badge when badgeCount is provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedIconButton(
              icon: Icons.notifications,
              badgeCount: 5,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('shows 99+ when badge count exceeds 99', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedIconButton(
              icon: Icons.notifications,
              badgeCount: 150,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('does not show badge when count is 0', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedIconButton(
              icon: Icons.notifications,
              badgeCount: 0,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('0'), findsNothing);
    });
  });
}
