import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/screens/auth/login_screen.dart';
import 'package:job_seeker/screens/auth/signup_screen.dart';

void main() {
  group('Auth Screens Tests', () {
    testWidgets('LoginScreen renders email and password fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Allow animations to settle
      await tester.pumpAndSettle();

      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2)); // Email & Password
      // The button text is "Sign In" not "Login"
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('SignupScreen renders all required fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SignupScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // "Create Account" appears in the Title AND the Button
      expect(find.text('Create Account'), findsWidgets);
      
      // Name, Country (Dropdown), Phone, Email, Password, Confirm Password
      expect(find.byType(TextFormField), findsAtLeastNWidgets(4));
    });
  });
}
