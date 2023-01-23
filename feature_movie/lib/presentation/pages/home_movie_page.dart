import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:feature_movie/presentation/bloc/popular/popular_movies_bloc.dart';
import 'package:feature_movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
      context.read<PopularMoviesBloc>().add(FetchPopularMovies());
      context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());
    });
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
              leading: Icon(Icons.home),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, HOME_TV_SERIES_ROUTE);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Movies'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_MOVIE_ROUTE);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_TV_ROUTE);
              },
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
            BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                builder: (context, state) {
              if (state is NowPlayingMoviesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NowPlayingMoviesHasDataState) {
                return MovieList(state.result);
              } else if (state is NowPlayingMoviesErrorState) {
                return Center(child: Text(state.message));
              } else if (state is NowPlayingMoviesInitialState) {
                return Container();
              } else {
                return const Text('Error');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE),
            ),
            BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
              if (state is PopularMoviesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PopularMoviesHasDataState) {
                return MovieList(state.result);
              } else if (state is PopularMoviesErrorState) {
                return Center(child: Text(state.message));
              } else if (state is PopularMoviesInitialState) {
                return Container();
              } else {
                return const Text('Error');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, TOP_RATED_ROUTE),
            ),
            BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                builder: (context, state) {
              if (state is TopRatedMoviesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TopRatedMoviesHasDataState) {
                return MovieList(state.result);
              } else if (state is TopRatedMoviesErrorState) {
                return Center(child: Text(state.message));
              } else if (state is TopRatedMoviesInitialState) {
                return Container();
              } else {
                return const Text('Error');
              }
            }),
          ],
        ),
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
