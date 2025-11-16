import 'package:flutter/material.dart';
import 'package:job_seeker/screens/Profile/cover_letter_screen.dart';
import 'package:job_seeker/screens/Profile/resume_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/auth/auth_providers.dart';

import '../../widgets/profile_screen_widgets/profile_info_section.dart';
import '../../widgets/profile_screen_widgets/account_settings_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    // debugPrint(_isExpanded.toString() );
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _onResumePressed() {
    // Add your resume upload/view logic here
    setState(() {
      _isExpanded = false;
      _animationController.reverse();
    });
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const ResumeScreen()));
  }

  void _onCoverLetterPressed() {
    // Add your cover letter upload/view logic here
    setState(() {
      _isExpanded = false;
      _animationController.reverse();
    });
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const CoverLetterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                        'Account Settings',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    AccountSettingsSection(),
                    const SizedBox(height: 16),
                    Consumer(
                      builder: (context, ref, _) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              await ref.read(authControllerProvider.notifier).logout();
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Logged out')),
                              );
                              // Return to root; main will show onboarding due to auth gate
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text('Logout'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 80), // Extra space for FAB
                  ],
                ),
              ),
            ),),
        // Barrier to close FAB when tapping outside
        if (_isExpanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleExpanded,
              child: Container(color: Colors.black26),
            ),
          ),
        // Floating Action Buttons
        Positioned(
          right: 16,
          bottom: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Resume Button
              ScaleTransition(
                scale: _animation,
                child: FadeTransition(
                  opacity: _animation,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: .1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            'Resume',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        FloatingActionButton(
                          heroTag: 'resume',
                          onPressed: _onResumePressed,
                          mini: true,
                          child: const Icon(Icons.description),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Cover Letter Button
              ScaleTransition(
                scale: _animation,
                child: FadeTransition(
                  opacity: _animation,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: .1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            'Cover Letter',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        FloatingActionButton(
                          heroTag: 'coverLetter',
                          onPressed: _onCoverLetterPressed,
                          mini: true,
                          child: const Icon(Icons.article),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Main FAB
              FloatingActionButton(
                heroTag: 'main',
                onPressed: _toggleExpanded,
                child: Icon(_isExpanded ? Icons.close : Icons.article),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
