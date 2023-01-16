import 'package:dartz/dartz.dart';
import '../../entities/tv_series_detail.dart';
import '../../../core.dart';
import '../../repositories/tv_series_repository.dart';

class GetTvSeriesDetailUseCase {
  final TvSeriesRepository repository;

  GetTvSeriesDetailUseCase(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
