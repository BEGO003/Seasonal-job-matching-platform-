import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/services/home_screen_services/favorites_service.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

/// Generates mock job data for testing
Map<String, dynamic> generateMockJob(int id) => {
  'id': id,
  'title': 'Test Job $id',
  'description': 'Description for job $id',
  'type': 'FULL_TIME',
  'location': 'Remote',
  'startDate': '2025-01-01',
  'amount': 5000.0,
  'salary': 'MONTHLY',
  'status': 'OPEN',
  'numOfPositions': 1,
  'jobposterId': 10,
  'jobposterName': 'Company $id',
  'requirements': ['Skill A'],
  'categories': ['Tech'],
  'benefits': ['Health'],
};

void main() {
  late MockDio mockDio;
  late FavoritesService service;

  setUpAll(() {
    registerFallbackValue(Options());
  });

  setUp(() {
    mockDio = MockDio();
    service = FavoritesService(mockDio);

    // Setup mock to return job data
    when(() => mockDio.get(any(), options: any(named: 'options'))).thenAnswer((
      invocation,
    ) async {
      final path = invocation.positionalArguments[0] as String;
      final id = int.parse(path.split('/').last);
      return Response(
        data: generateMockJob(id),
        statusCode: 200,
        requestOptions: RequestOptions(path: path),
      );
    });
  });

  group('Performance Benchmarks (Time)', () {
    test('Benchmark: 10 jobs', () async {
      final jobIds = List.generate(10, (i) => '${i + 1}');

      final stopwatch = Stopwatch()..start();
      final result = await service.fetchFavoriteJobsByIds(jobIds);
      stopwatch.stop();

      print('');
      print('═══════════════════════════════════');
      print('📊 BENCHMARK: 10 Jobs');
      print('═══════════════════════════════════');
      print('⏱️  Time: ${stopwatch.elapsedMilliseconds} ms');
      print('✅ Success: ${result.jobs.length}');
      print('❌ Failed: ${result.failedIds.length}');
      print('');

      expect(result.jobs.length, 10);
    });

    test('Benchmark: 50 jobs', () async {
      final jobIds = List.generate(50, (i) => '${i + 1}');

      final stopwatch = Stopwatch()..start();
      final result = await service.fetchFavoriteJobsByIds(jobIds);
      stopwatch.stop();

      print('');
      print('═══════════════════════════════════');
      print('📊 BENCHMARK: 50 Jobs');
      print('═══════════════════════════════════');
      print('⏱️  Time: ${stopwatch.elapsedMilliseconds} ms');
      print('✅ Success: ${result.jobs.length}');
      print('❌ Failed: ${result.failedIds.length}');
      print('');

      expect(result.jobs.length, 50);
    });

    test('Benchmark: 100 jobs', () async {
      final jobIds = List.generate(100, (i) => '${i + 1}');

      final stopwatch = Stopwatch()..start();
      final result = await service.fetchFavoriteJobsByIds(jobIds);
      stopwatch.stop();

      print('');
      print('═══════════════════════════════════');
      print('📊 BENCHMARK: 100 Jobs');
      print('═══════════════════════════════════');
      print('⏱️  Time: ${stopwatch.elapsedMilliseconds} ms');
      print('✅ Success: ${result.jobs.length}');
      print('❌ Failed: ${result.failedIds.length}');
      print('');

      expect(result.jobs.length, 100);
    });

    test('Benchmark: 250 jobs', () async {
      final jobIds = List.generate(250, (i) => '${i + 1}');

      final stopwatch = Stopwatch()..start();
      final result = await service.fetchFavoriteJobsByIds(jobIds);
      stopwatch.stop();

      print('');
      print('═══════════════════════════════════');
      print('📊 BENCHMARK: 250 Jobs');
      print('═══════════════════════════════════');
      print('⏱️  Time: ${stopwatch.elapsedMilliseconds} ms');
      print('✅ Success: ${result.jobs.length}');
      print('❌ Failed: ${result.failedIds.length}');
      print('');

      expect(result.jobs.length, 250);
    });

    test('Benchmark: 500 jobs', () async {
      final jobIds = List.generate(500, (i) => '${i + 1}');

      final stopwatch = Stopwatch()..start();
      final result = await service.fetchFavoriteJobsByIds(jobIds);
      stopwatch.stop();

      print('');
      print('═══════════════════════════════════');
      print('📊 BENCHMARK: 500 Jobs');
      print('═══════════════════════════════════');
      print('⏱️  Time: ${stopwatch.elapsedMilliseconds} ms');
      print('✅ Success: ${result.jobs.length}');
      print('❌ Failed: ${result.failedIds.length}');
      print('');

      expect(result.jobs.length, 500);
    });

    test('Benchmark: 1000 jobs', () async {
      final jobIds = List.generate(1000, (i) => '${i + 1}');

      final stopwatch = Stopwatch()..start();
      final result = await service.fetchFavoriteJobsByIds(jobIds);
      stopwatch.stop();

      print('');
      print('═══════════════════════════════════');
      print('📊 BENCHMARK: 1000 Jobs');
      print('═══════════════════════════════════');
      print('⏱️  Time: ${stopwatch.elapsedMilliseconds} ms');
      print('✅ Success: ${result.jobs.length}');
      print('❌ Failed: ${result.failedIds.length}');
      print('');

      expect(result.jobs.length, 1000);
    });

    test('Benchmark: 2000 jobs (max)', () async {
      final jobIds = List.generate(2000, (i) => '${i + 1}');

      final stopwatch = Stopwatch()..start();
      final result = await service.fetchFavoriteJobsByIds(jobIds);
      stopwatch.stop();

      print('');
      print('═══════════════════════════════════');
      print('📊 BENCHMARK: 2000 Jobs (MAX)');
      print('═══════════════════════════════════');
      print('⏱️  Time: ${stopwatch.elapsedMilliseconds} ms');
      print('✅ Success: ${result.jobs.length}');
      print('❌ Failed: ${result.failedIds.length}');
      print('');

      expect(result.jobs.length, 2000);
    });

    test('Summary: All benchmarks', () async {
      final benchmarks = <int, int>{};

      for (final count in [10, 50, 100, 250, 500, 1000, 2000, 10000, 100000]) {
        final jobIds = List.generate(count, (i) => '${i + 1}');
        final stopwatch = Stopwatch()..start();
        await service.fetchFavoriteJobsByIds(jobIds);
        stopwatch.stop();
        benchmarks[count] = stopwatch.elapsedMilliseconds;
      }

      print('');
      print('╔═══════════════════════════════════════════╗');
      print('║     📊 PERFORMANCE BENCHMARK SUMMARY      ║');
      print('╠═══════════════════════════════════════════╣');
      print('║  Jobs Count  │  Time (ms)  │  ms/job      ║');
      print('╠═══════════════════════════════════════════╣');
      for (final entry in benchmarks.entries) {
        final msPerJob = entry.key > 0
            ? (entry.value / entry.key).toStringAsFixed(3)
            : '0';
        print(
          '║  ${entry.key.toString().padLeft(10)}  │  ${entry.value.toString().padLeft(9)}  │  ${msPerJob.padLeft(9)}  ║',
        );
      }
      print('╚═══════════════════════════════════════════╝');
      print('');

      expect(benchmarks.length, 9);
    });
  });
}
