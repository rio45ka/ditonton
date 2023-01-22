import 'package:feature_movie/presentation/bloc/popular/popular_movies_bloc.dart';
import 'package:feature_movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularMoviesBloc>().add(FetchPopularMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoadingState) {
              return Center(
                key: Key('loading_center'),
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesHasDataState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieCard(state.result[index]);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularMoviesErrorState) {
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
