import 'package:dartz/dartz.dart';
import '../../../core.dart';
import '../../entities/tv_series_detail.dart';
import '../../repositories/tv_series_repository.dart';

class RemoveTvSeriesWatchlistUseCase {
  final TvSeriesRepository repository;

  RemoveTvSeriesWatchlistUseCase(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.removeWatchlist(tvSeries);
  }
}
