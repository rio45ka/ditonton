import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/get_recommendations_tv_series_usecase.dart';
import 'package:feature_tv/presentation/bloc/recommendations/recommendations_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetRecommendationsTvSeriesUseCase extends Mock
    implements GetRecommendationsTvSeriesUseCase {}

void main() {
  late RecommendationsTvBloc recommendationsTvBloc;
  late MockGetRecommendationsTvSeriesUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetRecommendationsTvSeriesUseCase();
    recommendationsTvBloc = RecommendationsTvBloc(mockUseCase);
  });

  final tId = 1396;

  test('initialState should be Empty', () {
    expect(recommendationsTvBloc.state, RecommendationsTvInitialState());
  });

  blocTest<RecommendationsTvBloc, RecommendationsTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(() => mockUseCase.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return recommendationsTvBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationsTvSeries(tId)),
    expect: () => [
      RecommendationsTvLoadingState(),
      RecommendationsTvHasDataState(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(() => mockUseCase.execute(tId));
    },
  );

  blocTest<RecommendationsTvBloc, RecommendationsTvState>(
    'Should emit [Loading, Error] when get Recommendations is unsuccessful',
    build: () {
      when(() => mockUseCase.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationsTvBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationsTvSeries(tId)),
    expect: () => [
      RecommendationsTvLoadingState(),
      RecommendationsTvErrorState('Server Failure'),
    ],
    verify: (bloc) {
      verify(() => mockUseCase.execute(tId));
    },
  );

  blocTest<RecommendationsTvBloc, RecommendationsTvState>(
    'Should emit [Loading, Error] when no internet connection',
    build: () {
      when(() => mockUseCase.execute(tId)).thenAnswer(
        (_) async => Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
      return recommendationsTvBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationsTvSeries(tId)),
    expect: () => [
      RecommendationsTvLoadingState(),
      RecommendationsTvErrorState('Failed to connect to the network'),
    ],
    verify: (bloc) => verify(
      () => mockUseCase.execute(tId),
    ),
  );
}
