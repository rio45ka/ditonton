import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/usecases/get_popular_tv_series_usecase.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvSeriesUseCase _getPopularTvSeriesUseCase;

  PopularTvBloc(this._getPopularTvSeriesUseCase)
      : super(PopularTvInitialState()) {
    on<FetchPopularTvSeries>(
      (event, emit) async {
        emit(PopularTvLoadingState());

        final result = await _getPopularTvSeriesUseCase.execute();

        result.fold(
          (failure) => emit(PopularTvErrorState(failure.message)),
          (data) => emit(PopularTvHasDataState(data)),
        );
      },
    );
  }
}
