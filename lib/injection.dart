import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/tv_series/get_on_the_air_tv_series_usecase.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series_usecase.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series_usecase.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail_usecase.dart';
import 'package:core/domain/usecases/tv_series/get_recommendations_tv_series_usecase.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_watchlist_status_usecase.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_watchlist_usecase.dart';
import 'package:core/domain/usecases/tv_series/remove_tv_series_watchlist_usecase.dart';
import 'package:core/domain/usecases/tv_series/save_tv_series_watchlist_usecase.dart';
import 'package:core/presentation/provider/tv_series/on_the_air_tv_series_notifier.dart';
import 'package:core/presentation/provider/tv_series/popular_tv_series_notifier.dart';
import 'package:core/presentation/provider/tv_series/top_rated_tv_series_notifier.dart';
import 'package:core/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:feature_movie/data/datasources/movie_local_data_source.dart';
import 'package:feature_movie/data/datasources/movie_remote_data_source.dart';
import 'package:feature_movie/data/repositories/movie_repository_impl.dart';
import 'package:feature_movie/domain/repositories/movie_repository.dart';
import 'package:feature_movie/domain/usecases/get_movie_detail.dart';
import 'package:feature_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:feature_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:feature_movie/domain/usecases/get_popular_movies.dart';
import 'package:feature_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_status.dart';
import 'package:feature_movie/domain/usecases/remove_watchlist.dart';
import 'package:feature_movie/domain/usecases/save_watchlist.dart';
import 'package:feature_movie/domain/usecases/search_movies.dart';
import 'package:feature_movie/presentation/bloc/search/search_bloc.dart';
import 'package:feature_movie/presentation/provider/movie_detail_notifier.dart';
import 'package:feature_movie/presentation/provider/movie_list_notifier.dart';
import 'package:feature_movie/presentation/provider/popular_movies_notifier.dart';
import 'package:feature_movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:feature_movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:search/search.dart';

final locator = GetIt.instance;

void init() {
  // region provider
  // region provider : Movie
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
      getPopularTvSeriesUseCase: locator(),
      getTopRatedTvSeriesUseCase: locator(),
      getOnTheAirTvSeriesUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
      getTvSeriesWatchlistUseCase: locator(),
    ),
  );
  // endregion provider : Movie

  // region provider : TvSeries
  locator.registerFactory(
    () => TopRatedTvSeriesNotifier(
      getTopRatedTvSeriesUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesNotifier(
      getPopularTvSeriesUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirTvSeriesNotifier(
      getOnTheAirTvSeriesUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailNotifier(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesSearchNotifier(
      searchTvSeriesUseCase: locator(),
    ),
  );
  // endregion provider : TvSeries
  // region provider

  // region bloc
  locator.registerFactory(() => SearchBloc(locator()));
  // endregion bloc

  // region use case
  // region usecase: movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // endregion usecase: movies

  // region usecase: tv series
  locator.registerLazySingleton(() => GetPopularTvSeriesUseCase(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeriesUseCase(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetailUseCase(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTvSeriesUseCase(locator()));
  locator.registerLazySingleton(
      () => GetRecommendationsTvSeriesUseCase(locator()));
  locator.registerLazySingleton(
      () => GetTvSeriesWatchListStatusUseCase(locator()));
  locator.registerLazySingleton(() => GetTvSeriesWatchlistUseCase(locator()));
  locator
      .registerLazySingleton(() => RemoveTvSeriesWatchlistUseCase(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesWatchlistUseCase(locator()));
  locator.registerLazySingleton(() => SearchTvSeriesUseCase(locator()));
  // endregion usecase: tv series
  // endregion use case

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
