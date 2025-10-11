import 'package:flutter/material.dart';

import '../widgets/profile_screen_widgets/document_section.dart';
import '../widgets/profile_screen_widgets/profile_info_section.dart';
import '../widgets/profile_screen_widgets/account_settings_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    'Personal Information',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(height: 10),
                ProfileInfoSection(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    'Documents',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(height: 10),
                DocumentSection(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    'Account Settings',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                AccountSettingsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//       ),
//       child: const Icon(
//         Icons.settings,
//         size: 64,
//       ),
//     ),
//     const SizedBox(height: 24),
//     Text(
//       'Profile Screen',
//       style: Theme.of(context).textTheme.displayMedium,
//     ),
//     const SizedBox(height: 8),
//     Text(
//       'Content coming soon',
//       style: Theme.of(context).textTheme.bodyMedium,
//     ),
//   ],
// ),
