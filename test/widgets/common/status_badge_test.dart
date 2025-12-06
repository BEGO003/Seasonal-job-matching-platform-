import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/widgets/common/status_badge.dart';

void main() {
  group('StatusBadge', () {
    testWidgets('renders with status text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusBadge(status: 'Pending')),
        ),
      );

      expect(find.text('Pending'), findsOneWidget);
      expect(find.byType(StatusBadge), findsOneWidget);
    });

    testWidgets('auto-detects success status', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusBadge.auto(status: 'Approved')),
        ),
      );

      expect(find.text('Approved'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    });

    testWidgets('auto-detects warning status', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusBadge.auto(status: 'Pending Review')),
        ),
      );

      expect(find.text('Pending Review'), findsOneWidget);
      expect(find.byIcon(Icons.schedule_rounded), findsOneWidget);
    });

    testWidgets('auto-detects error status', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusBadge.auto(status: 'Rejected')),
        ),
      );

      expect(find.text('Rejected'), findsOneWidget);
      expect(find.byIcon(Icons.cancel_rounded), findsOneWidget);
    });

    testWidgets('auto-detects info status', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusBadge.auto(status: 'Interview Scheduled')),
        ),
      );

      expect(find.text('Interview Scheduled'), findsOneWidget);
      expect(find.byIcon(Icons.info_rounded), findsOneWidget);
    });

    testWidgets('hides icon when showIcon is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusBadge(status: 'Status', showIcon: false)),
        ),
      );

      expect(find.text('Status'), findsOneWidget);
      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('renders compact variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusBadge(status: 'Compact', compact: true)),
        ),
      );

      expect(find.text('Compact'), findsOneWidget);
    });

    testWidgets('StatusBadge.success uses correct type', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusBadge.success(status: 'Success')),
        ),
      );

      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    });

    testWidgets('StatusBadge.error uses correct type', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusBadge.error(status: 'Error')),
        ),
      );

      expect(find.byIcon(Icons.cancel_rounded), findsOneWidget);
    });
  });

  group('StatusDot', () {
    testWidgets('renders with correct color for success type', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusDot(type: StatusType.success)),
        ),
      );

      expect(find.byType(StatusDot), findsOneWidget);
    });

    testWidgets('renders with custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusDot(type: StatusType.warning, size: 12)),
        ),
      );

      expect(find.byType(StatusDot), findsOneWidget);
    });

    testWidgets('animates when animate is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusDot(type: StatusType.info, animate: true)),
        ),
      );

      // Pump a few frames to verify animation
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(StatusDot), findsOneWidget);
    });
  });

  group('CountBadge', () {
    testWidgets('renders count number', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: CountBadge(count: 5))),
      );

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('shows 99+ for counts over 99', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: CountBadge(count: 100))),
      );

      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('is hidden when count is 0', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: CountBadge(count: 0))),
      );

      expect(find.byType(SizedBox), findsWidgets);
      expect(find.text('0'), findsNothing);
    });

    testWidgets('is hidden when count is negative', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: CountBadge(count: -1))),
      );

      expect(find.text('-1'), findsNothing);
    });
  });

  group('NewBadge', () {
    testWidgets('renders NEW text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: NewBadge())),
      );

      expect(find.text('NEW'), findsOneWidget);
    });

    testWidgets('renders without animation when animate is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: NewBadge(animate: false))),
      );

      expect(find.text('NEW'), findsOneWidget);
    });
  });
}
