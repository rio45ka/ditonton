import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tv_series/tv_series_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

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
