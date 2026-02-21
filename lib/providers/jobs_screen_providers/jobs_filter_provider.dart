import 'package:flutter_riverpod/flutter_riverpod.dart';

// State class for filters
class JobsFilterState {
  final String searchQuery;
  final String? selectedType; // Stores apiValue (e.g. FULL_TIME)
  final String? selectedLocation;
  final String? salaryType; // HOURLY, YEARLY, MONTHLY

  const JobsFilterState({
    this.searchQuery = '',
    this.selectedType,
    this.selectedLocation,
    this.salaryType,
  });

  JobsFilterState copyWith({
    String? searchQuery,
    String? selectedType,
    String? selectedLocation,
    String? salaryType,
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
      salaryType: clearSalary ? null : (salaryType ?? this.salaryType),
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

  void setSalaryType(String? type) {
    if (type == null) {
      state = state.copyWith(clearSalary: true);
    } else {
      state = state.copyWith(salaryType: type);
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
