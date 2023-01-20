import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_series_detail.dart';
import 'package:feature_tv/domain/repositories/tv_series_repository.dart';

class GetTvSeriesDetailUseCase {
  final TvSeriesRepository repository;

  GetTvSeriesDetailUseCase(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
