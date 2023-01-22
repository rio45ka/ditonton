import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:feature_tv/presentation/bloc/on_the_air/on_the_air_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/popular/popular_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:feature_tv/presentation/widgets/tv_series_list_horizontal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({super.key});

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<OnTheAirTvBloc>().add(FetchOnTheAirTvSeries());
        context.read<PopularTvBloc>().add(FetchPopularTvSeries());
        context.read<TopRatedTvBloc>().add(FetchTopRatedTvSeries());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_SERIES_ROUTE);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubHeading(
                  title: 'Top Rated Tv Series',
                  onTap: () =>
                      Navigator.pushNamed(context, TOP_RATED_TV_SERIES_ROUTE),
                ),
                const SizedBox(height: 8.0),
                BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                    builder: (context, state) {
                  if (state is TopRatedTvLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TopRatedTvHasDataState) {
                    return TvSeriesListHorizontalWidget(state.result);
                  } else if (state is TopRatedTvErrorState) {
                    return Center(child: Text(state.message));
                  } else if (state is TopRatedTvInitialState) {
                    return Container();
                  } else {
                    return const Text('Error');
                  }
                }),
                _buildSubHeading(
                  title: 'Popular Tv Series',
                  onTap: () =>
                      Navigator.pushNamed(context, POPULAR_TV_SERIES_ROUTE),
                ),
                const SizedBox(height: 8.0),
                BlocBuilder<PopularTvBloc, PopularTvState>(
                    builder: (context, state) {
                  if (state is PopularTvLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PopularTvHasDataState) {
                    return TvSeriesListHorizontalWidget(state.result);
                  } else if (state is PopularTvErrorState) {
                    return Center(child: Text(state.message));
                  } else if (state is PopularTvInitialState) {
                    return Container();
                  } else {
                    return const Text('Error');
                  }
                }),
                _buildSubHeading(
                  title: 'On The Air Tv Series',
                  onTap: () =>
                      Navigator.pushNamed(context, ON_THE_AIR_TV_SERIES_ROUTE),
                ),
                const SizedBox(height: 8.0),
                BlocBuilder<OnTheAirTvBloc, OnTheAirTvState>(
                    builder: (context, state) {
                  if (state is OnTheAirTvLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is OnTheAirTvHasDataState) {
                    return TvSeriesListHorizontalWidget(state.result);
                  } else if (state is OnTheAirTvErrorState) {
                    return Center(child: Text(state.message));
                  } else if (state is OnTheAirTvInitialState) {
                    return Container();
                  } else {
                    return const Text('Error');
                  }
                }),
              ],
            ),
          ),
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
