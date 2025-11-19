import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/applications_screen_services/applications_service.dart';
import 'package:job_seeker/services/profile_screen_services/personal_information_service.dart';

final applicationsProvider =
    AsyncNotifierProvider<ApplicationsNotifier, List<ApplicationWithJob>>(
      ApplicationsNotifier.new,
    );

class ApplicationsNotifier extends AsyncNotifier<List<ApplicationWithJob>> {
  late final ApplicationsService _service = ref.read(
    applicationsServiceProvider,
  );

  @override
  Future<List<ApplicationWithJob>> build() async {
    // Watch user changes to rebuild when personal info updates
    final user = await ref.watch(personalInformationProvider.future);
    
    // Fetch all applications for this user
    final result = await _service.getApplicationsForUser(user.id.toString());
    
    // Extract job IDs from applications and sync with user's ownedapplications
    final appliedJobIds = <int>{};
    for (final app in result) {
      // Assuming ApplicationWithJob has a jobId field
      // If it's in app.job.id or app.application.jobId, adjust accordingly
      final jobId = app.job.id;
      appliedJobIds.add(jobId);
        }
    
    // Sync user's ownedapplications with actual applied jobs
    // This ensures consistency between what the server says and what we track
    final currentAppliedJobs = Set<int>.from(user.ownedapplications);
    
    if (!_setsEqual(currentAppliedJobs, appliedJobIds)) {
      // Update if there's a mismatch
      ref.read(personalInformationProvider.notifier).state = AsyncValue.data(
        user.copyWith(ownedapplications: appliedJobIds.toList()),
      );
      
      // Persist the sync
      await ref
          .read(personalInformationServiceProvider)
          .updateOwnedApplications(appliedJobIds.toList());
    }
    
    return result;
  }
  
  /// Helper to compare two sets for equality
  bool _setsEqual(Set<int> a, Set<int> b) {
    if (a.length != b.length) return false;
    return a.difference(b).isEmpty;
  }
}