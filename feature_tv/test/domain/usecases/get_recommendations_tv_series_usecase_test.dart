import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/repositories/tv_series_repository.dart';
import 'package:feature_tv/domain/usecases/get_recommendations_tv_series_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late GetRecommendationsTvSeriesUseCase usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetRecommendationsTvSeriesUseCase(mockTvSeriesRepository);
  });

  const tId = 1;
  final tTvSeries = <TvSeries>[];

  test('should get list of tv series recommendations from the repository',
      () async {
    // arrange
    when(() => mockTvSeriesRepository.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvSeries));
  });
}
