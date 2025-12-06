import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_notifier.dart';

// State class for filters
class JobsFilterState {
  final String searchQuery;
  final String? selectedType;
  final String? selectedLocation;
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
    bool clearType = false,
    bool clearLocation = false,
    bool clearSalary = false,
  }) {
    return JobsFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
      selectedLocation: clearLocation
          ? null
          : (selectedLocation ?? this.selectedLocation),
      minSalary: clearSalary ? null : (minSalary ?? this.minSalary),
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
      state = state.copyWith(clearType: true);
    } else {
      state = state.copyWith(selectedType: type);
    }
  }

  void setLocation(String? location) {
    if (location == null || location.isEmpty) {
      state = state.copyWith(clearLocation: true);
    } else {
      state = state.copyWith(selectedLocation: location);
    }
  }

  void setMinSalary(double? salary) {
    if (salary == null) {
      state = state.copyWith(clearSalary: true);
    } else {
      state = state.copyWith(minSalary: salary);
    }
  }

  void clearFilters() {
    state = const JobsFilterState();
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

      // Filter by Location - Simple contains check
      if (filterState.selectedLocation != null) {
        if (!job.location.toLowerCase().contains(
          filterState.selectedLocation!.toLowerCase(),
        )) {
          return false;
        }
      }

      // Filter by Minimum Salary
      if (filterState.minSalary != null) {
        // Job amount is double/int
        // Assuming job.amount is numeric annual or monthly salary
        // logic depends on data. Assuming job.amount is the value to check
        if (job.amount < filterState.minSalary!) {
          return false;
        }
      }

      return true;
    }).toList();
  });
});
