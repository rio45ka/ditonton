import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies)
      : super(PopularMoviesInitialState()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoadingState());

      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) => emit(PopularMoviesErrorState(failure.message)),
        (data) => emit(PopularMoviesHasDataState(data)),
      );
    });
  }
}
