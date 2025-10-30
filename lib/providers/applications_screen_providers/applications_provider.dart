import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/applications_screen_services/applications_service.dart';

final applicationsProvider = AsyncNotifierProvider<ApplicationsNotifier, List<ApplicationWithJob>>(
  ApplicationsNotifier.new,
);

class ApplicationsNotifier extends AsyncNotifier<List<ApplicationWithJob>> {
  late final ApplicationsService _service = ref.read(applicationsServiceProvider);

  @override
  Future<List<ApplicationWithJob>> build() async {
    // React to user changes; rebuild when personal info updates
    final user = await ref.watch(personalInformationProvider.future);
    return _service.getApplicationsForUser(user.id);
  }
}

final applicationsServiceProvider = Provider<ApplicationsService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApplicationsService(dio);
});


