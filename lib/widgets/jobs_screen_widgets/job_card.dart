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
      // Handle "15-12-2025" format (day-month-year)
      if (dateStr.contains('-')) {
        final parts = dateStr.split('-');
        if (parts.length == 3) {
          final day = int.tryParse(parts[0]);
          final month = int.tryParse(parts[1]);
          final year = int.tryParse(parts[2]);
          
          if (day != null && month != null && year != null) {
            final date = DateTime(year, month, day);
            return DateFormat('d MMM, yyyy').format(date);
          }
        }
      }
      
      // Fallback to default parsing for other formats
      final date = DateTime.parse(dateStr);
      return DateFormat('d MMM, yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedStart = _formatDate(job.startDate);
    final formattedEnd = _formatDate(job.endDate);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => JobView(job: job),
          ),
        );
      },
      interactive: true,
      padding: const EdgeInsets.all(20),
      borderRadius: 16,
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and favorite button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    if (job.company != null && job.company!.isNotEmpty)
                      Text(
                        job.company!,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Consumer(
                builder: (context, ref, _) {
                  final personalInfo = ref.watch(personalInformationProvider);
                  final isFav = personalInfo.maybeWhen(
                    data: (u) => u.favoriteJobs.contains(int.tryParse(job.id) ?? -1),
                    orElse: () => false,
                  );
                  return Container(
                    decoration: BoxDecoration(
                      color: isFav 
                          ? Colors.red.shade50 
                          : Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        ref.read(favoritesControllerProvider.notifier).toggle(job.id);
                      },
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_outline,
                        size: 20,
                      ),
                      color: isFav ? Colors.red.shade400 : Colors.grey.shade600,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Job details in compact grid
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _InfoChip(
                icon: Icons.location_on_outlined,
                text: job.location,
                color: Colors.blue.shade600,
              ),
              _InfoChip(
                icon: Icons.calendar_today_outlined,
                text: "$formattedStart - $formattedEnd",
                color: Colors.purple.shade600,
              ),
              _InfoChip(
                icon: Icons.attach_money_outlined,
                text: "\$${job.salary.toStringAsFixed(0)}/mo",
                color: Colors.green.shade600,
              ),
              _InfoChip(
                icon: Icons.people_outline,
                text: "${job.numOfPositions} position${job.numOfPositions > 1 ? 's' : ''}",
                color: Colors.orange.shade600,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Tags and status
          if (job.type != null || job.workArrangement != null)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (job.type != null && job.type!.isNotEmpty)
                  _TagChip(label: job.type!),
                if (job.workArrangement != null && job.workArrangement!.isNotEmpty)
                  _TagChip(label: job.workArrangement!),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: job.status.toLowerCase() == 'open' 
                        ? Colors.green.shade50
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    job.status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: job.status.toLowerCase() == 'open'
                          ? Colors.green.shade700
                          : Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// Compact info chip for job details
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// Tag chip for job type and arrangement
class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade100, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.blue.shade700,
        ),
      ),
    );
  }
}