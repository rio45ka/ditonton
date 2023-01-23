import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_status.dart';
import 'package:feature_movie/domain/usecases/remove_watchlist.dart';
import 'package:feature_movie/domain/usecases/save_watchlist.dart';
import 'package:feature_movie/presentation/bloc/watchlist_status/watchlist_status_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}

class MockRemoveRemoveWatchlist extends Mock implements RemoveWatchlist {}

class MockSaveWatchlist extends Mock implements SaveWatchlist {}

void main() {
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveRemoveWatchlist mockRemoveRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late WatchlistStatusMovieCubit watchlistStatusMovieCubit;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockRemoveRemoveWatchlist = MockRemoveRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    watchlistStatusMovieCubit = WatchlistStatusMovieCubit(
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveRemoveWatchlist,
    );
  });

  final tId = 1;

  group('Get Watchlist Status Movie', () {
    blocTest<WatchlistStatusMovieCubit, WatchlistStatusMovieState>(
      'should get watchlist true',
      build: () {
        when(() => mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistStatusMovieCubit;
      },
      act: (bloc) => bloc.loadWatchlistStatus(tId),
      expect: () => [
        WatchlistStatusMovieState(isAddedWatchlist: true, message: ''),
      ],
    );
  });

  group('Save Watchlist Movie', () {
    blocTest<WatchlistStatusMovieCubit, WatchlistStatusMovieState>(
      'should execute save watchlist when function called',
      build: () {
        when(() => mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(() => mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistStatusMovieCubit;
      },
      act: (bloc) => bloc.addWatchlist(testMovieDetail),
      expect: () => [
        WatchlistStatusMovieState(
            isAddedWatchlist: true, message: 'Added to Watchlist'),
      ],
    );

    blocTest<WatchlistStatusMovieCubit, WatchlistStatusMovieState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(() => mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(() => mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchlistStatusMovieCubit;
      },
      act: (bloc) => bloc.addWatchlist(testMovieDetail),
      expect: () => [
        WatchlistStatusMovieState(isAddedWatchlist: false, message: 'Failed'),
      ],
    );
  });

  group('Remove Watchlist Movie', () {
    blocTest<WatchlistStatusMovieCubit, WatchlistStatusMovieState>(
      'should execute remove watchlist when function called',
      build: () {
        when(() => mockRemoveRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Removed'));
        when(() => mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistStatusMovieCubit;
      },
      act: (bloc) => bloc.removeFromWatchlist(testMovieDetail),
      expect: () => [
        const WatchlistStatusMovieState(
            isAddedWatchlist: true, message: 'Removed'),
      ],
    );

    blocTest<WatchlistStatusMovieCubit, WatchlistStatusMovieState>(
      'should update watchlist message when remove watchlist failed',
      build: () {
        when(() => mockRemoveRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(() => mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchlistStatusMovieCubit;
      },
      act: (bloc) => bloc.removeFromWatchlist(testMovieDetail),
      expect: () => [
        WatchlistStatusMovieState(isAddedWatchlist: false, message: 'Failed'),
      ],
    );
  });
}
