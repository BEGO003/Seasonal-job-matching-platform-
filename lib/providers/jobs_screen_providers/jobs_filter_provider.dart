import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_notifier.dart';

// State class for filters
class JobsFilterState {
  final String searchQuery;
  final String? selectedType; // e.g., "Full-time", "Part-time"
  final String?
  selectedLocation; // For now just a string, could be more complex
  final double? minSalary;

  const JobsFilterState({
    this.searchQuery = '',
    this.selectedType,
    this.selectedLocation,
    this.minSalary,
  });

  JobsFilterState copyWith({
    String? searchQuery,
    String? selectedType,
    String? selectedLocation,
    double? minSalary,
  }) {
    return JobsFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedType: selectedType, // Allow nulling
      selectedLocation: selectedLocation, // Allow nulling
      minSalary: minSalary, // Allow nulling
    );
  }
}

// Notifier to manage filter state
class JobsFilterNotifier extends Notifier<JobsFilterState> {
  @override
  JobsFilterState build() {
    return const JobsFilterState();
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setType(String? type) {
    // Toggle if same type is selected
    if (state.selectedType == type) {
      state = JobsFilterState(
        searchQuery: state.searchQuery,
        selectedType: null,
        selectedLocation: state.selectedLocation,
        minSalary: state.minSalary,
      );
    } else {
      state = state.copyWith(selectedType: type);
    }
  }
}

final jobsFilterProvider =
    NotifierProvider<JobsFilterNotifier, JobsFilterState>(
      JobsFilterNotifier.new,
    );

// Computed provider that returns filtered jobs
final filteredJobsProvider = Provider<AsyncValue<List<JobModel>>>((ref) {
  final jobsAsync = ref.watch(jobsNotifierProvider);
  final filterState = ref.watch(jobsFilterProvider);

  return jobsAsync.whenData((jobs) {
    return jobs.where((job) {
      // Filter by search query (title or company)
      if (filterState.searchQuery.isNotEmpty) {
        final query = filterState.searchQuery.toLowerCase();
        final titleMatch = job.title.toLowerCase().contains(query);
        final companyMatch = job.jobposterName.toLowerCase().contains(query);
        if (!titleMatch && !companyMatch) return false;
      }

      // Filter by Type
      if (filterState.selectedType != null) {
        if (job.type.toLowerCase() != filterState.selectedType!.toLowerCase()) {
          return false;
        }
      }

      return true;
    }).toList();
  });
});
