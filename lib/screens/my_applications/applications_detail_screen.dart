import 'package:flutter/material.dart';
import 'package:job_seeker/models/applications_screen_models/application_model.dart';
import 'package:job_seeker/widgets/common/app_card.dart';

class ApplicationDetailScreen extends StatelessWidget {
  final ApplicationModel item;
  const ApplicationDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final job = item.job;
    debugPrint('item.describeYourself: ${item.describeYourself}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
        backgroundColor: Colors.white.withOpacity(0.4),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Application Information Card
            AppCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title, 
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                  ),
                  if (job.company != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      job.company!, 
                      style: const TextStyle(fontSize: 18, color: Colors.blue)
                    ),
                  ],
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

                  // Application Status
                  const Text(
                    'Application Status:', 
                    style: TextStyle(fontWeight: FontWeight.w600)
                  ),
                  Text(
                    item.applicationStatus, 
                    style: const TextStyle(fontSize: 16)
                  ),
                  const SizedBox(height: 12),
                  
                  // Applied Date
                  if (item.createdAt != null) ...[
                    const Text(
                      'Applied on:', 
                      style: TextStyle(fontWeight: FontWeight.w600)
                    ),
                    Text(item.createdAt!, style: const TextStyle(fontSize: 15)),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Describe Yourself Section
            
            if (item.describeYourself != null && item.describeYourself!.isNotEmpty)
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline, 
                          color: Colors.blue[700],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Your Application Message',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1),
                    const SizedBox(height: 16),
                    Text(
                      item.describeYourself!,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // Job Details Card
            AppCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Job Details', 
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 8),
                  Text(job.description),
                  const SizedBox(height: 12),
                  
                  if (job.requirements != null && job.requirements!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          'Requirements:', 
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 6),
                        ...job.requirements!.map((r) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text('• $r'),
                        )).toList(),
                        const SizedBox(height: 8),
                      ],
                    ),
                  
                  if (job.benefits != null && job.benefits!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          'Benefits:', 
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 6),
                        ...job.benefits!.map((b) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text('• $b'),
                        )).toList(),
                        const SizedBox(height: 8),
                      ],
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}