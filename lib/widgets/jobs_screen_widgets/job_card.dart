import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_view/job_view.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_controller.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/widgets/common/app_card.dart';

class JobCard extends ConsumerStatefulWidget {
  final JobModel job;

  const JobCard({super.key, required this.job});

  @override
  ConsumerState<JobCard> createState() => _JobCardState();
}

class _JobCardState extends ConsumerState<JobCard> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDate(String dateStr) {
    try {
      DateTime date;
      // Try parsing ISO format first (yyyy-mm-dd)
      try {
        date = DateTime.parse(dateStr);
      } catch (_) {
        // Try parsing dd-mm-yyyy format
        final parts = dateStr.split('-');
        if (parts.length == 3) {
          date = DateTime(
            int.parse(parts[2]), // year
            int.parse(parts[1]), // month
            int.parse(parts[0]), // day
          );
        } else {
          return dateStr;
        }
      }
      return DateFormat('MMMM, dd yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  Color _getStatusColor() {
    final status = widget.job.status.toLowerCase();
    if (status == 'open') return const Color(0xFF10B981);
    if (status == 'closed') return const Color(0xFFEF4444);
    return const Color(0xFFF59E0B);
  }

  @override
  Widget build(BuildContext context) {
    final formattedStart = _formatDate(widget.job.startDate);
    final formattedEnd = _formatDate(widget.job.endDate);
    final isOpen = widget.job.status.toLowerCase() == 'open';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  JobView(job: widget.job),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOutCubic;
                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve),
                );
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 350),
            ),
          );
        },
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AppCard(
            padding: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
                ),
                border: Border.all(
                  color: Colors.grey.shade100,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Status and Favorite
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Status Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.job.status.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: _getStatusColor(),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Favorite Button
                        _FavoriteButton(jobId: widget.job.id),
                      ],
                    ),
                  ),

                  // Job Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      widget.job.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                        height: 1.3,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Info Grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _InfoChip(
                            icon: Icons.location_on_outlined,
                            label: widget.job.location,
                            color: const Color(0xFF3B82F6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _InfoChip(
                            icon: Icons.work_outline,
                            label: widget.job.type,
                            color: const Color(0xFF8B5CF6),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _InfoChip(
                            icon: Icons.calendar_today_outlined,
                            label: '$formattedStart - $formattedEnd',
                            color: const Color(0xFFEC4899),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (widget.job.categories.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.job.categories.map((category) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B5CF6).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF8B5CF6).withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              category,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF8B5CF6),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Salary Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF3B82F6),
                          const Color(0xFF2563EB),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Monthly Salary',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${NumberFormat('#,##0.00').format(widget.job.salary)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.attach_money,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color.withOpacity(0.9),
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
        ref.read(favoritesControllerProvider.notifier).toggle(jobId.toString());
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isFav
              ? const Color(0xFFEF4444).withOpacity(0.1)
              : Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? const Color(0xFFEF4444) : Colors.grey.shade600,
          size: 20,
        ),
      ),
    );
  }
}