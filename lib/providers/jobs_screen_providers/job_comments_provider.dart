import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/models/jobs_screen_models/job_comment_model.dart';
import 'package:job_seeker/services/job_comments_service.dart';

final jobCommentsProvider = FutureProvider.family<List<JobComment>, int>((
  ref,
  jobId,
) async {
  final service = ref.watch(jobCommentsServiceProvider);
  return service.getComments(jobId);
});

final jobCommentsNotifierProvider =
    NotifierProvider<JobCommentsNotifier, AsyncValue<List<JobComment>>>(
      JobCommentsNotifier.new,
    );

class JobCommentsNotifier extends Notifier<AsyncValue<List<JobComment>>> {
  @override
  AsyncValue<List<JobComment>> build() {
    return const AsyncValue.data([]);
  }

  Future<void> loadComments(int jobId) async {
    final service = ref.read(jobCommentsServiceProvider);
    state = const AsyncValue.loading();
    try {
      final comments = await service.getComments(jobId);
      state = AsyncValue.data(comments);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addComment(int jobId, String comment) async {
    final service = ref.read(jobCommentsServiceProvider);
    try {
      final newComment = await service.addComment(jobId, comment);
      final currentState = state;
      final currentComments = currentState.value ?? [];
      state = AsyncValue.data([...currentComments, newComment]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteComment(int jobId, int commentId) async {
    final service = ref.read(jobCommentsServiceProvider);
    try {
      await service.deleteComment(jobId, commentId);
      final currentState = state;
      final currentComments = currentState.value ?? [];
      state = AsyncValue.data(
        currentComments.where((c) => c.id != commentId).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
