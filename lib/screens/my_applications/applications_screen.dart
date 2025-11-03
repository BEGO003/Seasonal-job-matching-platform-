import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/models/applications_screen_models/application_model.dart';
import 'package:job_seeker/providers/applications_screen_providers/applications_provider.dart';
import 'package:job_seeker/widgets/common/async_value_view.dart';
import 'package:job_seeker/screens/my_applications/applications_detail_screen.dart';
import 'package:job_seeker/widgets/common/app_card.dart';

class ApplicationsScreen extends ConsumerWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationsValue = ref.watch(applicationsProvider);
    return AsyncValueView<List<ApplicationModel>>( // Fixed: ApplicationModel not ApplicationWithJob
      value: applicationsValue,
      data: (applications) { // Fixed: renamed from 'apps' to 'applications'
        if (applications.isEmpty) {
          return const Center(child: Text('No applications yet.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: applications.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) => ApplicationCardWidget(
            application: applications[index], // Fixed: pass ApplicationModel directly
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ApplicationDetailScreen(item: applications[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// ApplicationsScreen - Updated ApplicationCardWidget
class ApplicationCardWidget extends StatelessWidget {
  final ApplicationModel application;
  final VoidCallback onTap;

  const ApplicationCardWidget({
    super.key,
    required this.application,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final job = application.job;
    final theme = Theme.of(context);

    return AppCard(
      onTap: onTap,
      interactive: true,
      padding: const EdgeInsets.all(20),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (job.companyLogo != null && job.companyLogo!.isNotEmpty)
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(job.companyLogo!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (job.company != null && job.company!.isNotEmpty)
                      Text(
                        job.company!,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      '${job.location} • ${job.type ?? ''}'.trim(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _getStatusColor(application.applicationStatus).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _getStatusColor(application.applicationStatus).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    'Status: ${application.applicationStatus}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(application.applicationStatus),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Job: ${job.status}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
      case 'accepted':
        return Colors.green;
      case 'rejected':
      case 'declined':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}

// ApplicationDetailScreen - Keep your existing implementation but it will automatically use the new AppCard styles