import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:feature_tv/presentation/widgets/tv_series_list_horizontal_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/movie.dart';
import '../provider/movie_list_notifier.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies()
          ..fetchPopularTvSeries()
          ..fetchTopRatedTvSeries()
          ..fetchOnTheAirTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_MOVIE_ROUTE);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, SEARCH_TV_SERIES_ROUTE);
              },
              leading: Icon(Icons.search),
              title: Text('Search Tv Series'),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                'Now Playing',
                style: kHeading6,
              ),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return MovieList(data.nowPlayingMovies);
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.popularMoviesState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return MovieList(data.popularMovies);
              } else {
                return Text('Failed');
              }
            }),
            const SizedBox(height: 16.0),
            _buildContentTvSeries(context),
            const SizedBox(height: 8.0),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, TOP_RATED_ROUTE),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.topRatedMoviesState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return MovieList(data.topRatedMovies);
              } else {
                return Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildContentTvSeries(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSubHeading(
            title: 'Top Rated Tv Series',
            inversColor: true,
            onTap: () =>
                Navigator.pushNamed(context, TOP_RATED_TV_SERIES_ROUTE),
          ),
          Consumer<MovieListNotifier>(builder: (context, data, child) {
            final state = data.topRatedTvSeriesState;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return TvSeriesListHorizontalWidget(data.topRatedTvSeries);
            } else {
              return Text('Failed');
            }
          }),
          _buildSubHeading(
            title: 'Popular Tv Series',
            inversColor: true,
            onTap: () => Navigator.pushNamed(
              context,
              POPULAR_TV_SERIES_ROUTE,
            ),
          ),
          Consumer<MovieListNotifier>(builder: (context, data, child) {
            final state = data.popularTvSeriesState;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return TvSeriesListHorizontalWidget(data.popularTvSeries);
            } else {
              return Text('Failed');
            }
          }),
          _buildSubHeading(
            title: 'On The Air Tv Series',
            inversColor: true,
            onTap: () => Navigator.pushNamed(
              context,
              ON_THE_AIR_TV_SERIES_ROUTE,
            ),
          ),
          Consumer<MovieListNotifier>(builder: (context, data, child) {
            final state = data.onTheAirTvSeriesState;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return TvSeriesListHorizontalWidget(data.onTheAirTvSeries);
            } else {
              return Text('Failed');
            }
          }),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget _buildSubHeading(
      {required String title,
      required Function() onTap,
      bool inversColor = false}) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kHeading6.copyWith(
              color: inversColor == true ? Colors.black : Colors.white,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  'See More',
                  style: TextStyle(
                    color: inversColor == true ? Colors.black : Colors.white,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: inversColor == true ? Colors.black : Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL_ROUTE,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
