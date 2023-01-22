import 'package:flutter/material.dart';
import 'package:core/utils/routes.dart';
import 'package:feature_tv/presentation/bloc/popular/popular_tv_bloc.dart';
import 'package:feature_tv/presentation/widgets/tv_series_card_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvBloc>().add(FetchPopularTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
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
        child: BlocBuilder<PopularTvBloc, PopularTvState>(
          builder: (context, state) {
            if (state is PopularTvLoadingState) {
              return const Center(
                key: Key('loading_center'),
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvHasDataState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvSeriesCardListWidget(state.result[index]);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularTvErrorState) {
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
