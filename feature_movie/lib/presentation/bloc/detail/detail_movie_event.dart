part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailMovie extends DetailMovieEvent {
  final int id;

  FetchDetailMovie(this.id);

  @override
  List<Object> get props => [id];
}
