import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:feature_movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchlistMovies extends Mock implements GetWatchlistMovies {}

void main() {
  late MockGetWatchlistMovies mockUseCase;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    mockUseCase = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(mockUseCase);
  });

  test('initialState should be Empty', () {
    expect(watchlistMovieBloc.state, WatchlistMovieInitialState());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should emit[Loading, HasData] when data is gotten successfully',
    build: () {
      when(() => mockUseCase.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      WatchlistMovieLoadingState(),
      WatchlistMovieHasDataState([testWatchlistMovie])
    ],
    verify: (bloc) => verify(() => mockUseCase.execute()),
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(() => mockUseCase.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      WatchlistMovieLoadingState(),
      WatchlistMovieErrorState("Can't get data"),
    ],
    verify: (bloc) => verify(() => mockUseCase.execute()),
  );
}
