import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies)
      : super(NowPlayingMoviesInitialState()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMoviesLoadingState());

      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) => emit(NowPlayingMoviesErrorState(failure.message)),
        (data) => emit(NowPlayingMoviesHasDataState(data)),
      );
    });
  }
}
