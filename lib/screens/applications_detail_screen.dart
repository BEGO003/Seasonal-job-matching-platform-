import 'package:flutter/material.dart';
import 'package:job_seeker/services/applications_screen_services/applications_service.dart';
import 'package:job_seeker/widgets/common/app_card.dart';

class ApplicationDetailScreen extends StatelessWidget {
  final ApplicationWithJob item;
  const ApplicationDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final job = item.job;
    final app = item.application;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
        backgroundColor: Colors.white.withValues(alpha: 0.4),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            // if (job.company != null) ...[
            //   const SizedBox(height: 4),
            //   Text(job.company!, style: const TextStyle(fontSize: 18, color: Colors.blue)),
            // ],
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.place_outlined, color: Colors.grey[700]),
                const SizedBox(width: 6),
                Text(job.location),
              ],
            ),
            const SizedBox(height: 8),
            Text("Job Status: ${job.status}"),
            const Divider(height: 32),

            Text('Application Status:', style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(app.applicationStatus, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            if (app.describeYourself != null) ...[
              Text('About You:', style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(app.describeYourself!, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 12),
            ],
            if (app.coverLetter != null) ...[
              Text('Cover Letter:', style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(app.coverLetter!, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 12),
            ],
            Text('Applied on: ${app.appliedDate ?? "-"}', style: const TextStyle(color: Colors.grey)),
            const Divider(height: 32),

            Text('Job Details', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(job.description),
            const SizedBox(height: 12),
            if (job.requirements.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Requirements:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...job.requirements.map((r) => Text('- $r')),
                  const SizedBox(height: 8),
                ],
              ),
            if (job.benefits.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Benefits:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...job.benefits.map((b) => Text('- $b')),
                  const SizedBox(height: 8),
                ],
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      ),
    );
  }
}

