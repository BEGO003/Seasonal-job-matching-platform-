import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/jobs_screen_providers/paginated_jobs_provider.dart';

/// Footer widget for the jobs list showing loading indicators,
/// "Load More" button, or end-of-list message
class JobsPaginationFooter extends ConsumerWidget {
  final PaginatedJobsState state;

  const JobsPaginationFooter({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Show loading indicator when fetching more
    if (state.isLoadingMore) {
      return _buildLoadingIndicator(theme);
    }

    // Show "End of results" when no more pages
    if (!state.hasMore && state.jobs.isNotEmpty) {
      return _buildEndOfList(theme, state.totalElements);
    }

    // Show "Load More" button after 200 results (4 pages)
    if (state.hasReachedAutoLoadThreshold && state.hasMore) {
      final remaining = state.totalElements - state.jobs.length;
      return _buildLoadMoreButton(context, ref, theme, remaining);
    }

    // Default: empty space (auto-loading will trigger)
    return const SizedBox(height: 16);
  }

  Widget _buildLoadingIndicator(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Loading more jobs...',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndOfList(ThemeData theme, int totalElements) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline_rounded,
              size: 28,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'You\'ve seen all $totalElements jobs',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Check back later for new opportunities',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    int remainingCount,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          // Divider with "or" text
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Scroll complete',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Load more button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                HapticFeedback.lightImpact();
                ref.read(paginatedJobsProvider.notifier).loadMore();
              },
              icon: const Icon(Icons.add_rounded, size: 20),
              label: Text('Load More Jobs ($remainingCount remaining)'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(
                  color: theme.colorScheme.primary.withOpacity(0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),
          Text(
            '${state.jobs.length} of ${state.totalElements} jobs loaded',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
