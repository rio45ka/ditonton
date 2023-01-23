import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:feature_movie/presentation/bloc/recommendations/recommendations_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetMovieRecommendations extends Mock
    implements GetMovieRecommendations {}

void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late RecommendationsMovieBloc recommendationsMovieBloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationsMovieBloc =
        RecommendationsMovieBloc(mockGetMovieRecommendations);
  });

  test('initialState should be Empty', () {
    expect(recommendationsMovieBloc.state, RecommendationsMovieInitialState());
  });

  blocTest<RecommendationsMovieBloc, RecommendationsMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(() => mockGetMovieRecommendations.execute(testMovieDetail.id))
          .thenAnswer((_) async => Right(testMovieList));
      return recommendationsMovieBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationsMovie(testMovieDetail.id)),
    expect: () => [
      RecommendationsMovieLoadingState(),
      RecommendationsMovieHasDataState(testMovieList),
    ],
    verify: (bloc) {
      verify(() => mockGetMovieRecommendations.execute(testMovieDetail.id));
    },
  );

  blocTest<RecommendationsMovieBloc, RecommendationsMovieState>(
    'Should emit [Loading, Error] when get Recommendations is unsuccessful',
    build: () {
      when(() => mockGetMovieRecommendations.execute(testMovieDetail.id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationsMovieBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationsMovie(testMovieDetail.id)),
    expect: () => [
      RecommendationsMovieLoadingState(),
      RecommendationsMovieErrorState('Server Failure'),
    ],
    verify: (bloc) {
      verify(() => mockGetMovieRecommendations.execute(testMovieDetail.id));
    },
  );

  blocTest<RecommendationsMovieBloc, RecommendationsMovieState>(
    'Should emit [Loading, Error] when no internet connection',
    build: () {
      when(() => mockGetMovieRecommendations.execute(testMovieDetail.id))
          .thenAnswer(
        (_) async => Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
      return recommendationsMovieBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationsMovie(testMovieDetail.id)),
    expect: () => [
      RecommendationsMovieLoadingState(),
      RecommendationsMovieErrorState('Failed to connect to the network'),
    ],
    verify: (bloc) => verify(
      () => mockGetMovieRecommendations.execute(testMovieDetail.id),
    ),
  );
}
