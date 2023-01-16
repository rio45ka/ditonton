import 'package:dartz/dartz.dart';
import '../../../core.dart';
import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';

class GetOnTheAirTvSeriesUseCase {
  final TvSeriesRepository repository;

  GetOnTheAirTvSeriesUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getOnTheAirTvSeries();
  }
}
