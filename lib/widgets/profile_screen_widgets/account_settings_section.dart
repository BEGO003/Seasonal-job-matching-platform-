import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/widgets/profile_screen_widgets/account_settings_card.dart';
import 'package:job_seeker/providers/auth_provider.dart';
import 'package:job_seeker/screens/auth/login_screen.dart';
class AccountSettingsSection extends ConsumerWidget {
  const AccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const SettingsOptionCard(
          icon: Icons.lock_outline,
          title: 'Change Password',
          subtitle: 'Update your password to keep your account secure',
        ),
        const SizedBox(height: 7),
        const SettingsOptionCard(
          icon: Icons.delete_outline,
          title: 'Delete Account',
          subtitle: 'Permanently delete your account and all data',
          isDanger: true,
        ),
        const SizedBox(height: 7),
        SettingsOptionCard(
          icon: Icons.logout_outlined,
          title: 'Logout',
          subtitle: 'Sign out of this account',
          isDanger: false,
          onTap: () async {
            final shouldLogout = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Confirm logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );

            if (shouldLogout == true) {
              // Call provider logout
              await ref.read(authProvider.notifier).logout();

              // Navigate to login screen and remove all previous routes
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            }
          },
        ),
      ],
    );
  }
}

