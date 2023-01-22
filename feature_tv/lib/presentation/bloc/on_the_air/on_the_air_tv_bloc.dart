import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/usecases/get_on_the_air_tv_series_usecase.dart';

part 'on_the_air_tv_event.dart';
part 'on_the_air_tv_state.dart';

class OnTheAirTvBloc extends Bloc<OnTheAirTvEvent, OnTheAirTvState> {
  final GetOnTheAirTvSeriesUseCase _useCase;

  OnTheAirTvBloc(this._useCase) : super(OnTheAirTvInitialState()) {
    on<FetchOnTheAirTvSeries>((event, emit) async {
      emit(OnTheAirTvLoadingState());

      final result = await _useCase.execute();

      result.fold(
        (failure) => emit(OnTheAirTvErrorState(failure.message)),
        (data) => emit(OnTheAirTvHasDataState(data)),
      );
    });
  }
}
