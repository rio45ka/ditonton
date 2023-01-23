import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:core/utils/http_ssl_spinning.dart';
import 'package:core/utils/routes.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:feature_movie/presentation/bloc/detail/detail_movie_bloc.dart';
import 'package:feature_movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:feature_movie/presentation/bloc/popular/popular_movies_bloc.dart';
import 'package:feature_movie/presentation/bloc/recommendations/recommendations_movie_bloc.dart';
import 'package:feature_movie/presentation/bloc/search/search_bloc.dart';
import 'package:feature_movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:feature_movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:feature_movie/presentation/bloc/watchlist_status/watchlist_status_movie_cubit.dart';
import 'package:feature_movie/presentation/pages/home_movie_page.dart';
import 'package:feature_movie/presentation/pages/movie_detail_page.dart';
import 'package:feature_movie/presentation/pages/popular_movies_page.dart';
import 'package:feature_movie/presentation/pages/search_page.dart';
import 'package:feature_movie/presentation/pages/top_rated_movies_page.dart';
import 'package:feature_movie/presentation/pages/watchlist_movies_page.dart';
import 'package:feature_tv/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/on_the_air/on_the_air_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/popular/popular_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/recommendations/recommendations_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/search/search_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/watchlist_status/watchlist_status_tv_cubit.dart';
import 'package:feature_tv/presentation/pages/on_the_air_tv_series_page.dart';
import 'package:feature_tv/presentation/pages/popular_tv_series_page.dart';
import 'package:feature_tv/presentation/pages/top_rated_tv_series_page.dart';
import 'package:feature_tv/presentation/pages/tv_series_detail_page.dart';
import 'package:feature_tv/presentation/pages/tv_series_search_page.dart';
import 'package:feature_tv/presentation/pages/watchlist_tv_page.dart';
import 'package:feature_tv/presentation/pages/home_tv_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<WatchlistStatusMovieCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationsMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationsTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistStatusTvCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HOME_TV_SERIES_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WATCHLIST_MOVIE_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WATCHLIST_TV_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TOP_RATED_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case POPULAR_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case ON_THE_AIR_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => OnTheAirTvSeriesPage());
            case TV_SERIES_DETAIL_ROUTE:
              final tvSeriesId = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: tvSeriesId),
                settings: settings,
              );
            case SEARCH_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => TvSeriesSearchPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
