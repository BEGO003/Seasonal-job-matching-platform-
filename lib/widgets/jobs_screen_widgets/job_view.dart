import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_apply_provider.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_controller.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/widgets/common/app_card.dart';

class JobView extends ConsumerWidget {
  final JobModel job;

  const JobView({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpen = job.status.toUpperCase() == "OPEN" || job.status.toLowerCase() == "active";
    final appliedValue = ref.watch(jobAppliedProvider(job.id));
    final applyCtrl = ref.watch(applyControllerProvider);
    final theme = Theme.of(context);

    final personal = ref.watch(personalInformationProvider);
    final isFav = personal.maybeWhen(
      data: (u) => u.favoriteJobs.contains(int.tryParse(job.id) ?? -1),
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Job Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: theme.colorScheme.surfaceTint,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoritesControllerProvider.notifier).toggle(job.id);
            },
            icon: Icon(
              isFav ? Icons.bookmark : Icons.bookmark_outline,
              color: isFav ? Colors.red.shade400 : theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                // Header Section
                AppCard(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  borderRadius: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isOpen ? Colors.green.shade50 : Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isOpen ? Colors.green.shade200 : Colors.orange.shade200,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isOpen ? Icons.check_circle : Icons.schedule,
                              size: 16,
                              color: isOpen ? Colors.green.shade700 : Colors.orange.shade700,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              job.status,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isOpen ? Colors.green.shade700 : Colors.orange.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Job Title
                      Text(
                        job.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Company and Location
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: [
                          if (job.company != null && job.company!.isNotEmpty)
                            _DetailItem(
                              icon: Icons.business_outlined,
                              text: job.company!,
                            ),
                          _DetailItem(
                            icon: Icons.location_on_outlined,
                            text: job.location,
                          ),
                          if (job.type != null && job.type!.isNotEmpty)
                            _DetailItem(
                              icon: Icons.work_outline,
                              text: job.type!,
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Salary Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              theme.colorScheme.primary.withOpacity(0.9),
                              theme.colorScheme.primary.withOpacity(0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Monthly Salary",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "\$${job.salary.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.monetization_on_rounded,
                              color: Colors.white.withOpacity(0.9),
                              size: 36,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Job Information Section
                AppCard(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job Information",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _InfoGridItem(
                        icon: Icons.person_outline,
                        label: "Posted by",
                        value: job.jobposterName ?? 'Not specified',
                      ),
                      const SizedBox(height: 16),
                      _InfoGridItem(
                        icon: Icons.calendar_today_outlined,
                        label: "Duration",
                        value: "${job.startDate} → ${job.endDate}",
                      ),
                      if (job.workArrangement != null) ...[
                        const SizedBox(height: 16),
                        _InfoGridItem(
                          icon: Icons.work_outline,
                          label: "Work Arrangement",
                          value: job.workArrangement!,
                        ),
                      ],
                      const SizedBox(height: 16),
                      _InfoGridItem(
                        icon: Icons.people_outline,
                        label: "Positions Available",
                        value: "${job.numOfPositions}",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Description Section
                AppCard(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job Description",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        job.description,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                          color: theme.colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                // Requirements & Benefits
                if (job.requirements != null && job.requirements!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  AppCard(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Requirements",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...job.requirements!.map((requirement) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  requirement,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ],
                    ),
                  ),
                ],

                if (job.benefits != null && job.benefits!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  AppCard(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Benefits",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...job.benefits!.map((benefit) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber.shade600,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  benefit,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 24),
              ],
            ),
          ),

          // Apply Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: theme.dividerColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: (isOpen && appliedValue.value != true && !applyCtrl.isLoading)
                        ? () async {
                            await _showApplyDialog(context, ref, job.id);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      disabledBackgroundColor: theme.colorScheme.onSurface.withOpacity(0.12),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: theme.colorScheme.primary.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: applyCtrl.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                appliedValue.value == true ? "Applied" : "Apply Now",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widgets for JobView
class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _InfoGridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoGridItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Keep your existing _showApplyDialog method...
// [Previous _showApplyDialog implementation remains the same]
Future<void> _showApplyDialog(
  BuildContext context,
  WidgetRef ref,
  String jobId,
) async {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? errorText;
  await showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Apply for this job'),
            content: Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Describe yourself',
                  hintText: 'Tell the employer why you are a great fit...',
                  errorText: errorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignLabelWithHint: true,
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Description cannot be empty';
                  }
                  return null;
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () async {
                  if (!(formKey.currentState?.validate() ?? false)) {
                    setState(() => errorText = 'Description cannot be empty.');
                    return;
                  }
                  try {
                    await ref
                        .read(applyControllerProvider.notifier)
                        .apply(
                          jobId: jobId,
                          description: controller.text.trim(),
                        );
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Application submitted successfully.'),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to apply: $e')),
                      );
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      );
    },
  );
}
