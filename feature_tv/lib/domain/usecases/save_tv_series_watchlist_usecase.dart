import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_series_detail.dart';
import 'package:feature_tv/domain/repositories/tv_series_repository.dart';

class SaveTvSeriesWatchlistUseCase {
  final TvSeriesRepository repository;

  SaveTvSeriesWatchlistUseCase(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.saveWatchlist(tvSeries);
  }
}
