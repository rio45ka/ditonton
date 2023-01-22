import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/usecases/get_top_rated_tv_series_usecase.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvSeriesUseCase _getTopRatedTvSeriesUseCase;

  TopRatedTvBloc(this._getTopRatedTvSeriesUseCase)
      : super(TopRatedTvInitialState()) {
    on<FetchTopRatedTvSeries>(
      (event, emit) async {
        emit(TopRatedTvLoadingState());

        final result = await _getTopRatedTvSeriesUseCase.execute();

        result.fold(
          (failure) => emit(TopRatedTvErrorState(failure.message)),
          (data) => emit(TopRatedTvHasDataState(data)),
        );
      },
    );
  }
}
