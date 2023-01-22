part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesInitialState extends TopRatedMoviesState {}

class TopRatedMoviesLoadingState extends TopRatedMoviesState {}

class TopRatedMoviesErrorState extends TopRatedMoviesState {
  final String message;

  TopRatedMoviesErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMoviesHasDataState extends TopRatedMoviesState {
  final List<Movie> result;

  TopRatedMoviesHasDataState(this.result);

  @override
  List<Object> get props => [result];
}
