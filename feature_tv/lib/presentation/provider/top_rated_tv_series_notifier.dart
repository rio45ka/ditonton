import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/usecases/get_top_rated_tv_series_usecase.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvSeriesNotifier extends ChangeNotifier {
  final GetTopRatedTvSeriesUseCase getTopRatedTvSeriesUseCase;

  TopRatedTvSeriesNotifier({required this.getTopRatedTvSeriesUseCase});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeriesList = [];
  List<TvSeries> get tvSeriesList => _tvSeriesList;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeriesUseCase.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvSeriesListData) {
        _tvSeriesList = tvSeriesListData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
