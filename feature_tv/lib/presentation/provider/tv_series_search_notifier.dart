import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:flutter/foundation.dart';

import '../../domain/usecases/search_tv_series_usecase.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  final SearchTvSeriesUseCase searchTvSeriesUseCase;

  TvSeriesSearchNotifier({required this.searchTvSeriesUseCase});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _searchResult = [];
  List<TvSeries> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeriesUseCase.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
