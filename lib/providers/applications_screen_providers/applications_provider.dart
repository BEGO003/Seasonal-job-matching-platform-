import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/models/applications_screen_models/application_model.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/applications_screen_services/applications_service.dart';

// Fixed: Return List<ApplicationModel> instead of List<ApplicationsService>
final applicationsProvider = AsyncNotifierProvider<ApplicationsNotifier, List<ApplicationModel>>(
  ApplicationsNotifier.new,
);

class ApplicationsNotifier extends AsyncNotifier<List<ApplicationModel>> {
  late final ApplicationsService _service = ref.read(applicationsServiceProvider);

  @override
  Future<List<ApplicationModel>> build() async {
    // React to user changes; rebuild when personal info updates
    final user = await ref.watch(personalInformationProvider.future);
    return _service.getApplicationsForUser(user.id);
  }

  // Optional: Add refresh method
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final user = await ref.read(personalInformationProvider.future);
      final applications = await _service.getApplicationsForUser(user.id);
      state = AsyncValue.data(applications);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final applicationsServiceProvider = Provider<ApplicationsService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApplicationsService(dio);
});