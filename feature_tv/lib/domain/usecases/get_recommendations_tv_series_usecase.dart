import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/repositories/tv_series_repository.dart';

class GetRecommendationsTvSeriesUseCase {
  final TvSeriesRepository repository;

  GetRecommendationsTvSeriesUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
