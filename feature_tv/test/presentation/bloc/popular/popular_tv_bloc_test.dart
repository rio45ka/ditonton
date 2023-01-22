import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/usecases/get_popular_tv_series_usecase.dart';
import 'package:feature_tv/presentation/bloc/popular/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPopularTvSeriesUseCase extends Mock
    implements GetPopularTvSeriesUseCase {}

void main() {
  late MockGetPopularTvSeriesUseCase mockGetPopularTvSeriesUseCase;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTvSeriesUseCase = MockGetPopularTvSeriesUseCase();
    popularTvBloc = PopularTvBloc(mockGetPopularTvSeriesUseCase);
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
    expect(popularTvBloc.state, PopularTvInitialState());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(() => mockGetPopularTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () => [
      PopularTvLoadingState(),
      PopularTvHasDataState(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(() => mockGetPopularTvSeriesUseCase.execute());
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Error] when get Popular is unsuccessful',
    build: () {
      when(() => mockGetPopularTvSeriesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () => [
      PopularTvLoadingState(),
      PopularTvErrorState('Server Failure'),
    ],
    verify: (bloc) {
      verify(() => mockGetPopularTvSeriesUseCase.execute());
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Error] when no internet connection',
    build: () {
      when(() => mockGetPopularTvSeriesUseCase.execute()).thenAnswer(
        (_) async => Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () => [
      PopularTvLoadingState(),
      PopularTvErrorState('Failed to connect to the network'),
    ],
    verify: (bloc) => verify(
      () => mockGetPopularTvSeriesUseCase.execute(),
    ),
  );
}
