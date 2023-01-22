import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/usecases/search_tv_series_usecase.dart';
import 'package:feature_tv/presentation/bloc/search/search_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchTvSeriesUseCase extends Mock implements SearchTvSeriesUseCase {}

void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTvSeriesUseCase mockSearchTvSeriesUseCase;

  setUp(() {
    mockSearchTvSeriesUseCase = MockSearchTvSeriesUseCase();
    searchTvBloc = SearchTvBloc(mockSearchTvSeriesUseCase);
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
  final tQuery = 'ironman';

  test('initial state should be empty', () {
    expect(searchTvBloc.state, SearchEmpty());
  });

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(() => mockSearchTvSeriesUseCase.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(() => mockSearchTvSeriesUseCase.execute(tQuery));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(() => mockSearchTvSeriesUseCase.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(() => mockSearchTvSeriesUseCase.execute(tQuery));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Error] when no internet connection',
    build: () {
      when(() => mockSearchTvSeriesUseCase.execute(tQuery)).thenAnswer(
        (_) async => Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () =>
        [SearchLoading(), SearchError('Failed to connect to the network')],
    verify: (bloc) => verify(() => mockSearchTvSeriesUseCase.execute(tQuery)),
  );
}
