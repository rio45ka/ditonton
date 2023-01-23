part of 'watchlist_status_movie_cubit.dart';

class WatchlistStatusMovieState extends Equatable {
  final bool isAddedWatchlist;
  final String message;

  const WatchlistStatusMovieState({
    required this.isAddedWatchlist,
    required this.message,
  });

  @override
  List<Object> get props => [isAddedWatchlist];
}
