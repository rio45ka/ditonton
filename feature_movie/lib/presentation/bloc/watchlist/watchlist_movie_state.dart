part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieInitialState extends WatchlistMovieState {}

class WatchlistMovieLoadingState extends WatchlistMovieState {}

class WatchlistMovieHasDataState extends WatchlistMovieState {
  final List<Movie> result;

  const WatchlistMovieHasDataState(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistMovieErrorState extends WatchlistMovieState {
  final String message;

  const WatchlistMovieErrorState(this.message);

  @override
  List<Object> get props => [message];
}
