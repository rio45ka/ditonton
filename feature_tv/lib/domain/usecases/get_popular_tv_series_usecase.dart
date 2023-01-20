import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/repositories/tv_series_repository.dart';

class GetPopularTvSeriesUseCase {
  final TvSeriesRepository repository;

  GetPopularTvSeriesUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getPopularTvSeries();
  }
}
