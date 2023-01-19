import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/presentation/widgets/tv_series_card_grid_widget.dart';
import 'package:core/utils/routes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/movie.dart';
import '../provider/watchlist_movie_notifier.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({super.key});

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<WatchlistMovieNotifier>(context, listen: false)
          ..fetchWatchlistMovies()
          ..fetchWatchlistTvSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<WatchlistMovieNotifier>(
              builder: (context, data, child) {
                if (data.watchlistState == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.watchlistState == RequestState.Loaded) {
                  return _buildListMovie(data.watchlistMovies);
                } else {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(data.message),
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            Consumer<WatchlistMovieNotifier>(
              builder: (context, data, child) {
                if (data.watchlistTvSeriesState == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.watchlistTvSeriesState == RequestState.Loaded) {
                  return _buildListTvSeries(data.watchlistTvSeries);
                } else {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(data.message),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Widget _buildListMovie(List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Movie Watchlist',
            style: kHeading6.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        movies.isEmpty
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : SizedBox(
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          child: CachedNetworkImage(
                            imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: movies.length,
                ),
              ),
      ],
    );
  }

  Widget _buildListTvSeries(List<TvSeries> tvSeriesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Tv Series Watchlist',
            style: kHeading6.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        tvSeriesList.isEmpty
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TvSeriesCardGridWidget(
                      tvSeries: tvSeriesList[index],
                    );
                  },
                  itemCount: tvSeriesList.length,
                ),
              ),
      ],
    );
  }
}
