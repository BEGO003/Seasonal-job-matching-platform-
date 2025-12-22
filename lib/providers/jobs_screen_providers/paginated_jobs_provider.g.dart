// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_jobs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Paginated jobs provider with infinite scroll + load more support
/// Uses @riverpod generator for cleaner code

@ProviderFor(PaginatedJobs)
const paginatedJobsProvider = PaginatedJobsProvider._();

/// Paginated jobs provider with infinite scroll + load more support
/// Uses @riverpod generator for cleaner code
final class PaginatedJobsProvider
    extends $AsyncNotifierProvider<PaginatedJobs, PaginatedJobsState> {
  /// Paginated jobs provider with infinite scroll + load more support
  /// Uses @riverpod generator for cleaner code
  const PaginatedJobsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paginatedJobsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paginatedJobsHash();

  @$internal
  @override
  PaginatedJobs create() => PaginatedJobs();
}

String _$paginatedJobsHash() => r'b681a9745253f5f22118548800da0825d3c90332';

/// Paginated jobs provider with infinite scroll + load more support
/// Uses @riverpod generator for cleaner code

abstract class _$PaginatedJobs extends $AsyncNotifier<PaginatedJobsState> {
  FutureOr<PaginatedJobsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<PaginatedJobsState>, PaginatedJobsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PaginatedJobsState>, PaginatedJobsState>,
              AsyncValue<PaginatedJobsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
