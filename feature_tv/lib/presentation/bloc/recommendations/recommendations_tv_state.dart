part of 'recommendations_tv_bloc.dart';

abstract class RecommendationsTvState extends Equatable {
  const RecommendationsTvState();

  @override
  List<Object> get props => [];
}

class RecommendationsTvInitialState extends RecommendationsTvState {}

class RecommendationsTvLoadingState extends RecommendationsTvState {}

class RecommendationsTvHasDataState extends RecommendationsTvState {
  final List<TvSeries> result;

  const RecommendationsTvHasDataState(this.result);

  @override
  List<Object> get props => [result];
}

class RecommendationsTvErrorState extends RecommendationsTvState {
  final String message;

  const RecommendationsTvErrorState(this.message);

  @override
  List<Object> get props => [message];
}
