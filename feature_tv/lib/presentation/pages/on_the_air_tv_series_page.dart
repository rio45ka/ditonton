import 'package:core/utils/routes.dart';
import 'package:feature_tv/presentation/bloc/on_the_air/on_the_air_tv_bloc.dart';
import 'package:feature_tv/presentation/widgets/tv_series_card_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnTheAirTvSeriesPage extends StatefulWidget {
  @override
  _OnTheAirTvSeriesPageState createState() => _OnTheAirTvSeriesPageState();
}

class _OnTheAirTvSeriesPageState extends State<OnTheAirTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<OnTheAirTvBloc>().add(FetchOnTheAirTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air Tv Series'),
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
        child: BlocBuilder<OnTheAirTvBloc, OnTheAirTvState>(
          builder: (context, state) {
            if (state is OnTheAirTvLoadingState) {
              return const Center(
                key: Key('loading_center'),
                child: CircularProgressIndicator(),
              );
            } else if (state is OnTheAirTvHasDataState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvSeriesCardListWidget(state.result[index]);
                },
                itemCount: state.result.length,
              );
            } else if (state is OnTheAirTvErrorState) {
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
