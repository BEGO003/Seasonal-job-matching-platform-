import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/services/applications_screen_services/applications_service.dart';

final applicationsProvider = AsyncNotifierProvider<ApplicationsNotifier, List<ApplicationWithJob>>(
  ApplicationsNotifier.new,
);

class ApplicationsNotifier extends AsyncNotifier<List<ApplicationWithJob>> {
  late final ApplicationsService _service = ref.read(applicationsServiceProvider);
  static const _demoUserId = '1'; // update to use logged-in user ID as needed

  @override
  Future<List<ApplicationWithJob>> build() async {
    return _service.getApplicationsForUser(_demoUserId);
  }
}

final applicationsServiceProvider = Provider<ApplicationsService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApplicationsService(dio);
});


