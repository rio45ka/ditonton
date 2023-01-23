part of 'detail_movie_bloc.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class DetailMovieInitialState extends DetailMovieState {}

class DetailMovieLoadingState extends DetailMovieState {}

class DetailMovieHasDataState extends DetailMovieState {
  final MovieDetail result;

  const DetailMovieHasDataState(this.result);

  @override
  List<Object> get props => [result];
}

class DetailMovieErrorState extends DetailMovieState {
  final String message;

  const DetailMovieErrorState(this.message);

  @override
  List<Object> get props => [message];
}
