import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:feature_tv/domain/entities/genre.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/entities/tv_series_detail.dart';
import 'package:feature_tv/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/recommendations/recommendations_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/watchlist_status/watchlist_status_tv_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeriesDetailPage extends StatefulWidget {
  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTvBloc>().add(FetchDetailTvSeries(widget.id));
      context
          .read<RecommendationsTvBloc>()
          .add(FetchRecommendationsTvSeries(widget.id));
      context.read<WatchlistStatusTvCubit>().loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTvBloc, DetailTvState>(
        builder: (context, state) {
          if (state is DetailTvLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailTvHasDataState) {
            final tvSeries = state.result;
            return SafeArea(
              child: DetailContentWidget(tvSeries),
            );
          } else if (state is DetailTvErrorState) {
            return Center(
              child: Text(
                state.message,
                key: Key('error_message'),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContentWidget extends StatelessWidget {
  final TvSeriesDetail tvSeriesDetail;

  DetailContentWidget(this.tvSeriesDetail);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeriesDetail.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<WatchlistStatusTvCubit,
                                WatchlistStatusTvState>(
                              builder: (context, state) {
                                bool isAddedWatchlist = state.isAddedWatchlist;
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (!isAddedWatchlist) {
                                      await context
                                          .read<WatchlistStatusTvCubit>()
                                          .addWatchlist(tvSeriesDetail);
                                    } else {
                                      await context
                                          .read<WatchlistStatusTvCubit>()
                                          .removeFromWatchlist(tvSeriesDetail);
                                    }
                                    final message = context
                                        .read<WatchlistStatusTvCubit>()
                                        .state
                                        .message;

                                    if (message ==
                                            WatchlistStatusTvCubit
                                                .watchlistAddSuccessMessage ||
                                        message ==
                                            WatchlistStatusTvCubit
                                                .watchlistRemoveSuccessMessage) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(message)));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(message),
                                            );
                                          });
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedWatchlist
                                          ? Icon(Icons.check)
                                          : Icon(Icons.add),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(tvSeriesDetail.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeriesDetail.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            _buildListTvRecommendations(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  BlocBuilder<RecommendationsTvBloc, RecommendationsTvState>
      _buildListTvRecommendations() {
    return BlocBuilder<RecommendationsTvBloc, RecommendationsTvState>(
      builder: (context, state) {
        if (state is RecommendationsTvLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RecommendationsTvErrorState) {
          return Text(state.message);
        } else if (state is RecommendationsTvHasDataState) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _buildItemTvSeries(
                  context,
                  state.result[index],
                );
              },
              itemCount: state.result.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildItemTvSeries(BuildContext context, TvSeries tvSeries) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            TV_SERIES_DETAIL_ROUTE,
            arguments: tvSeries.id,
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(140),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16.0),
                  topLeft: Radius.circular(16.0),
                ),
              ),
              child: Text(
                'Tv Series',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
