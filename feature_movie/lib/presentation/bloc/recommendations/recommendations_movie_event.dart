part of 'recommendations_movie_bloc.dart';

abstract class RecommendationsMovieEvent extends Equatable {
  const RecommendationsMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationsMovie extends RecommendationsMovieEvent {
  final int id;

  FetchRecommendationsMovie(this.id);

  @override
  List<Object> get props => [id];
}
