import 'package:core/utils/routes.dart';
import 'package:feature_tv/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:feature_tv/presentation/widgets/tv_series_card_list_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedTvBloc>().add(FetchTopRatedTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_SERIES_ROUTE);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
            if (state is TopRatedTvLoadingState) {
              return const Center(
                key: Key('loading_center'),
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvHasDataState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvSeriesCardListWidget(state.result[index]);
                },
                itemCount: state.result.length,
              );
            } else if (state is TopRatedTvErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
