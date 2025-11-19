import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/applications_screen_providers/applications_provider.dart';
import 'package:job_seeker/services/applications_screen_services/applications_service.dart';
import 'package:job_seeker/widgets/common/async_value_view.dart';
import 'package:job_seeker/screens/applications_detail_screen.dart';
import 'package:job_seeker/widgets/common/app_card.dart';

class ApplicationsScreen extends ConsumerWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationsValue = ref.watch(applicationsProvider);
    
    return Column(
      children: [
        // Modern Header
        // Container(
        //   padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //       colors: [
        //         const Color(0xFF8B5CF6),
        //         const Color(0xFF7C3AED),
        //       ],
        //     ),
        //   ),
        //   child: SafeArea(
        //     bottom: false,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             // Column(
        //             //   crossAxisAlignment: CrossAxisAlignment.start,
        //             //   children: [
        //             //     Text(
        //             //       'Your',
        //             //       style: TextStyle(
        //             //         fontSize: 16,
        //             //         color: Colors.white.withOpacity(0.9),
        //             //         fontWeight: FontWeight.w500,
        //             //       ),
        //             //     ),
        //             //     const SizedBox(height: 4),
        //             //     const Text(
        //             //       'Applications',
        //             //       style: TextStyle(
        //             //         fontSize: 32,
        //             //         color: Colors.white,
        //             //         fontWeight: FontWeight.w700,
        //             //         letterSpacing: -0.5,
        //             //       ),
        //             //     ),
        //             //   ],
        //             // ),
        //             Container(
        //               padding: const EdgeInsets.all(12),
        //               decoration: BoxDecoration(
        //                 color: Colors.white.withOpacity(0.2),
        //                 borderRadius: BorderRadius.circular(12),
        //               ),
        //               child: const Icon(
        //                 Icons.description_outlined,
        //                 color: Colors.white,
        //                 size: 28,
        //               ),
        //             ),
        //           ],
        //         ),
        //         const SizedBox(height: 16),
        //         Text(
        //           'Track your job application progress',
        //           style: TextStyle(
        //             fontSize: 15,
        //             color: Colors.white.withOpacity(0.85),
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        
        // Applications List
        Expanded(
          child: AsyncValueView<List<ApplicationWithJob>>(
            value: applicationsValue,
            data: (apps) {
              if (apps.isEmpty) {
                return _EmptyApplicationsState();
              }
              
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(applicationsProvider);
                },
                color: const Color(0xFF8B5CF6),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.all(16),
                  itemCount: apps.length,
                  itemBuilder: (context, i) {
                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 300 + (i * 50)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ApplicationCardWidget(
                          item: apps[i],
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>
                                    ApplicationDetailScreen(item: apps[i]),
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
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ApplicationCardWidget extends StatefulWidget {
  final ApplicationWithJob item;
  final VoidCallback onTap;
  
  const ApplicationCardWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  State<ApplicationCardWidget> createState() => _ApplicationCardWidgetState();
}

class _ApplicationCardWidgetState extends State<ApplicationCardWidget>
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

  Color _getStatusColor(String status) {
    final s = status.toLowerCase();
    if (s.contains('pending') || s.contains('submitted')) {
      return const Color(0xFFF59E0B);
    } else if (s.contains('approved') || s.contains('accepted')) {
      return const Color(0xFF10B981);
    } else if (s.contains('rejected') || s.contains('declined')) {
      return const Color(0xFFEF4444);
    } else if (s.contains('interview')) {
      return const Color(0xFF3B82F6);
    }
    return const Color(0xFF6B7280);
  }

  IconData _getStatusIcon(String status) {
    final s = status.toLowerCase();
    if (s.contains('pending') || s.contains('submitted')) {
      return Icons.schedule;
    } else if (s.contains('approved') || s.contains('accepted')) {
      return Icons.check_circle;
    } else if (s.contains('rejected') || s.contains('declined')) {
      return Icons.cancel;
    } else if (s.contains('interview')) {
      return Icons.event;
    }
    return Icons.info;
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.item.job;
    final app = widget.item.application;
    final statusColor = _getStatusColor(app.applicationStatus);
    final isJobOpen = job.status.toLowerCase() == 'open';

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
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
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Status
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.05),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getStatusIcon(app.applicationStatus),
                          color: statusColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Application Status',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              app.applicationStatus,
                              style: TextStyle(
                                fontSize: 15,
                                color: statusColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isJobOpen
                              ? const Color(0xFF10B981).withOpacity(0.1)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: isJobOpen
                                    ? const Color(0xFF10B981)
                                    : Colors.grey.shade600,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              job.status.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: isJobOpen
                                    ? const Color(0xFF10B981)
                                    : Colors.grey.shade600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Job Info
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
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
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            job.location,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.work_outline,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            job.type,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Applied: ${app.createdAt ?? app.appliedDate ?? "N/A"}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Footer
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Tap to view details',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyApplicationsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.description_outlined,
                size: 64,
                color: const Color(0xFF8B5CF6),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Applications Yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You haven\'t applied to any jobs yet.\nStart exploring opportunities!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}