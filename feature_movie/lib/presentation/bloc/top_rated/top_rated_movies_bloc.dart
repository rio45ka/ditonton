import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies)
      : super(TopRatedMoviesInitialState()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(TopRatedMoviesLoadingState());

      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(TopRatedMoviesErrorState(failure.message)),
        (data) => emit(TopRatedMoviesHasDataState(data)),
      );
    });
  }
}
