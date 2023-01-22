import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/usecases/get_top_rated_tv_series_usecase.dart';
import 'package:feature_tv/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTopRatedTvSeriesUseCase extends Mock
    implements GetTopRatedTvSeriesUseCase {}

void main() {
  late MockGetTopRatedTvSeriesUseCase mockUseCase;
  late TopRatedTvBloc topRatedTvBloc;

  setUp(() {
    mockUseCase = MockGetTopRatedTvSeriesUseCase();
    topRatedTvBloc = TopRatedTvBloc(mockUseCase);
  });

  final tTvSeries = TvSeries(
    backdropPath: '/yXSzo0VU1Q1QaB7Xg5Hqe4tXXA3.jpg',
    genreIds: [18],
    id: 1396,
    name: 'Breaking Bad',
    originCountry: ["US"],
    originalLanguage: 'en',
    originalName: 'Breaking Bad',
    overview:
        'When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family\'s financial future at any cost as he enters the dangerous world of drugs and crime.',
    popularity: 383.111,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    voteAverage: 8.9,
    voteCount: 10873,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('initialState should be Empty', () {
    expect(topRatedTvBloc.state, TopRatedTvInitialState());
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(() => mockUseCase.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () => [
      TopRatedTvLoadingState(),
      TopRatedTvHasDataState(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(() => mockUseCase.execute());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Error] when get Top Rated is unsuccessful',
    build: () {
      when(() => mockUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () => [
      TopRatedTvLoadingState(),
      TopRatedTvErrorState('Server Failure'),
    ],
    verify: (bloc) {
      verify(() => mockUseCase.execute());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Error] when no internet connection',
    build: () {
      when(() => mockUseCase.execute()).thenAnswer(
        (_) async => Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () => [
      TopRatedTvLoadingState(),
      TopRatedTvErrorState('Failed to connect to the network'),
    ],
    verify: (bloc) => verify(
      () => mockUseCase.execute(),
    ),
  );
}
