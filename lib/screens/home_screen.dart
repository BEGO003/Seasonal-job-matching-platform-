import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_provider.dart';
import 'package:job_seeker/widgets/common/async_value_view.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesValue = ref.watch(favoriteJobsProvider);
    return AsyncValueView<List<JobModel>>(
      value: favoritesValue,
      data: (jobs) {
        if (jobs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                const SizedBox(height: 12),
                const Text('No favorite jobs yet'),
                const SizedBox(height: 6),
                Text(
                  'Mark jobs as favorite to see them here',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            // Rebuild by invalidating provider
            ref.invalidate(favoriteJobsProvider);
            await ref.read(favoriteJobsProvider.future);
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: jobs.length,
            itemBuilder: (context, index) => JobCard(job: jobs[index]),
          ),
        );
      },
    );
  }
}