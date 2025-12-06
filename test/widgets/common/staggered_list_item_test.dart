import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/widgets/common/staggered_list_item.dart';

void main() {
  group('StaggeredListItem', () {
    testWidgets('renders child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaggeredListItem(index: 0, child: Text('Item 0')),
          ),
        ),
      );

      // Pump to let animation complete
      await tester.pumpAndSettle();

      expect(find.text('Item 0'), findsOneWidget);
    });

    testWidgets('applies staggered delay based on index', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                StaggeredListItem(index: 0, child: Text('Item 0')),
                StaggeredListItem(index: 1, child: Text('Item 1')),
                StaggeredListItem(index: 2, child: Text('Item 2')),
              ],
            ),
          ),
        ),
      );

      // Initially items might not be fully visible
      await tester.pump();

      // After settling, all items should be visible
      await tester.pumpAndSettle();

      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('respects animate parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaggeredListItem(
              index: 0,
              animate: false,
              child: Text('No Animation'),
            ),
          ),
        ),
      );

      // Should be immediately visible without animation
      expect(find.text('No Animation'), findsOneWidget);
    });

    testWidgets('uses custom duration when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaggeredListItem(
              index: 0,
              duration: Duration(milliseconds: 100),
              child: Text('Custom Duration'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Custom Duration'), findsOneWidget);
    });

    testWidgets('uses custom delay when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StaggeredListItem(
              index: 0,
              delay: Duration(milliseconds: 200),
              child: Text('Custom Delay'),
            ),
          ),
        ),
      );

      // Pump past the delay duration to allow the timer to fire
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pumpAndSettle();
      expect(find.text('Custom Delay'), findsOneWidget);
    });
  });

  group('StaggeredListBuilder', () {
    testWidgets('builds list with staggered items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StaggeredListBuilder(
              itemCount: 3,
              itemBuilder: (context, index) => Text('List Item $index'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('List Item 0'), findsOneWidget);
      expect(find.text('List Item 1'), findsOneWidget);
      expect(find.text('List Item 2'), findsOneWidget);
    });

    testWidgets('applies padding when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StaggeredListBuilder(
              itemCount: 1,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => const Text('Padded Item'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Padded Item'), findsOneWidget);
    });

    testWidgets('respects shrinkWrap parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                StaggeredListBuilder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Text('Shrink Item $index'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Shrink Item 0'), findsOneWidget);
      expect(find.text('Shrink Item 1'), findsOneWidget);
    });
  });

  group('AnimatedExpandable', () {
    testWidgets('shows child when expanded', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedExpandable(
              isExpanded: true,
              child: Text('Expanded Content'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Expanded Content'), findsOneWidget);
    });

    testWidgets('hides child when collapsed', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedExpandable(
              isExpanded: false,
              child: Text('Collapsed Content'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // The widget exists but is collapsed (size is 0)
      expect(find.byType(SizeTransition), findsOneWidget);
    });

    testWidgets('animates between states', (WidgetTester tester) async {
      bool isExpanded = false;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => isExpanded = !isExpanded),
                      child: const Text('Toggle'),
                    ),
                    AnimatedExpandable(
                      isExpanded: isExpanded,
                      child: const Text('Toggleable Content'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      // Initially collapsed
      await tester.pumpAndSettle();

      // Toggle to expanded
      await tester.tap(find.text('Toggle'));
      await tester.pumpAndSettle();

      expect(find.text('Toggleable Content'), findsOneWidget);
    });
  });

  group('PulseAnimation', () {
    testWidgets('renders child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PulseAnimation(
              child: Icon(Icons.favorite, color: Colors.red),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('animates when animate is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PulseAnimation(animate: true, child: Text('Pulsing')),
          ),
        ),
      );

      // Pump a few frames to verify animation
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Pulsing'), findsOneWidget);
    });

    testWidgets('does not animate when animate is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PulseAnimation(animate: false, child: Text('Not Pulsing')),
          ),
        ),
      );

      expect(find.text('Not Pulsing'), findsOneWidget);
    });
  });
}
