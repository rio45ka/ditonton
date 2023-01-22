part of 'on_the_air_tv_bloc.dart';

abstract class OnTheAirTvState extends Equatable {
  const OnTheAirTvState();

  @override
  List<Object> get props => [];
}

class OnTheAirTvInitialState extends OnTheAirTvState {}

class OnTheAirTvLoadingState extends OnTheAirTvState {}

class OnTheAirTvErrorState extends OnTheAirTvState {
  final String message;

  OnTheAirTvErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class OnTheAirTvHasDataState extends OnTheAirTvState {
  final List<TvSeries> result;

  OnTheAirTvHasDataState(this.result);

  @override
  List<Object> get props => [result];
}
