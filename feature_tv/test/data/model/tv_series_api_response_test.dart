import 'package:feature_tv/data/model/tv_series_api_response.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesApiResponse = TvSeriesApiResponse(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: const ['US'],
    originalLanguage: 'en',
    originalName: 'name',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeriesNullGenreOriginCountryApiResponse = TvSeriesApiResponse(
    backdropPath: 'backdropPath',
    genreIds: null,
    id: 1,
    name: 'name',
    originCountry: null,
    originalLanguage: 'en',
    originalName: 'name',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'name',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeriesNullGenreOriginCountry = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: null,
    id: 1,
    name: 'name',
    originCountry: null,
    originalLanguage: 'en',
    originalName: 'name',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of TvSeries entity', () async {
    final result = tTvSeriesApiResponse.toEntityModel();
    expect(result, tTvSeries);
  });

  test(
      'should be a subclass of TvSeries entity (genre and origin country null)',
      () async {
    final result = tTvSeriesNullGenreOriginCountryApiResponse.toEntityModel();
    expect(result, tTvSeriesNullGenreOriginCountry);
  });
}
