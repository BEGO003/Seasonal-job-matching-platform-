


import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/services/jobs_screen_services/jobs_services_provider.dart';


final jobsNotifierProvider = AsyncNotifierProvider<JobNotifier, List<JobModel>>(JobNotifier.new);

class JobNotifier extends AsyncNotifier<List<JobModel>> {
  @override
  FutureOr<List<JobModel>> build() {
    return _fetchJobs();
  }
  
  Future<List<JobModel>> _fetchJobs() async{
    final service = ref.read(jobServiceProvider);
    return await service.fetchJobs();
  }
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchJobs());
  }
}