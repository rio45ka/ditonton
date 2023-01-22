import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_tv/domain/entities/tv_series_detail.dart';
import 'package:feature_tv/domain/usecases/get_tv_series_detail_usecase.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTvSeriesDetailUseCase _useCase;
  DetailTvBloc(this._useCase) : super(DetailTvInitialState()) {
    on<FetchDetailTvSeries>((event, emit) async {
      emit(DetailTvLoadingState());

      final result = await _useCase.execute(event.id);

      result.fold(
        (failure) => emit(DetailTvErrorState(failure.message)),
        (data) => emit(DetailTvHasDataState(data)),
      );
    });
  }
}
