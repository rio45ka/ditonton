import '../../repositories/tv_series_repository.dart';

class GetTvSeriesWatchListStatusUseCase {
  final TvSeriesRepository repository;

  GetTvSeriesWatchListStatusUseCase(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
