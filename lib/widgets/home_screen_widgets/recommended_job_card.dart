import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_controller.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_view/job_view.dart';
import 'package:job_seeker/utils/job_color_util.dart';

class RecommendedJobCard extends ConsumerWidget {
  final JobModel job;

  const RecommendedJobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dynamic Bold Color
    final Color cardColor = JobColorUtil.getJobColor(job.id, job.title);

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => JobView(job: job)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        // Premium Dark Card Styling
        decoration: BoxDecoration(
          color: cardColor, // Solid Bold Color
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: cardColor.withValues(alpha: 0.4), // Matching Glow
              blurRadius: 20,
              offset: const Offset(0, 10),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative background pattern (subtle circles)
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Logo + Favorite
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CompanyLogo(
                        name: job.jobposterName,
                        textColor: cardColor,
                      ),
                      _FavoriteButton(jobId: job.id),
                    ],
                  ),

                  const Spacer(),

                  // Job Info (White Text)
                  Text(
                    job.jobposterName,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                      letterSpacing: -0.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 20),

                  // Tags - Vertical Stack (White Translucent)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _WhiteTag(
                        text: job.type,
                        icon: Icons.access_time_filled_rounded,
                      ),
                      const SizedBox(height: 8),
                      _WhiteTag(
                        text: job.location,
                        icon: Icons.location_on_rounded,
                      ),
                      if (job.categories.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: job.categories
                              .take(3)
                              .map(
                                (cat) => _WhiteTag(
                                  text: cat,
                                  icon: Icons.category_rounded,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ],
                  ),

                  const Spacer(),

                  // Bottom Row: Salary + Action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Salary',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '\$${NumberFormat('#,##0').format(job.amount)}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // White Action Button
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_outward_rounded,
                          color: cardColor, // Icon matches card
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  final String name;
  final Color textColor;

  const _CompanyLogo({required this.name, required this.textColor});

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textColor, // Matches card background
          ),
        ),
      ),
    );
  }
}

class _WhiteTag extends StatelessWidget {
  final String text;
  final IconData icon;

  const _WhiteTag({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends ConsumerWidget {
  final int jobId;

  const _FavoriteButton({required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalInfo = ref.watch(personalInformationProvider);
    final isFav = personalInfo.maybeWhen(
      data: (u) => u.favoriteJobs.contains(jobId),
      orElse: () => false,
    );

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        ref.read(favoritesControllerProvider.notifier).toggle(jobId.toString());
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          isFav ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
