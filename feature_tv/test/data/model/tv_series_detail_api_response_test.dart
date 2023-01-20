import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:feature_tv/data/model/tv_series_detail_api_response.dart';
import 'package:feature_tv/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesDetailApiResponse = TvSeriesDetailApiResponse(
    adult: false,
    backdropPath: '/yXSzo0VU1Q1QaB7Xg5Hqe4tXXA3.jpg',
    genres: [
      GenreModel(
        id: 18,
        name: 'Drama',
      ),
    ],
    id: 1396,
    originCountry: const ['US'],
    name: 'Breaking Bad',
    originalLanguage: 'en',
    originalName: 'Breaking Bad',
    overview:
        'When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family\'s financial future at any cost as he enters the dangerous world of drugs and crime.',
    popularity: 383.111,
    posterPath: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
    voteAverage: 8.862,
    voteCount: 10875,
  );

  final tTvSeriesDetailNullOriginCountryApiResponse = TvSeriesDetailApiResponse(
    adult: false,
    backdropPath: '/yXSzo0VU1Q1QaB7Xg5Hqe4tXXA3.jpg',
    genres: [
      GenreModel(
        id: 18,
        name: 'Drama',
      ),
    ],
    id: 1396,
    originCountry: null,
    name: 'Breaking Bad',
    originalLanguage: 'en',
    originalName: 'Breaking Bad',
    overview:
        'When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family\'s financial future at any cost as he enters the dangerous world of drugs and crime.',
    popularity: 383.111,
    posterPath: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
    voteAverage: 8.862,
    voteCount: 10875,
  );

  final tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: '/yXSzo0VU1Q1QaB7Xg5Hqe4tXXA3.jpg',
    genres: [Genre(id: 18, name: 'Drama')],
    id: 1396,
    name: 'Breaking Bad',
    originalLanguage: 'en',
    originalName: 'Breaking Bad',
    overview:
        'When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family\'s financial future at any cost as he enters the dangerous world of drugs and crime.',
    popularity: 383.111,
    posterPath: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
    voteAverage: 8.862,
    voteCount: 10875,
  );

  test('should be a subclass of TvSeriesDetail entity', () async {
    final result = tTvSeriesDetailApiResponse.toEntityModel();
    expect(result, tTvSeriesDetail);
  });

  test('should be a subclass of TvSeriesDetail entity (origin Country null)',
      () async {
    final result = tTvSeriesDetailNullOriginCountryApiResponse.toEntityModel();
    expect(result, tTvSeriesDetail);
  });
}
