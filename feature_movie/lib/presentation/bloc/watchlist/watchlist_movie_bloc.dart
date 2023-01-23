import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieBloc(this._getWatchlistMovies)
      : super(WatchlistMovieInitialState()) {
    on<WatchlistMovieEvent>((event, emit) async {
      emit(WatchlistMovieLoadingState());

      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) => emit(WatchlistMovieErrorState(failure.message)),
        (data) => emit(WatchlistMovieHasDataState(data)),
      );
    });
  }
}
