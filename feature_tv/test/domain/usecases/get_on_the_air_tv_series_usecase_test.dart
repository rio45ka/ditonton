import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/repositories/tv_series_repository.dart';
import 'package:feature_tv/domain/usecases/get_on_the_air_tv_series_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late GetOnTheAirTvSeriesUseCase usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetOnTheAirTvSeriesUseCase(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of tv series on the air from the repository', () async {
    // arrange
    when(() => mockTvSeriesRepository.getOnTheAirTvSeries())
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeries));
  });
}
