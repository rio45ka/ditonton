import 'package:dartz/dartz.dart';
import '../../entities/tv_series.dart';
import '../../../core.dart';
import '../../repositories/tv_series_repository.dart';

class GetTvSeriesWatchlistUseCase {
  final TvSeriesRepository _repository;

  GetTvSeriesWatchlistUseCase(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTvSeries();
  }
}
