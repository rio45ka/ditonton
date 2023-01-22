import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/get_tv_series_watchlist_status_usecase.dart';
import 'package:feature_tv/domain/usecases/remove_tv_series_watchlist_usecase.dart';
import 'package:feature_tv/domain/usecases/save_tv_series_watchlist_usecase.dart';
import 'package:feature_tv/presentation/bloc/watchlist_status/watchlist_status_tv_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTvSeriesWatchListStatusUseCase extends Mock
    implements GetTvSeriesWatchListStatusUseCase {}

class MockRemoveTvSeriesWatchlistUseCase extends Mock
    implements RemoveTvSeriesWatchlistUseCase {}

class MockSaveTvSeriesWatchlistUseCase extends Mock
    implements SaveTvSeriesWatchlistUseCase {}

void main() {
  late MockGetTvSeriesWatchListStatusUseCase
      mockGetTvSeriesWatchListStatusUseCase;
  late MockRemoveTvSeriesWatchlistUseCase mockRemoveTvSeriesWatchlistUseCase;
  late MockSaveTvSeriesWatchlistUseCase mockSaveTvSeriesWatchlistUseCase;
  late WatchlistStatusTvCubit watchlistStatusTvCubit;

  setUp(() {
    mockGetTvSeriesWatchListStatusUseCase =
        MockGetTvSeriesWatchListStatusUseCase();
    mockRemoveTvSeriesWatchlistUseCase = MockRemoveTvSeriesWatchlistUseCase();
    mockSaveTvSeriesWatchlistUseCase = MockSaveTvSeriesWatchlistUseCase();
    watchlistStatusTvCubit = WatchlistStatusTvCubit(
      getTvSeriesWatchListStatusUseCase: mockGetTvSeriesWatchListStatusUseCase,
      saveTvSeriesWatchlistUseCase: mockSaveTvSeriesWatchlistUseCase,
      removeTvSeriesWatchlistUseCase: mockRemoveTvSeriesWatchlistUseCase,
    );
  });

  final tId = 1396;

  group('Get Watchlist Status Tv', () {
    blocTest<WatchlistStatusTvCubit, WatchlistStatusTvState>(
      'should get watchlist true',
      build: () {
        when(() => mockGetTvSeriesWatchListStatusUseCase.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistStatusTvCubit;
      },
      act: (bloc) => bloc.loadWatchlistStatus(tId),
      expect: () => [
        WatchlistStatusTvState(isAddedWatchlist: true, message: ''),
      ],
    );
  });

  group('Save Watchlist TV', () {
    blocTest<WatchlistStatusTvCubit, WatchlistStatusTvState>(
      'should execute save watchlist when function called',
      build: () {
        when(() => mockSaveTvSeriesWatchlistUseCase.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(() => mockGetTvSeriesWatchListStatusUseCase
            .execute(testTvSeriesDetail.id)).thenAnswer((_) async => true);
        return watchlistStatusTvCubit;
      },
      act: (bloc) => bloc.addWatchlist(testTvSeriesDetail),
      expect: () => [
        WatchlistStatusTvState(
            isAddedWatchlist: true, message: 'Added to Watchlist'),
      ],
    );

    blocTest<WatchlistStatusTvCubit, WatchlistStatusTvState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(() => mockSaveTvSeriesWatchlistUseCase.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(() => mockGetTvSeriesWatchListStatusUseCase
            .execute(testTvSeriesDetail.id)).thenAnswer((_) async => false);
        return watchlistStatusTvCubit;
      },
      act: (bloc) => bloc.addWatchlist(testTvSeriesDetail),
      expect: () => [
        WatchlistStatusTvState(isAddedWatchlist: false, message: 'Failed'),
      ],
    );
  });

  group('Remove Watchlist TV', () {
    blocTest<WatchlistStatusTvCubit, WatchlistStatusTvState>(
      'should execute remove watchlist when function called',
      build: () {
        when(() =>
                mockRemoveTvSeriesWatchlistUseCase.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Removed'));
        when(() => mockGetTvSeriesWatchListStatusUseCase
            .execute(testTvSeriesDetail.id)).thenAnswer((_) async => true);
        return watchlistStatusTvCubit;
      },
      act: (bloc) => bloc.removeFromWatchlist(testTvSeriesDetail),
      expect: () => [
        const WatchlistStatusTvState(
            isAddedWatchlist: true, message: 'Removed'),
      ],
    );

    blocTest<WatchlistStatusTvCubit, WatchlistStatusTvState>(
      'should update watchlist message when remove watchlist failed',
      build: () {
        when(() =>
                mockRemoveTvSeriesWatchlistUseCase.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(() => mockGetTvSeriesWatchListStatusUseCase
            .execute(testTvSeriesDetail.id)).thenAnswer((_) async => false);
        return watchlistStatusTvCubit;
      },
      act: (bloc) => bloc.removeFromWatchlist(testTvSeriesDetail),
      expect: () => [
        WatchlistStatusTvState(isAddedWatchlist: false, message: 'Failed'),
      ],
    );
  });
}
