import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_notifier.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_card.dart';

class JobCardSection extends ConsumerWidget {
  const JobCardSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(jobsNotifierProvider);
    return jobs.when(
      data: (data) => ListView.builder(
        physics: BouncingScrollPhysics(),
        // shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) => JobCard(job: data[index]),
      ),
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
