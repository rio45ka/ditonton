import 'package:core/core.dart';
import 'package:feature_tv/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:feature_tv/presentation/widgets/tv_series_card_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvPage extends StatefulWidget {
  WatchlistTvPage({super.key});

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistTvBloc>().add(FetchWatchlistTvSeries()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvBloc>().add(FetchWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (context, state) {
            if (state is WatchlistTvLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WatchlistTvHasDataState) {
              final result = state.result;
              return result.isEmpty
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
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return TvSeriesCardListWidget(result[index]);
                      },
                      itemCount: result.length,
                    );
            } else if (state is WatchlistTvErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is WatchlistTvInitialState) {
              return Container();
            } else {
              return const Center(child: Text('Error BLoC'));
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
