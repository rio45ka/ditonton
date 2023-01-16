import 'package:dartz/dartz.dart';
import '../../../core.dart';
import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';

class GetTopRatedTvSeriesUseCase {
  final TvSeriesRepository repository;

  GetTopRatedTvSeriesUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
