import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/jobs_screen_providers/jobs_filter_provider.dart';

class JobsSearchHeader extends ConsumerWidget {
  const JobsSearchHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final filterState = ref.watch(jobsFilterProvider);

    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withOpacity(0.5),
              ),
            ),
            child: TextField(
              onChanged: (value) {
                ref.read(jobsFilterProvider.notifier).setSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'Search jobs, companies...',
                hintStyle: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: 'Full-time',
                  isSelected: filterState.selectedType == 'Full-time',
                  onTap: () {
                    ref.read(jobsFilterProvider.notifier).setType('Full-time');
                  },
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Part-time',
                  isSelected: filterState.selectedType == 'Part-time',
                  onTap: () {
                    ref.read(jobsFilterProvider.notifier).setType('Part-time');
                  },
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Remote',
                  isSelected: filterState.selectedType == 'Remote',
                  onTap: () {
                    ref.read(jobsFilterProvider.notifier).setType('Remote');
                  },
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Contract',
                  isSelected: filterState.selectedType == 'Contract',
                  onTap: () {
                    ref.read(jobsFilterProvider.notifier).setType('Contract');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
