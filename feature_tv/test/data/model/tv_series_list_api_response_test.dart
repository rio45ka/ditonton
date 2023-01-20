import 'dart:convert';

import 'package:feature_tv/data/model/tv_series_api_response.dart';
import 'package:feature_tv/data/model/tv_series_list_api_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  final tTvSeriesApiResponse = TvSeriesApiResponse(
    backdropPath: "/iHSwvRVsRyxpX7FE7GbviaDvgGZ.jpg",
    genreIds: const [10765, 9648, 35],
    id: 119051,
    name: "Wednesday",
    originCountry: const ["US"],
    originalLanguage: "en",
    originalName: "Wednesday",
    overview:
        "After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means...",
    popularity: 2666.909,
    posterPath: "/9PFonBhy4cQy7Jz20NpMygczOkv.jpg",
    voteAverage: 8.7,
    voteCount: 5142,
  );

  final tTvSeriesListApiResponseModel = TvSeriesListApiResponse(
    tvSeriesList: <TvSeriesApiResponse>[tTvSeriesApiResponse],
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_popular.json'));
      // act
      final result = TvSeriesListApiResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesListApiResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesListApiResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/iHSwvRVsRyxpX7FE7GbviaDvgGZ.jpg",
            "genre_ids": [10765, 9648, 35],
            "id": 119051,
            "name": "Wednesday",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Wednesday",
            "overview":
                "After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means...",
            "popularity": 2666.909,
            "poster_path": "/9PFonBhy4cQy7Jz20NpMygczOkv.jpg",
            "vote_average": 8.7,
            "vote_count": 5142
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
