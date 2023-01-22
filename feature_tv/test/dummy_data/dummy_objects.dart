import 'package:feature_tv/data/model/tv_series_table.dart';
import 'package:feature_tv/domain/entities/genre.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:feature_tv/domain/entities/tv_series_detail.dart';

final testTvSeries = TvSeries(
  backdropPath: '/yXSzo0VU1Q1QaB7Xg5Hqe4tXXA3.jpg',
  genreIds: [18],
  id: 1396,
  name: 'Breaking Bad',
  originCountry: ["US"],
  originalLanguage: 'en',
  originalName: 'Breaking Bad',
  overview:
      'When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family\'s financial future at any cost as he enters the dangerous world of drugs and crime.',
  popularity: 383.111,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  voteAverage: 8.9,
  voteCount: 10873,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
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

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1396,
  name: 'Breaking Bad',
  posterPath: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
  overview:
      'When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family\'s financial future at any cost as he enters the dangerous world of drugs and crime.',
);

final testTvSeriesTable = TvSeriesTable(
  id: 1396,
  title: 'Breaking Bad',
  posterPath: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
  overview:
      'When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family\'s financial future at any cost as he enters the dangerous world of drugs and crime.',
);

final testTvSeriesMap = {
  'id': 1396,
  'title': 'Breaking Bad',
  'posterPath': '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
  'overview':
      'When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family\'s financial future at any cost as he enters the dangerous world of drugs and crime.',
};
