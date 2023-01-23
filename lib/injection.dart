import 'package:core/database/database_helper.dart';
import 'package:feature_movie/presentation/bloc/detail/detail_movie_bloc.dart';
import 'package:feature_movie/presentation/bloc/popular/popular_movies_bloc.dart';
import 'package:feature_movie/presentation/bloc/recommendations/recommendations_movie_bloc.dart';
import 'package:feature_movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:feature_tv/data/datasources/tv_series_local_data_source.dart';
import 'package:feature_tv/data/datasources/tv_series_remote_data_source.dart';
import 'package:feature_tv/data/repositories/tv_series_repository_impl.dart';
import 'package:feature_tv/domain/repositories/tv_series_repository.dart';
import 'package:feature_tv/domain/usecases/get_on_the_air_tv_series_usecase.dart';
import 'package:feature_tv/domain/usecases/get_popular_tv_series_usecase.dart';
import 'package:feature_tv/domain/usecases/get_top_rated_tv_series_usecase.dart';
import 'package:feature_tv/domain/usecases/get_tv_series_detail_usecase.dart';
import 'package:feature_tv/domain/usecases/get_recommendations_tv_series_usecase.dart';
import 'package:feature_tv/domain/usecases/get_tv_series_watchlist_status_usecase.dart';
import 'package:feature_tv/domain/usecases/get_tv_series_watchlist_usecase.dart';
import 'package:feature_tv/domain/usecases/remove_tv_series_watchlist_usecase.dart';
import 'package:feature_tv/domain/usecases/save_tv_series_watchlist_usecase.dart';
import 'package:feature_tv/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/on_the_air/on_the_air_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/recommendations/recommendations_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/search/search_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/watchlist_status/watchlist_status_tv_cubit.dart';
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
import 'package:feature_movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:feature_tv/presentation/bloc/popular/popular_tv_bloc.dart';
import 'package:feature_movie/presentation/provider/movie_detail_notifier.dart';
import 'package:feature_movie/presentation/provider/movie_list_notifier.dart';
import 'package:feature_movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:feature_tv/domain/usecases/search_tv_series_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

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
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
      getTvSeriesWatchlistUseCase: locator(),
    ),
  );
  // endregion provider : Movie
  // endregion provider

  // region bloc
  // region bloc: movie
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => RecommendationsMovieBloc(locator()));
  locator.registerFactory(() => DetailMovieBloc(locator()));
  // endregion bloc: movie

  // region bloc: tv series
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => OnTheAirTvBloc(locator()));
  locator.registerFactory(() => DetailTvBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(locator()));
  locator.registerFactory(() => RecommendationsTvBloc(locator()));
  locator.registerFactory(
    () => WatchlistStatusTvCubit(
      getTvSeriesWatchListStatusUseCase: locator(),
      saveTvSeriesWatchlistUseCase: locator(),
      removeTvSeriesWatchlistUseCase: locator(),
    ),
  );
  // endregion bloc: tv series
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
