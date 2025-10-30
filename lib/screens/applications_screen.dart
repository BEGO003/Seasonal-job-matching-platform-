import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/applications_screen_providers/applications_provider.dart';
import 'package:job_seeker/services/applications_screen_services/applications_service.dart';
import 'package:job_seeker/widgets/common/async_value_view.dart';
import 'package:job_seeker/screens/applications_detail_screen.dart';
import 'package:job_seeker/widgets/common/glass_container.dart';

class ApplicationsScreen extends ConsumerWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationsValue = ref.watch(applicationsProvider);
    return AsyncValueView<List<ApplicationWithJob>>(
      value: applicationsValue,
      data: (apps) {
        if (apps.isEmpty) {
          return const Center(child: Text('No applications yet.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: apps.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) => ApplicationCardWidget(
            item: apps[i],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ApplicationDetailScreen(item: apps[i]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ApplicationCardWidget extends StatelessWidget {
  final ApplicationWithJob item;
  final VoidCallback onTap;
  const ApplicationCardWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final job = item.job;
    final app = item.application;
    return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: GlassContainer(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (job.companyLogo != null && job.companyLogo!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.network(
                        job.companyLogo!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const SizedBox(
                          width: 48,
                          height: 48,
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (job.company != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            job.company!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                        Text(
                          '${job.location} • ${job.type ?? ''}'.trim(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'Applied: ${app.appliedDate ?? "-"}',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      child: Text(
                        'Application Status: ${app.applicationStatus}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (job.status.isNotEmpty)
                    Chip(
                      label: Text('Job: ${job.status}'),
                      backgroundColor: Colors.grey[200],
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    
  }
}
