import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_movie/domain/entities/movie_detail.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_status.dart';
import 'package:feature_movie/domain/usecases/remove_watchlist.dart';
import 'package:feature_movie/domain/usecases/save_watchlist.dart';

part 'watchlist_status_movie_state.dart';

class WatchlistStatusMovieCubit extends Cubit<WatchlistStatusMovieState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  WatchlistStatusMovieCubit({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistStatusMovieState(message: '', isAddedWatchlist: false));

  void loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(WatchlistStatusMovieState(isAddedWatchlist: result, message: ''));
  }

  Future<void> addWatchlist(MovieDetail movieDetail) async {
    final result = await saveWatchlist.execute(movieDetail);
    final getStatus = await getWatchListStatus.execute(movieDetail.id);

    result.fold(
      (failure) => emit(WatchlistStatusMovieState(
          isAddedWatchlist: getStatus, message: failure.message)),
      (data) => emit(WatchlistStatusMovieState(
          isAddedWatchlist: getStatus, message: data)),
    );
  }

  Future<void> removeFromWatchlist(MovieDetail movieDetail) async {
    final result = await removeWatchlist.execute(movieDetail);
    final getStatus = await getWatchListStatus.execute(movieDetail.id);

    result.fold(
      (failure) => emit(WatchlistStatusMovieState(
          isAddedWatchlist: getStatus, message: failure.message)),
      (data) => emit(WatchlistStatusMovieState(
          isAddedWatchlist: getStatus, message: data)),
    );
  }
}
