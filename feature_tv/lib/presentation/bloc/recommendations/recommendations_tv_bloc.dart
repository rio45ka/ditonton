import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/usecases/get_recommendations_tv_series_usecase.dart';

part 'recommendations_tv_event.dart';
part 'recommendations_tv_state.dart';

class RecommendationsTvBloc
    extends Bloc<RecommendationsTvEvent, RecommendationsTvState> {
  final GetRecommendationsTvSeriesUseCase _useCase;

  RecommendationsTvBloc(this._useCase)
      : super(RecommendationsTvInitialState()) {
    on<FetchRecommendationsTvSeries>((event, emit) async {
      emit(RecommendationsTvLoadingState());

      final result = await _useCase.execute(event.id);

      result.fold(
        (failure) => emit(RecommendationsTvErrorState(failure.message)),
        (data) => emit(RecommendationsTvHasDataState(data)),
      );
    });
  }
}
