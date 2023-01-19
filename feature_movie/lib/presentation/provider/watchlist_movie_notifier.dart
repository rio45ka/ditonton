import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_watchlist_usecase.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_watchlist_movies.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  var _watchlistTvSeries = <TvSeries>[];
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  var _watchlistTvSeriesState = RequestState.Empty;
  RequestState get watchlistTvSeriesState => _watchlistTvSeriesState;

  String _message = '';
  String get message => _message;

  WatchlistMovieNotifier({
    required this.getWatchlistMovies,
    required this.getTvSeriesWatchlistUseCase,
  });

  final GetWatchlistMovies getWatchlistMovies;
  final GetTvSeriesWatchlistUseCase getTvSeriesWatchlistUseCase;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesWatchlistUseCase.execute();
    result.fold(
      (failure) {
        _watchlistTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _watchlistTvSeriesState = RequestState.Loaded;
        _watchlistTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
