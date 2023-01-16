import 'package:dartz/dartz.dart';
import '../../../core.dart';
import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';

class GetRecommendationsTvSeriesUseCase {
  final TvSeriesRepository repository;

  GetRecommendationsTvSeriesUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
