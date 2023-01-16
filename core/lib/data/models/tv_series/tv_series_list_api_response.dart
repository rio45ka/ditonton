import 'package:equatable/equatable.dart';
import 'tv_series_api_response.dart';

class TvSeriesListApiResponse extends Equatable {
  final List<TvSeriesApiResponse> tvSeriesList;
  TvSeriesListApiResponse({
    required this.tvSeriesList,
  });

  factory TvSeriesListApiResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesListApiResponse(
        tvSeriesList: List<TvSeriesApiResponse>.from(
          (json["results"] as List)
              .map((x) => TvSeriesApiResponse.fromJson(x))
              .where((element) => element.posterPath != null),
        ),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [tvSeriesList];
}
