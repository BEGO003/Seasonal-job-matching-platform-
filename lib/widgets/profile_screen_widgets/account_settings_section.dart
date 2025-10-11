import 'package:flutter/material.dart';
import 'package:job_seeker/widgets/profile_screen_widgets/account_settings_card.dart';
class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const SettingsOptionCard(
          icon: Icons.lock_outline,
          title: 'Change Password',
          subtitle: 'Update your password to keep your account secure',
          // iconColor: AppColors.info,
        ),
        const SizedBox(height: 7),
        const SettingsOptionCard(
          icon: Icons.delete_outline,
          title: 'Delete Account',
          subtitle: 'Permanently delete your account and all data',
          // iconColor: AppColors.error,
          isDanger: true,
        ),
      ],
    );
  }
}

