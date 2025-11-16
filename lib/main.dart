import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/screens/layout_screen.dart';
import 'package:job_seeker/theme/app_theme.dart';
import 'package:job_seeker/providers/auth/auth_providers.dart';
import 'package:job_seeker/screens/auth/onboarding_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final home = auth.isAuthenticated ? const LayoutScreen() : const OnboardingScreen();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: home,
    );
  }
}
