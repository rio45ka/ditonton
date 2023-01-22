import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/remove_tv_series_watchlist_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:feature_tv/domain/repositories/tv_series_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late RemoveTvSeriesWatchlistUseCase usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveTvSeriesWatchlistUseCase(mockTvSeriesRepository);
  });

  test('should remove watchlist tv series from repository', () async {
    // arrange
    when(() => mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(() => mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
