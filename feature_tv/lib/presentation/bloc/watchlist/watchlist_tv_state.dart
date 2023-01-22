part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvInitialState extends WatchlistTvState {}

class WatchlistTvLoadingState extends WatchlistTvState {}

class WatchlistTvHasDataState extends WatchlistTvState {
  final List<TvSeries> result;

  const WatchlistTvHasDataState(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistTvErrorState extends WatchlistTvState {
  final String message;

  const WatchlistTvErrorState(this.message);

  @override
  List<Object> get props => [message];
}
