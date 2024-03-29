import 'package:feature_tv/domain/usecases/get_tv_series_watchlist_status_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:feature_tv/domain/repositories/tv_series_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late GetTvSeriesWatchListStatusUseCase usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesWatchListStatusUseCase(mockTvSeriesRepository);
  });

  test('should get tv series watchlist status from repository', () async {
    // arrange
    when(() => mockTvSeriesRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
