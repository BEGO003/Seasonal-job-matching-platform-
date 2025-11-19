import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_provider.dart';
import 'package:job_seeker/widgets/common/async_value_view.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // User scrolled to the bottom, reload favorites
      ref.invalidate(favoriteJobsProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final favoritesValue = ref.watch(favoriteJobsProvider);
        
        return AsyncValueView<List<JobModel>>(
          value: favoritesValue,
          data: (jobs) {
            if (jobs.isEmpty) {
              return _EmptyFavoritesState();
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(favoriteJobsProvider);
                await ref.read(favoriteJobsProvider.future);
              },
              color: Theme.of(context).colorScheme.primary,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Stats header
                  SliverToBoxAdapter(
                    child: _FavoritesHeader(jobCount: jobs.length),
                  ),
                  // Job cards
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: Duration(milliseconds: 300 + (index * 50)),
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
                              child: JobCard(job: jobs[index]),
                            ),
                          );
                        },
                        childCount: jobs.length,
                      ),
                    ),
                  ),
                  // Loading indicator at bottom
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: ref.watch(favoriteJobsProvider).isLoading
                            ? const SizedBox(
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const SizedBox(height: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _FavoritesHeader extends StatelessWidget {
  final int jobCount;
  
  const _FavoritesHeader({required this.jobCount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer,
            theme.colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.favorite,
              color: theme.colorScheme.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Favorites',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$jobCount ${jobCount == 1 ? 'job' : 'jobs'} saved',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyFavoritesState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated illustration
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primaryContainer,
                      theme.colorScheme.secondaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite_border_rounded,
                  size: 72,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Main message
            Text(
              'No Favorites Yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            
            // Description
            Text(
              'Start building your dream job collection by marking positions you love',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Feature cards
            _FeatureCard(
              icon: Icons.search_rounded,
              title: 'Explore Jobs',
              description: 'Browse thousands of opportunities',
              color: theme.colorScheme.primaryContainer,
            ),
            const SizedBox(height: 12),
            _FeatureCard(
              icon: Icons.favorite_rounded,
              title: 'Save Favorites',
              description: 'Tap the heart icon on any job card',
              color: theme.colorScheme.tertiaryContainer,
            ),
            const SizedBox(height: 12),
            _FeatureCard(
              icon: Icons.notifications_active_rounded,
              title: 'Stay Updated',
              description: 'Get notified about saved positions',
              color: theme.colorScheme.secondaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}