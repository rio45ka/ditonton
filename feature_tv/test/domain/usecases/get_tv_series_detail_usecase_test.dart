import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/repositories/tv_series_repository.dart';
import 'package:feature_tv/domain/usecases/get_tv_series_detail_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../dummy_data/dummy_objects.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late GetTvSeriesDetailUseCase usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetailUseCase(mockTvSeriesRepository);
  });

  const tId = 1396;

  test('should get tv series detail from the repository', () async {
    // arrange
    when(() => mockTvSeriesRepository.getTvSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvSeriesDetail));
  });
}
