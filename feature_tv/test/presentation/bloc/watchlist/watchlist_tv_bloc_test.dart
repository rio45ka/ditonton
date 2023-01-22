import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/get_tv_series_watchlist_usecase.dart';
import 'package:feature_tv/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTvSeriesWatchlistUseCase extends Mock
    implements GetTvSeriesWatchlistUseCase {}

void main() {
  late MockGetTvSeriesWatchlistUseCase mockGetTvSeriesWatchlistUseCase;
  late WatchlistTvBloc watchlistTvBloc;

  setUp(() {
    mockGetTvSeriesWatchlistUseCase = MockGetTvSeriesWatchlistUseCase();
    watchlistTvBloc = WatchlistTvBloc(mockGetTvSeriesWatchlistUseCase);
  });

  test('initialState should be Empty', () {
    expect(watchlistTvBloc.state, WatchlistTvInitialState());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'should emit[Loading, HasData] when data is gotten successfully',
    build: () {
      when(() => mockGetTvSeriesWatchlistUseCase.execute())
          .thenAnswer((_) async => Right([testWatchlistTvSeries]));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvLoadingState(),
      WatchlistTvHasDataState([testWatchlistTvSeries])
    ],
    verify: (bloc) => verify(() => mockGetTvSeriesWatchlistUseCase.execute()),
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(() => mockGetTvSeriesWatchlistUseCase.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvLoadingState(),
      WatchlistTvErrorState("Can't get data"),
    ],
    verify: (bloc) => verify(() => mockGetTvSeriesWatchlistUseCase.execute()),
  );
}
