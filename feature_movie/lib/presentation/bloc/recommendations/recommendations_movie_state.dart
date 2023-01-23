part of 'recommendations_movie_bloc.dart';

abstract class RecommendationsMovieState extends Equatable {
  const RecommendationsMovieState();

  @override
  List<Object> get props => [];
}

class RecommendationsMovieInitialState extends RecommendationsMovieState {}

class RecommendationsMovieLoadingState extends RecommendationsMovieState {}

class RecommendationsMovieHasDataState extends RecommendationsMovieState {
  final List<Movie> result;

  const RecommendationsMovieHasDataState(this.result);

  @override
  List<Object> get props => [result];
}

class RecommendationsMovieErrorState extends RecommendationsMovieState {
  final String message;

  const RecommendationsMovieErrorState(this.message);

  @override
  List<Object> get props => [message];
}
