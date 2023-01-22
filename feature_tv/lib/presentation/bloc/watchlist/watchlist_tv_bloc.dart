import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/usecases/get_tv_series_watchlist_usecase.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetTvSeriesWatchlistUseCase _getTvSeriesWatchlistUseCase;

  WatchlistTvBloc(this._getTvSeriesWatchlistUseCase)
      : super(WatchlistTvInitialState()) {
    on<WatchlistTvEvent>((event, emit) async {
      emit(WatchlistTvLoadingState());

      final result = await _getTvSeriesWatchlistUseCase.execute();

      result.fold(
        (failure) => emit(WatchlistTvErrorState(failure.message)),
        (data) => emit(WatchlistTvHasDataState(data)),
      );
    });
  }
}
