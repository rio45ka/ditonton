import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_movie/domain/entities/movie_detail.dart';
import 'package:feature_movie/domain/usecases/get_movie_detail.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getMovieDetail;
  DetailMovieBloc(this._getMovieDetail) : super(DetailMovieInitialState()) {
    on<FetchDetailMovie>((event, emit) async {
      emit(DetailMovieLoadingState());

      final result = await _getMovieDetail.execute(event.id);

      result.fold(
        (failure) => emit(DetailMovieErrorState(failure.message)),
        (data) => emit(DetailMovieHasDataState(data)),
      );
    });
  }
}
