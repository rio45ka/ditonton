part of 'recommendations_tv_bloc.dart';

abstract class RecommendationsTvEvent extends Equatable {
  const RecommendationsTvEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationsTvSeries extends RecommendationsTvEvent {
  final int id;

  const FetchRecommendationsTvSeries(this.id);

  @override
  List<Object> get props => [id];
}
