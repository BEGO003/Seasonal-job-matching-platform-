import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_view.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/widgets/common/app_card.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_controller.dart';

class JobCard extends ConsumerWidget {
  final JobModel job;

  const JobCard({super.key, required this.job});

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('d MMMM, yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedStart = _formatDate(job.startDate);
    final formattedEnd = _formatDate(job.endDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: InkWell(
            borderRadius: BorderRadius.circular(18),
            splashColor: Colors.blue.shade50,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => JobView(
                    job: job,
                  ),
                ),
              );
            },
            child: AppCard(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.title,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              job.company ?? '',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, _) {
                          final personalInfo = ref.watch(personalInformationProvider);
                          final isFav = personalInfo.maybeWhen(
                            data: (u) => u.favoriteJobs.contains(int.tryParse(job.id) ?? -1),
                            orElse: () => false,
                          );
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                ref.read(favoritesControllerProvider.notifier).toggle(job.id);
                              },
                              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                              color: Colors.red.shade400,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  Divider(color: Colors.grey.shade300, height: 1),
                  const SizedBox(height: 14),

                  // Job Info
                  _InfoRow(
                    icon: Icons.location_on,
                    text: job.location,
                    iconColor: Colors.red.shade400,
                  ),
                  const SizedBox(height: 10),
                  _InfoRow(
                    icon: Icons.calendar_today_rounded,
                    text: "$formattedStart - $formattedEnd",
                    iconColor: Colors.blue.shade500,
                  ),
                  const SizedBox(height: 10),
                  _InfoRow(
                    icon: Icons.attach_money,
                    text: "\$${job.salary.toStringAsFixed(0)}",
                    iconColor: Colors.green.shade600,
                  ),
                  const SizedBox(height: 10),
                  _InfoRow(
                    icon: Icons.people,
                    text: "Positions: ${job.numOfPositions}",
                    iconColor: Colors.purple.shade400,
                  ),

                  const SizedBox(height: 16),

                  // Tags
                  if (job.type != '' || job.workArrangement != '')
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (job.type != '') _Tag(label: job.type!),
                        if (job.workArrangement != '')
                          _Tag(label: job.workArrangement!),
                      ],
                    ),
                ],
              ),
            ),
      ),
    );
  }
}

// Info Row Widget
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.5,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// Tag Widget
class _Tag extends StatelessWidget {
  final String label;

  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade200, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.5,
          color: Colors.blue.shade700,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
