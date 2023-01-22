import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/usecases/search_tv_series_usecase.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTvSeriesUseCase _searchTvUseCase;

  SearchTvBloc(this._searchTvUseCase) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());

      final result = await _searchTvUseCase.execute(query);

      result.fold((failure) {
        emit(SearchError(failure.message));
      }, (data) {
        emit(SearchHasData(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
