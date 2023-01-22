import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_tv/domain/entities/tv_series_detail.dart';
import 'package:feature_tv/domain/usecases/get_tv_series_watchlist_status_usecase.dart';
import 'package:feature_tv/domain/usecases/remove_tv_series_watchlist_usecase.dart';
import 'package:feature_tv/domain/usecases/save_tv_series_watchlist_usecase.dart';

part 'watchlist_status_tv_state.dart';

class WatchlistStatusTvCubit extends Cubit<WatchlistStatusTvState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesWatchListStatusUseCase getTvSeriesWatchListStatusUseCase;
  final SaveTvSeriesWatchlistUseCase saveTvSeriesWatchlistUseCase;
  final RemoveTvSeriesWatchlistUseCase removeTvSeriesWatchlistUseCase;

  WatchlistStatusTvCubit({
    required this.getTvSeriesWatchListStatusUseCase,
    required this.saveTvSeriesWatchlistUseCase,
    required this.removeTvSeriesWatchlistUseCase,
  }) : super(WatchlistStatusTvState(message: '', isAddedWatchlist: false));

  void loadWatchlistStatus(int id) async {
    final result = await getTvSeriesWatchListStatusUseCase.execute(id);
    emit(WatchlistStatusTvState(isAddedWatchlist: result, message: ''));
  }

  Future<void> addWatchlist(TvSeriesDetail tvDetail) async {
    final result = await saveTvSeriesWatchlistUseCase.execute(tvDetail);
    final getStatus =
        await getTvSeriesWatchListStatusUseCase.execute(tvDetail.id);

    result.fold(
      (failure) => emit(WatchlistStatusTvState(
          isAddedWatchlist: getStatus, message: failure.message)),
      (data) => emit(
          WatchlistStatusTvState(isAddedWatchlist: getStatus, message: data)),
    );
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tvDetail) async {
    final result = await removeTvSeriesWatchlistUseCase.execute(tvDetail);
    final getStatus =
        await getTvSeriesWatchListStatusUseCase.execute(tvDetail.id);

    result.fold(
      (failure) => emit(WatchlistStatusTvState(
          isAddedWatchlist: getStatus, message: failure.message)),
      (data) => emit(
          WatchlistStatusTvState(isAddedWatchlist: getStatus, message: data)),
    );
  }
}
