part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesInitialState extends NowPlayingMoviesState {}

class NowPlayingMoviesLoadingState extends NowPlayingMoviesState {}

class NowPlayingMoviesErrorState extends NowPlayingMoviesState {
  final String message;

  NowPlayingMoviesErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesHasDataState extends NowPlayingMoviesState {
  final List<Movie> result;

  NowPlayingMoviesHasDataState(this.result);

  @override
  List<Object> get props => [result];
}
