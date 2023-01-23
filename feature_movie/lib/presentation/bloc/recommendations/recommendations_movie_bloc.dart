import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_movie_recommendations.dart';

part 'recommendations_movie_event.dart';
part 'recommendations_movie_state.dart';

class RecommendationsMovieBloc
    extends Bloc<RecommendationsMovieEvent, RecommendationsMovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationsMovieBloc(this._getMovieRecommendations)
      : super(RecommendationsMovieInitialState()) {
    on<FetchRecommendationsMovie>((event, emit) async {
      emit(RecommendationsMovieLoadingState());

      final result = await _getMovieRecommendations.execute(event.id);

      result.fold(
        (failure) => emit(RecommendationsMovieErrorState(failure.message)),
        (data) => emit(RecommendationsMovieHasDataState(data)),
      );
    });
  }
}
