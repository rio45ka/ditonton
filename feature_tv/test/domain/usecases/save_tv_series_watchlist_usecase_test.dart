import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/save_tv_series_watchlist_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:feature_tv/domain/repositories/tv_series_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late SaveTvSeriesWatchlistUseCase usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveTvSeriesWatchlistUseCase(mockTvSeriesRepository);
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(() => mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(() => mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
