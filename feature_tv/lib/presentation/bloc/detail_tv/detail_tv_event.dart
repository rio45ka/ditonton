part of 'detail_tv_bloc.dart';

abstract class DetailTvEvent extends Equatable {
  const DetailTvEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailTvSeries extends DetailTvEvent {
  final int id;

  const FetchDetailTvSeries(this.id);

  @override
  List<Object> get props => [id];
}
