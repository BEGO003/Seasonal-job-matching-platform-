import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/home_screen_providers/recommended_jobs_provider.dart';
import 'package:job_seeker/widgets/common/shimmer_loading.dart';
import 'package:job_seeker/widgets/home_screen_widgets/recommended_jobs_carousel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendedValue = ref.watch(recommendedJobsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.mediumImpact();
        ref.invalidate(recommendedJobsProvider);
        await ref.read(recommendedJobsProvider.future);
      },
      color: const Color(0xFF1C1C1E),
      backgroundColor: Colors.white,
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // 1. Recommended Section Header
            const SliverToBoxAdapter(
              child: _SectionHeader(title: "Recommended For You"),
            ),

            // 2. Recommended Carousel
            recommendedValue.when(
              data: (response) {
                if (response.count == 0) {
                  return SliverToBoxAdapter(child: _EmptyState());
                }
                return SliverToBoxAdapter(
                  child: RecommendedJobsCarousel(jobs: response.jobs),
                );
              },
              loading: () =>
                  SliverToBoxAdapter(child: _RecommendedJobsSkeletonLoader()),
              error: (e, st) => SliverToBoxAdapter(
                child: _ErrorState(
                  message: "Failed to load recommendations",
                  onRetry: () {
                    HapticFeedback.selectionClick();
                    ref.invalidate(recommendedJobsProvider);
                  },
                ),
              ),
            ),

            const SliverPadding(padding: EdgeInsets.only(bottom: 32)),

            // 3. Saved Jobs Header
            const SliverToBoxAdapter(
              child: _SectionHeader(title: "Saved Jobs"),
            ),

            // 4. Saved Jobs Placeholder
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: _ComingSoonCard(
                  icon: Icons.bookmark_rounded,
                  title: "Saved Jobs",
                  subtitle: "Save jobs to view them here later.",
                ),
              ),
            ),

            const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
          ],
        ),
      ),
    );
  }
}

class _ComingSoonCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ComingSoonCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, size: 32, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 16),
          Text(
            "Coming Soon",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1C1C1E),
              letterSpacing: -0.5,
            ),
          ),
          // Removed "See All" since it had no function and looked lonely without functionality
        ],
      ),
    );
  }
}

class _RecommendedJobsSkeletonLoader extends StatelessWidget {
  const _RecommendedJobsSkeletonLoader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ShimmerLoading(
        width: double.infinity,
        height: 260,
        borderRadius: 24,
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 32,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "No Recommendations Yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Complete your profile or update your interests to get better matches.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          // We could add a button here if we had direct navigation access
          // For now, just the message is better than "No jobs found"
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(message),
          TextButton(onPressed: onRetry, child: const Text("Retry")),
        ],
      ),
    );
  }
}
