part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTvInitialState extends PopularTvState {}

class PopularTvLoadingState extends PopularTvState {}

class PopularTvErrorState extends PopularTvState {
  final String message;

  PopularTvErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvHasDataState extends PopularTvState {
  final List<TvSeries> result;

  PopularTvHasDataState(this.result);

  @override
  List<Object> get props => [result];
}
